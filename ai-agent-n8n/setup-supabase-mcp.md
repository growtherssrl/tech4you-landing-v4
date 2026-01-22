# Setup Supabase MCP - Tech4YouAssistant

## Project Info
- **Project Name**: Tech4YouAssistant
- **Project Ref**: `jfcwreeugwpkjywhahqn`
- **MCP URL**: `https://mcp.supabase.com/mcp?project_ref=jfcwreeugwpkjywhahqn`

---

## 1. Configura Claude Desktop

### macOS
Modifica il file:
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

### Contenuto:
```json
{
  "mcpServers": {
    "supabase": {
      "type": "http",
      "url": "https://mcp.supabase.com/mcp?project_ref=jfcwreeugwpkjywhahqn&features=database,docs"
    }
  }
}
```

### Dopo la modifica:
1. Chiudi completamente Claude Desktop
2. Riapri Claude Desktop
3. Al primo uso, ti chiederà di autenticarti con Supabase

---

## 2. Verifica Connessione

Una volta autenticato, chiedi a Claude:

```
Mostrami tutte le tabelle nel database Supabase
```

Se funziona, vedrai la risposta con le tabelle (probabilmente vuote all'inizio).

---

## 3. Crea Schema Database

Copia e incolla questo in Claude Desktop per creare le tabelle:

```
Esegui queste migrazioni SQL nel mio progetto Supabase per creare lo schema Tech4You:

-- 1. Tabella Tecnologie
CREATE TABLE IF NOT EXISTS tecnologie (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  cluster VARCHAR(50) NOT NULL CHECK (cluster IN ('Energy', 'Circular', 'Climate', 'AgriFood', 'Cultural', 'Health')),
  trl INTEGER CHECK (trl BETWEEN 1 AND 9),
  descrizione_breve VARCHAR(200),
  descrizione_estesa TEXT,
  sfida_risolta VARCHAR(255),
  metriche_impatto VARCHAR(255),
  status VARCHAR(50) DEFAULT 'Disponibile',
  team_ricerca VARCHAR(255),
  brevetti INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Tabella Servizi
CREATE TABLE IF NOT EXISTS servizi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  target VARCHAR(50) CHECK (target IN ('Industrial', 'Investor', 'Both')),
  descrizione TEXT,
  durata VARCHAR(100),
  output VARCHAR(255),
  prezzo VARCHAR(100),
  cta_text VARCHAR(100),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tabella Eventi
CREATE TABLE IF NOT EXISTS eventi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  data DATE NOT NULL,
  location VARCHAR(255),
  posti_disponibili INTEGER,
  target VARCHAR(50) CHECK (target IN ('Industrial', 'Investor', 'Both')),
  descrizione TEXT,
  programma TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Tabella FAQ
CREATE TABLE IF NOT EXISTS faq (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  categoria VARCHAR(100),
  domanda TEXT NOT NULL,
  risposta TEXT NOT NULL,
  ordine INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Tabella Leads
CREATE TABLE IF NOT EXISTS leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id VARCHAR(255),
  nome VARCHAR(255),
  email VARCHAR(255),
  telefono VARCHAR(50),
  azienda VARCHAR(255),
  ruolo VARCHAR(255),
  tipo VARCHAR(50) CHECK (tipo IN ('Industrial', 'Investor')),
  cluster_interesse VARCHAR(50),
  sfida TEXT,
  note TEXT,
  score VARCHAR(20) DEFAULT 'WARM' CHECK (score IN ('HOT', 'WARM', 'COLD')),
  source VARCHAR(100) DEFAULT 'chatbot',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Tabella Chat History (per analytics)
CREATE TABLE IF NOT EXISTS chat_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id VARCHAR(255) NOT NULL,
  role VARCHAR(20) CHECK (role IN ('user', 'assistant')),
  content TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indici per performance
CREATE INDEX IF NOT EXISTS idx_tecnologie_cluster ON tecnologie(cluster);
CREATE INDEX IF NOT EXISTS idx_tecnologie_status ON tecnologie(status);
CREATE INDEX IF NOT EXISTS idx_leads_tipo ON leads(tipo);
CREATE INDEX IF NOT EXISTS idx_leads_score ON leads(score);
CREATE INDEX IF NOT EXISTS idx_chat_history_session ON chat_history(session_id);
CREATE INDEX IF NOT EXISTS idx_faq_categoria ON faq(categoria);
```

---

## 4. Inserisci Dati di Base

### Servizi

```
Inserisci questi servizi nella tabella servizi:

1. Climate Innovation Assessment
   - target: Industrial
   - descrizione: Analisi delle sfide aziendali e matching con tecnologie Tech4You. Include mappatura processi, identificazione opportunità, e roadmap implementazione.
   - durata: 45 minuti
   - output: Report con 3-5 tecnologie raccomandate + next steps
   - prezzo: Gratuito
   - cta_text: Prenota Assessment

2. Investor Briefing
   - target: Investor
   - descrizione: Presentazione deal flow personalizzata con shortlist tecnologie, schede IP, metriche team, e intro diretta ai founder.
   - durata: 30 minuti
   - output: Shortlist 5-10 deal + due diligence kit
   - prezzo: Gratuito
   - cta_text: Richiedi Briefing

3. POC Program
   - target: Industrial
   - descrizione: Programma di Proof of Concept per testare tecnologie in ambiente reale. Include setup, supporto tecnico, e valutazione risultati.
   - durata: 3-6 mesi
   - output: Report POC con metriche e raccomandazioni scale-up
   - prezzo: Su progetto
   - cta_text: Richiedi Info

4. Technology Scouting
   - target: Both
   - descrizione: Ricerca tecnologie specifiche nel network Tech4You basata su requisiti custom.
   - durata: 2-4 settimane
   - output: Shortlist tecnologie + schede comparative
   - prezzo: Su progetto
   - cta_text: Contattaci
```

### Evento

```
Inserisci questo evento nella tabella eventi:

- nome: Tech4You Climate Innovation Day
- data: 2026-02-15
- location: Milano Bicocca
- posti_disponibili: 80
- target: Both
- descrizione: Technology showcase dei 6 cluster con demo live, panel con ricercatori e imprese, speed matching facilitato.
- programma: 09:00 Welcome | 09:30 Keynote | 10:30 Cluster Showcase | 12:30 Networking Lunch | 14:00 Deep Dive Sessions | 16:00 Speed Matching | 17:30 Closing
```

### FAQ Base

```
Inserisci queste FAQ nella tabella faq:

Categoria: Generale
1. Cos'è Tech4You?
   Tech4You è l'Ecosistema d'Innovazione sul Climate Change, parte del programma PNRR. Connette 120 tecnologie avanzate TRL 6-9, 433 ricercatori, e 93 imprese per trasformare le sfide climatiche in vantaggi competitivi.

2. Quali sono i 6 cluster tecnologici?
   I cluster sono: Energy (efficienza energetica e rinnovabili), Circular (economia circolare e risorse idriche), Climate (rischio climatico e monitoraggio), AgriFood (agricoltura di precisione), Cultural (patrimonio culturale), Health (salute e nutraceutica).

3. Cosa significa TRL?
   Technology Readiness Level, scala da 1 a 9 che indica la maturità di una tecnologia. TRL 6-9 significa che le tecnologie sono validate in ambiente operativo e pronte per test industriali o mercato.

Categoria: Per Aziende
4. Come posso accedere alle tecnologie?
   Il primo step è un Climate Innovation Assessment gratuito di 45 minuti dove analizziamo le tue sfide e identifichiamo le tecnologie più rilevanti.

5. Quanto costa un POC?
   I costi variano in base alla complessità. Molti POC sono co-finanziati attraverso bandi PNRR, Horizon Europe o accordi per l'innovazione.

6. Quali settori industriali supportate?
   Supportiamo tutti i settori impattati dal climate change: manifatturiero, energy, utility, food & beverage, agricoltura, turismo, PA, e altri.

Categoria: Per Investitori
7. Che tipo di deal flow offrite?
   Offriamo accesso a 120 tecnologie pre-screened con IP validato, TRL 6-9, team accademici pronti per spin-off o licensing.

8. Come funziona l'Investor Briefing?
   È una call di 30 minuti dove presentiamo una shortlist personalizzata di 5-10 deal basata sui tuoi criteri di investimento, con schede tecniche e intro ai team.

9. Quali round sono disponibili?
   Le opportunità variano da pre-seed a Series A, con ticket da €500K a €5M. Molte tecnologie hanno già validazione industriale tramite POC.

Categoria: Eventi
10. Cos'è il Climate Innovation Day?
    È l'evento annuale Tech4You a Milano Bicocca con demo live delle tecnologie, panel con ricercatori, e speed matching tra aziende, investitori e team di ricerca.
```

---

## 5. Verifica Setup

Dopo aver inserito i dati, verifica con:

```
Mostrami un conteggio di tutti i record in ogni tabella
```

Dovresti vedere:
- servizi: 4
- eventi: 1
- faq: 10
- tecnologie: 0 (da popolare)
- leads: 0
- chat_history: 0

---

## Prossimi Step

1. ✅ Configurare MCP
2. ✅ Creare schema
3. ✅ Inserire servizi, eventi, FAQ
4. ⏳ Popolare tecnologie (120 record)
5. ⏳ Sviluppare backend chatbot
6. ⏳ Creare landing page con widget
