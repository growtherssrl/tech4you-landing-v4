# Piano Landing Page Dinamiche per Cluster

**Data:** 12 Gennaio 2026
**Progetto:** Tech4You - Enrichment Landing Pages

---

## Stato Attuale

### File esistenti
```
landing-pages/
├── landing-step1.html          # Homepage
├── landing-step2-industrial.html  # Landing per imprese (da rendere dinamica)
├── landing-step2-investor.html    # Landing per investitori
├── style.css
└── images/
```

### Struttura attuale landing-step2-industrial.html
- **6 tab cluster** con switch via JavaScript
- **Contenuti statici** per ogni cluster (sfide hardcoded)
- **Parametro URL** `?cluster=xxx` per pre-selezionare cluster
- **Formato sfida**: problema → soluzione → demo → metriche

---

## Dati Disponibili (Supabase)

### Tabella `tecnologie` (128 record)
| Campo | Utilizzo Landing |
|-------|-----------------|
| `nome` | Titolo tecnologia |
| `cluster` | Filtro tab |
| `trl` | Badge TRL |
| `descrizione_estesa` | Descrizione card |
| `tipo_dimostratore` | Categoria/icona |
| `pp_original` | Raggruppamento PP |
| `spoke` | Info aggiuntiva |
| `demo_id` | ID univoco |

### Distribuzione per Cluster
| Cluster | Count | Icona |
|---------|-------|-------|
| Energy | 53 | ⚡ |
| Climate | 26 | 🌍 |
| Cultural | 21 | 🏛️ |
| AgriFood | 13 | 🌾 |
| Health | 8 | 🧬 |
| Circular | 7 | ♻️ |

---

## Proposta Implementazione

### Opzione A: Full Dynamic con Supabase JS (Raccomandata)

**Pro:**
- Dati sempre aggiornati
- Un solo file HTML per tutti i cluster
- Gestione filtri avanzati

**Contro:**
- Richiede API key Supabase pubblica (anon key - sicura per read-only)

**Implementazione:**
```html
<!-- Nel <head> -->
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<!-- Nello script -->
const supabase = supabase.createClient(
  'https://jfcwreeugwpkjywhahqn.supabase.co',
  'ANON_KEY_PUBBLICA'
);

async function loadTecnologie(cluster) {
  const { data, error } = await supabase
    .from('tecnologie')
    .select('nome, trl, descrizione_estesa, tipo_dimostratore, demo_id')
    .eq('cluster', cluster)
    .order('trl', { ascending: false });

  renderTecnologie(data);
}
```

---

### Layout Proposto per Tecnologie

#### Vista Card (Desktop)
```
┌─────────────────────────────────────────────────────────────┐
│  [tipo_icon] NOME TECNOLOGIA                     [TRL 7]   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Descrizione breve (primi 150 caratteri)...                 │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐                        │
│  │ Software     │  │ PP 2.1.1     │                        │
│  └──────────────┘  └──────────────┘                        │
│                                                             │
│                              [Scopri di più →]             │
└─────────────────────────────────────────────────────────────┘
```

#### Griglia Responsive
- Desktop: 3 colonne
- Tablet: 2 colonne
- Mobile: 1 colonna

---

### Filtri Aggiuntivi (Opzionali)

```html
<div class="filters">
  <!-- Filtro TRL -->
  <select id="filter-trl">
    <option value="">Tutti i TRL</option>
    <option value="9">TRL 9 - Produzione</option>
    <option value="8">TRL 8 - Sistema completo</option>
    <option value="7">TRL 7 - Prototipo</option>
    <option value="6">TRL 6 - Demo ambiente</option>
  </select>

  <!-- Filtro Tipo -->
  <select id="filter-tipo">
    <option value="">Tutti i tipi</option>
    <option value="Software">Software Platform</option>
    <option value="Physical">Physical Demonstrator</option>
    <option value="Algorithm">Algorithm</option>
  </select>

  <!-- Search -->
  <input type="search" placeholder="Cerca tecnologia...">
</div>
```

---

## Struttura HTML Proposta

```html
<!-- Tab Cluster (invariato) -->
<div class="cluster-tabs">
  <button class="cluster-tab active" data-cluster="energy">⚡ Energy (53)</button>
  <button class="cluster-tab" data-cluster="climate">🌍 Climate (26)</button>
  <!-- ... -->
</div>

<!-- Filtri -->
<div class="tech-filters">
  <div class="filter-group">
    <label>TRL minimo:</label>
    <input type="range" min="5" max="9" value="5" id="trl-filter">
    <span id="trl-value">5+</span>
  </div>
  <div class="search-box">
    <input type="search" placeholder="Cerca..." id="search-input">
  </div>
</div>

<!-- Stats Cluster -->
<div class="cluster-stats">
  <div class="stat"><strong id="tech-count">53</strong> tecnologie</div>
  <div class="stat"><strong id="avg-trl">7.2</strong> TRL medio</div>
  <div class="stat"><strong id="pp-count">11</strong> Pilot Projects</div>
</div>

<!-- Grid Tecnologie (dinamica) -->
<div class="tech-grid" id="tech-container">
  <!-- Popolato da JavaScript -->
</div>

<!-- Loading State -->
<div class="loading" id="loading">
  <div class="spinner"></div>
  <p>Caricamento tecnologie...</p>
</div>
```

