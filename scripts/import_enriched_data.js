/**
 * Script per importare i dati arricchiti dal JSON in Supabase
 * Estrae solo i dati che creano valore per l'utente finale
 */

const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

// Supabase config
const SUPABASE_URL = 'https://jfcwreeugwpkjywhahqn.supabase.co';
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY; // Usa service key per write

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// Mapping Spoke -> Cluster
const SPOKE_TO_CLUSTER = {
  1: 'Climate',
  2: 'Circular', // Energy anche ma principalmente Circular
  3: 'Energy',
  4: 'AgriFood',
  5: 'Cultural',
  6: 'Health'
};

// Leggi il JSON
const jsonPath = '/Users/carmelogrowthers/Documents/ClaudeCode/Tech4You/DEMOS_FULL_v3.json';
const data = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));

async function importData() {
  const pilotProjects = data.pilot_projects;
  const updates = [];

  console.log('=== Inizio Import Dati Arricchiti ===\n');

  for (const [ppCode, ppData] of Object.entries(pilotProjects)) {
    const spoke = ppData.spoke;
    const cluster = SPOKE_TO_CLUSTER[spoke];
    const ppTags = ppData.tags || [];
    const impatti = ppData.impatti_previsti || '';

    const demos = ppData.demonstrators || [];

    for (const demo of demos) {
      const demoId = demo.demo_id;
      const nome = demo.nome;

      // Estrai dati di valore
      const enrichedData = {
        // Dati base migliorati
        descrizione_estesa: demo.descrizione || null,
        trl: demo.trl_finale || null,
        tipo_dimostratore: demo.tipo_dimostratore || null,

        // Credibilità e team
        responsabile: demo.responsabile || null,
        affiliazione: demo.affiliazione || null,

        // Maturità
        trl_finale: demo.trl_finale || null,
        completamento_percentuale: demo.completamento_percentuale || null,

        // Contesto
        tags: ppTags.length > 0 ? ppTags : null,
        impatti_previsti: impatti || null,

        // Cluster e Spoke
        cluster: cluster,
        spoke: spoke,
        pp_original: ppCode
      };

      // Estrai dati ecomondo se disponibili (alto valore!)
      const eco = demo.ecomondo_profile;
      if (eco) {
        // Market targets - chi può beneficiarne
        if (eco.market_targets && eco.market_targets.length > 0) {
          enrichedData.market_targets = eco.market_targets.map(t => ({
            segment: t.segment,
            description: t.description
          }));
        }

        // Vantaggi competitivi - perché scegliere questa tecnologia
        if (eco.competitive_advantage && eco.competitive_advantage.length > 0) {
          enrichedData.competitive_advantages = eco.competitive_advantage;
        }
      }

      // Genera sfida_risolta dai tags e impatti
      if (!enrichedData.sfida_risolta && ppTags.length > 0) {
        enrichedData.sfida_risolta = generateChallenge(ppTags, cluster, impatti);
      }

      updates.push({
        demoId,
        nome,
        data: enrichedData
      });
    }
  }

  console.log(`Trovati ${updates.length} demo da aggiornare\n`);

  // Aggiorna in Supabase
  let updated = 0;
  let errors = 0;

  for (const update of updates) {
    // Prima cerca per demo_id
    const { data: existing, error: searchError } = await supabase
      .from('tecnologie')
      .select('id, nome')
      .eq('demo_id', update.demoId)
      .single();

    if (existing) {
      // Aggiorna record esistente
      const { error } = await supabase
        .from('tecnologie')
        .update(update.data)
        .eq('id', existing.id);

      if (error) {
        console.log(`❌ Errore aggiornamento ${update.demoId}: ${error.message}`);
        errors++;
      } else {
        console.log(`✅ Aggiornato: ${update.nome}`);
        updated++;
      }
    } else {
      // Cerca per nome simile
      const { data: byName } = await supabase
        .from('tecnologie')
        .select('id, nome')
        .ilike('nome', `%${update.nome.substring(0, 30)}%`)
        .limit(1)
        .single();

      if (byName) {
        const { error } = await supabase
          .from('tecnologie')
          .update(update.data)
          .eq('id', byName.id);

        if (error) {
          console.log(`❌ Errore aggiornamento ${update.nome}: ${error.message}`);
          errors++;
        } else {
          console.log(`✅ Aggiornato (by name): ${update.nome}`);
          updated++;
        }
      } else {
        // Inserisci nuovo record
        const insertData = {
          nome: update.nome,
          demo_id: update.demoId,
          ...update.data
        };

        const { error } = await supabase
          .from('tecnologie')
          .insert([insertData]);

        if (error) {
          console.log(`❌ Errore inserimento ${update.nome}: ${error.message}`);
          errors++;
        } else {
          console.log(`🆕 Inserito: ${update.nome}`);
          updated++;
        }
      }
    }
  }

  console.log(`\n=== Completato ===`);
  console.log(`Aggiornati/Inseriti: ${updated}`);
  console.log(`Errori: ${errors}`);
}

// Genera una sfida/problema risolta basata sui tags
function generateChallenge(tags, cluster, impatti) {
  const challenges = {
    'Climate': {
      'Rischio Frana': 'Prevenzione e monitoraggio del rischio frana',
      'Rischio Idrologico': 'Previsione e gestione del rischio alluvioni',
      'Allerta': 'Sistema di early warning per eventi climatici estremi',
      'Monitoraggio': 'Monitoraggio ambientale in tempo reale',
      'default': 'Gestione e mitigazione del rischio climatico'
    },
    'Circular': {
      'Sostenibilità': 'Economia circolare e riduzione degli sprechi',
      'Risorse Idriche': 'Gestione sostenibile delle risorse idriche',
      'Riciclo': 'Recupero e valorizzazione dei materiali',
      'default': 'Transizione verso modelli di economia circolare'
    },
    'Energy': {
      'Efficienza': 'Ottimizzazione dell\'efficienza energetica',
      'Rinnovabili': 'Integrazione delle energie rinnovabili',
      'Storage': 'Stoccaggio e gestione dell\'energia',
      'default': 'Transizione energetica sostenibile'
    },
    'AgriFood': {
      'Precision': 'Agricoltura di precisione per ridurre sprechi',
      'Tracciabilità': 'Tracciabilità della filiera alimentare',
      'Irrigazione': 'Ottimizzazione delle risorse idriche in agricoltura',
      'default': 'Innovazione sostenibile in agricoltura'
    },
    'Cultural': {
      'Digital': 'Digitalizzazione del patrimonio culturale',
      'Turismo': 'Valorizzazione turistica intelligente',
      'Conservazione': 'Conservazione e restauro innovativo',
      'default': 'Valorizzazione digitale del patrimonio culturale'
    },
    'Health': {
      'Bioattivi': 'Estrazione di composti bioattivi dagli scarti',
      'Nutraceutica': 'Sviluppo di prodotti nutraceutici',
      'Scarti': 'Valorizzazione degli scarti agro-alimentari',
      'default': 'Innovazione per la salute e il benessere'
    }
  };

  const clusterChallenges = challenges[cluster] || {};

  for (const tag of tags) {
    for (const [keyword, challenge] of Object.entries(clusterChallenges)) {
      if (tag.toLowerCase().includes(keyword.toLowerCase())) {
        return challenge;
      }
    }
  }

  return clusterChallenges.default || 'Innovazione tecnologica per lo sviluppo sostenibile';
}

// Esegui
importData().catch(console.error);
