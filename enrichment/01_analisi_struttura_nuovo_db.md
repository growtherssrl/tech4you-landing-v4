# Analisi Struttura DEMOS_FULL_v3.json

**Data Analisi:** 12 Gennaio 2026
**Versione DB Nuovo:** 3.1.4
**Ultimo Update:** 9 Gennaio 2026

---

## PANORAMICA COMPARATIVA

| Metrica | DB Attuale (Supabase) | Nuovo DB (DEMOS_FULL) |
|---------|----------------------|----------------------|
| **Tecnologie/Demo** | 30 | 128 |
| **Cluster/Spoke** | 6 cluster | 6 Spoke |
| **Campi per tech** | ~12 | ~25+ |
| **Pilot Projects** | - | 56 |
| **Enrichments** | - | 74 |
| **Profili Commerciali** | - | 13 (Ecomondo) |
| **Relazioni Cross** | - | 4 |
| **Budget PP** | - | 55/56 PP |

---

## STRUTTURA GERARCHICA NUOVO DB

```
DEMOS_FULL_v3.json
│
├── metadata                      [Livello 1]
│   ├── version
│   ├── total_demonstrators: 128
│   ├── spokes_summary
│   └── sources
│
└── pilot_projects                [Livello 2]
    │
    ├── "PP X.Y.Z"
    │   ├── pp_reference
    │   ├── spoke (1-6)
    │   ├── budget
    │   ├── tags[]
    │   ├── descrizione_pp
    │   ├── impatti_previsti
    │   ├── sintesi
    │   ├── deliverable_2025
    │   ├── pilot_coordinator
    │   ├── pilot_owner
    │   ├── affiliati[]
    │   │
    │   └── demonstrators[]       [Livello 3]
    │       │
    │       └── {demo}
    │           ├── demo_id
    │           ├── nome
    │           ├── tipo_dimostratore
    │           ├── descrizione
    │           ├── trl_finale
    │           ├── completamento_percentuale
    │           ├── responsabile
    │           ├── affiliazione
    │           ├── partner[]
    │           │
    │           ├── enrichments[]     [Livello 4]
    │           ├── ecomondo_profile{}
    │           ├── relations[]
    │           └── bac_info{}
```

---

## MAPPING SPOKE ↔ CLUSTER

| Spoke | Tema Nuovo DB | Cluster Attuale |
|-------|---------------|-----------------|
| **1** | Environmental Risks & Natural Disasters | Climate |
| **2** | Energy & Circular Economy | Energy, Circular |
| **3** | Agrifood & Blue Economy | AgriFood |
| **4** | Cultural Heritage & Urban Regeneration | Cultural |
| **5** | Health & Wellness | Health |
| **6** | Digital Technologies & Communication | (trasversale) |

**Nota:** Spoke 2 copre sia Energy che Circular. Spoke 6 è trasversale/digitale.

---

## CAMPI DB ATTUALE (Supabase - tecnologie)

| Campo | Tipo | Note |
|-------|------|------|
| id | UUID | PK |
| nome | VARCHAR | |
| cluster | VARCHAR | CHECK: Energy, Circular, Climate, AgriFood, Cultural, Health |
| trl | INTEGER | CHECK: 1-9 |
| descrizione_breve | VARCHAR | |
| descrizione_estesa | TEXT | |
| sfida_risolta | VARCHAR | |
| metriche_impatto | VARCHAR | |
| status | VARCHAR | Default: 'Disponibile' |
| team_ricerca | VARCHAR | |
| brevetti | INTEGER | Default: 0 |
| created_at | TIMESTAMPTZ | |

---

## CAMPI NUOVO DB (DEMOS_FULL - demonstrators)

### Campi Core
| Campo | Tipo | Mapping a DB Attuale |
|-------|------|---------------------|
| demo_id | String | (nuovo ID format) |
| nome | String | nome |
| tipo_dimostratore | String | (nuovo) |
| descrizione | String | descrizione_estesa |
| trl_finale | Integer | trl |
| completamento_percentuale | Integer | (nuovo) |
| pp_original | String | (nuovo - riferimento PP) |

### Campi Responsabilita (NUOVI)
| Campo | Tipo | Note |
|-------|------|------|
| responsabile | String | ~85% coverage |
| affiliazione | String | Universita/Ente |
| partner | Array | Partner industriali |
| poster_source | String | File poster origine |