---

## JavaScript Core

```javascript
// Configurazione Supabase
const SUPABASE_URL = 'https://jfcwreeugwpkjywhahqn.supabase.co';
const SUPABASE_ANON_KEY = 'eyJ...'; // Chiave pubblica (anon)

const supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Stato applicazione
let currentCluster = 'energy';
let allTecnologie = [];
let filteredTecnologie = [];

// Carica tecnologie
async function loadTecnologie(cluster) {
  showLoading(true);

  const { data, error } = await supabase
    .from('tecnologie')
    .select('*')
    .eq('cluster', capitalizeFirst(cluster))
    .order('trl', { ascending: false });

  if (error) {
    console.error('Errore:', error);
    showError('Impossibile caricare le tecnologie');
    return;
  }

  allTecnologie = data;
  applyFilters();
  updateStats(data);
  showLoading(false);
}

// Render card tecnologia
function renderTechCard(tech) {
  const tipoIcon = getTipoIcon(tech.tipo_dimostratore);
  const desc = truncate(tech.descrizione_estesa, 150);

  return `
    <div class="tech-card" data-demo-id="${tech.demo_id}">
      <div class="tech-header">
        <span class="tech-tipo">${tipoIcon}</span>
        <h3 class="tech-nome">${tech.nome}</h3>
        ${tech.trl ? `<span class="trl-badge trl-${tech.trl}">TRL ${tech.trl}</span>` : ''}
      </div>
      <p class="tech-desc">${desc || 'Descrizione non disponibile'}</p>
      <div class="tech-meta">
        ${tech.tipo_dimostratore ? `<span class="meta-tag">${tech.tipo_dimostratore}</span>` : ''}
        ${tech.pp_original ? `<span class="meta-tag">${tech.pp_original}</span>` : ''}
      </div>
      <button class="btn-details" onclick="showDetails('${tech.demo_id}')">
        Scopri di più →
      </button>
    </div>
  `;
}

// Icone per tipo dimostratore
function getTipoIcon(tipo) {
  if (!tipo) return '📦';
  tipo = tipo.toLowerCase();
  if (tipo.includes('software')) return '💻';
  if (tipo.includes('physical')) return '🔧';
  if (tipo.includes('algorithm')) return '🧮';
  if (tipo.includes('platform')) return '🌐';
  if (tipo.includes('iot')) return '📡';
  return '📦';
}
```

---

## CSS Aggiuntivo

```css
/* Tech Grid */
.tech-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: var(--space-lg);
  padding: var(--space-xl) 0;
}

/* Tech Card */
.tech-card {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: var(--space-lg);
  transition: all var(--transition-normal);
}

.tech-card:hover {
  border-color: var(--primary);
  box-shadow: 0 8px 24px rgba(0,0,0,0.1);
  transform: translateY(-4px);
}

/* TRL Badge */
.trl-badge {
  padding: 4px 12px;
  border-radius: var(--radius-xl);
  font-size: 0.75rem;
  font-weight: 700;
}

.trl-9 { background: #10b981; color: white; }
.trl-8 { background: #3b82f6; color: white; }
.trl-7 { background: #6366f1; color: white; }
.trl-6 { background: #8b5cf6; color: white; }
.trl-5 { background: #a855f7; color: white; }

/* Stats */
.cluster-stats {
  display: flex;
  justify-content: center;
  gap: var(--space-xl);
  padding: var(--space-md);
  background: var(--light);
  border-radius: var(--radius-md);
  margin-bottom: var(--space-lg);
}

/* Filters */
.tech-filters {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-md);
  background: var(--white);
  border-radius: var(--radius-md);
  margin-bottom: var(--space-lg);
  flex-wrap: wrap;
  gap: var(--space-md);
}
```

---

## Fasi Implementazione

### Fase 1: Setup Base (30 min)
- [ ] Ottenere anon key Supabase
- [ ] Aggiungere Supabase JS SDK
- [ ] Test connessione

### Fase 2: Caricamento Dati (1h)
- [ ] Funzione loadTecnologie()
- [ ] Render card base
- [ ] Switch cluster

### Fase 3: UI/UX (1h)
- [ ] Stili card
- [ ] Stati loading/error
- [ ] Animazioni

### Fase 4: Filtri (45 min)
- [ ] Filtro TRL
- [ ] Ricerca testo
- [ ] Conteggi dinamici

### Fase 5: Dettagli (30 min)
- [ ] Modal dettaglio tecnologia
- [ ] Link a risorse esterne

---

## Note Tecniche

### API Key Supabase
La anon key è sicura per uso client-side perché:
- È read-only (select)
- RLS può limitare accesso (da attivare se necessario)
- Non espone dati sensibili

### Performance
- Caching locale dei dati caricati
- Lazy loading per cluster non visibili
- Debounce su ricerca testo

### SEO
- Contenuti caricati client-side non indicizzati
- Soluzione: pre-render pagine statiche per SEO (opzionale)

---

## Prossimi Passi

1. **Approvazione piano** - OK per procedere?
2. **Ottenere anon key** - Da dashboard Supabase
3. **Implementazione** - Modificare landing-step2-industrial.html
4. **Test** - Verifica su tutti i cluster
5. **Deploy** - Pubblicazione

---

*Documento generato automaticamente - Tech4You Enrichment*