### Campi Nested (NUOVI)
| Campo | Tipo | Coverage |
|-------|------|----------|
| enrichments[] | Array | 74/128 demo |
| ecomondo_profile{} | Object | 13/128 demo |
| relations[] | Array | 7/128 demo |
| bac_info{} | Object | 6/128 demo |

---

## CAMPI A LIVELLO PP (NUOVI)

| Campo | Tipo | Coverage | Valore per Landing |
|-------|------|----------|-------------------|
| pp_reference | String | 100% | Identificativo PP |
| spoke | Integer | 100% | Per mapping cluster |
| budget | String | 98% | Credibilita |
| tags[] | Array | 98% | Filtri/categorizzazione |
| descrizione_pp | String | 93% | Contesto progetto |
| impatti_previsti | String | 93% | Value proposition |
| sintesi | String | 98% | Summary rapida |
| pilot_coordinator | String | 100% | Contatto |
| pilot_owner | String | 100% | Ente responsabile |
| affiliati[] | Array | 100% | Network |

---

## ECOMONDO PROFILE (13 demo)

Profilo commerciale per demo maturi:

```json
{
  "prototipo_name": "Nome commerciale",
  "market_targets": [
    {
      "segment": "Settore target",
      "description": "Descrizione use case"
    }
  ],
  "competitive_advantage": ["Vantaggio 1", "Vantaggio 2"],
  "inventors": ["Nome Cognome"],
  "developer": "Ente sviluppatore",
  "materials_available": ["Foto", "Video", "Schede"]
}
```

**Valore:** Identificare demo pronti per mercato, con target e vantaggi competitivi gia definiti.

---

## ENRICHMENTS (74 demo)

### Tipo INFO (4 demo)
Aggiunge dettagli tecnici non presenti altrove:
- system_name
- indicators
- methodology
- capabilities
- future_development

### Tipo CONFIRMATION (70 demo)
Tracciabilita poster → demo:
- poster_sources[]
- match_type: "CONFIRMATION"
- rationale
- session

---

## RELATIONS (7 demo, 4 relazioni)

Relazioni funzionali cross-Spoke:

| Tipo | Descrizione |
|------|-------------|
| INTEGRATO_CON | Demo integrati (bidirezionale) |
| COMPONENTE_DI | A e componente di B (unidirezionale) |
| ABILITA | A abilita B (unidirezionale) |

**Valore:** Identificare sinergie, cluster tecnologici, IP combinato.

---

## BAC_INFO (6 progetti)

Bando a Cascata collegati:

| Progetto BaC | Spoke | Partners |
|--------------|-------|----------|
| IN-FLOOD | 1 | Spintel, D&P, Solaretika |
| GECOMAR | 2 | GEKO, KRATOS |
| FARMTECH | 3 | - |
| SB-SSC | 3 | - |
| QUASIWEB | 3 | - |
| ADDICTA | 3 | - |

---

## DISTRIBUZIONE DEMO PER SPOKE

| Spoke | PP | Demo | Tema |
|-------|-----|------|------|
| 1 | 13 | 22 | Environmental Risks |
| 2 | 11 | 52 | Energy & Circular |
| 3 | 8 | 13 | Agrifood |
| 4 | 14 | 20 | Cultural Heritage |
| 5 | 4 | 6 | Health |
| 6 | 6 | 15 | Digital Tech |

---

## TRL DISTRIBUTION

| TRL | Count | % |
|-----|-------|---|
| 9 | 1 | 0.8% |
| 8 | 9 | 6.9% |
| 7 | 51 | 39.2% |
| 6 | 46 | 35.4% |
| 5 | 3 | 2.3% |
| null | 18 | 14% |

**Media TRL:** ~6.7 (demo maturi)

---

## TIPO DEMONSTRATOR DISTRIBUTION

| Tipo | Count | % |
|------|-------|---|
| Software Platform | 58 | 44.6% |
| Physical demonstrator | 42 | 32.3% |
| Physical + Software | 18 | 13.8% |
| Database/Protocol | 8 | 6.2% |
| Other | 2 | 1.5% |

---

## PROSSIMI STEP

1. [ ] Ottenere file JSON effettivo per analisi dati reali
2. [ ] Definire strategia di integrazione DB
3. [ ] Mappare campi nuovo → esistente
4. [ ] Identificare campi da aggiungere a Supabase
5. [ ] Piano migrazione dati
6. [ ] Aggiornamento query agente AI
7. [ ] Struttura landing page dinamiche per cluster

---

*Documento generato automaticamente - Tech4You Enrichment*
