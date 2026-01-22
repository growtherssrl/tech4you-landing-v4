# Asset Necessari - Tech4You AI Agent

## Overview

Questo documento elenca tutti gli asset necessari per implementare l'agente AI di accoglienza per Tech4You, basato su n8n.

---

## 1. Infrastruttura Tecnica

### 1.1 n8n Instance
- [ ] **n8n Cloud** o **Self-hosted**
  - Consigliato: n8n Cloud per semplicità
  - Alternative: Docker su VPS, Render, Railway
- [ ] **Piano**: Pro (per webhook pubblici e execution illimitati)

### 1.2 Database (Memory)
- [ ] **Supabase** (Postgres) per chat memory
  - Tabella: `chat_memory`
  - Colonne: `session_id`, `message`, `timestamp`, `role`
- [ ] Oppure: **Redis** per memory più leggera

### 1.3 LLM Provider
- [ ] **OpenAI API Key**
  - Modello consigliato: `gpt-4o-mini` (costo/performance)
  - Alternative: `gpt-4o` per risposte più sofisticate
- [ ] Budget stimato: ~€50-100/mese per 1000 conversazioni

### 1.4 CRM/Lead Storage
- [ ] **Google Sheets** (semplice, già integrato)
  - Oppure: Airtable, Notion, HubSpot, Pipedrive
- [ ] Struttura tabella lead (vedi sezione 4)

---

## 2. Knowledge Base

### 2.1 Documenti Core Tech4You
- [ ] **Executive Summary** - Overview ecosistema
- [ ] **Schede 6 Cluster** con:
  - Descrizione cluster
  - Tecnologie disponibili (TRL, status)
  - Sfide industriali risolte
  - Metriche di impatto
- [ ] **FAQ** - Domande frequenti
- [ ] **Processo di engagement** - Step per aziende/investitori

### 2.2 Database Prodotti/Servizi (Google Sheets)

#### Sheet 1: `Tecnologie`
| Campo | Tipo | Descrizione |
|-------|------|-------------|
| ID | string | Identificativo univoco |
| Nome | string | Nome tecnologia |
| Cluster | enum | Energy, Circular, Climate, AgriFood, Cultural, Health |
| TRL | number | Technology Readiness Level (1-9) |
| Descrizione_Breve | string | Max 100 caratteri |
| Descrizione_Estesa | text | Dettaglio completo |
| Sfida_Risolta | string | Problema industriale affrontato |
| Metriche_Impatto | string | ROI, risparmi, % miglioramento |
| Status | enum | Disponibile, In sviluppo, POC attivo |
| Team_Ricerca | string | Università/Centro di riferimento |
| Brevetti | number | Numero brevetti associati |

#### Sheet 2: `Servizi`
| Campo | Tipo | Descrizione |
|-------|------|-------------|
| Nome | string | Nome servizio |
| Target | enum | Industrial, Investor, Both |
| Descrizione | text | Cosa include |
| Durata | string | Tempo di erogazione |
| Output | string | Deliverable |
| Prezzo | string | Range o "Su richiesta" |

#### Sheet 3: `Eventi`
| Campo | Tipo | Descrizione |
|-------|------|-------------|
| Nome | string | Nome evento |
| Data | date | Data evento |
| Location | string | Luogo |
| Posti_Disponibili | number | Capacity |
| Target | enum | Industrial, Investor, Both |
| Descrizione | text | Programma |

#### Sheet 4: `FAQ`
| Campo | Tipo | Descrizione |
|-------|------|-------------|
| Categoria | string | Generale, Tecnologie, Investimenti, Eventi |
| Domanda | string | Domanda frequente |
| Risposta | text | Risposta standard |

### 2.3 Materiali Marketing
- [ ] **Brochure PDF** - Overview Tech4You
- [ ] **One-pager per cluster** - 6 documenti
- [ ] **Case studies** - 2-3 success stories
- [ ] **Investor deck** - Per target investor

---

## 3. System Prompt Components

### 3.1 Identità Agente
```
Nome: [Da definire - es. "Tech", "Eva", "T4Y Assistant"]
Ruolo: Innovation Consultant Tech4You
Tono: Professionale, competente, orientato al valore
```

### 3.2 Obiettivi Conversazionali
1. **Accoglienza** - Capire chi è l'utente (industrial vs investor)
2. **Discovery** - Identificare sfide/interessi specifici
3. **Matching** - Collegare a cluster/tecnologie rilevanti
4. **Qualification** - Raccogliere dati progressivamente
5. **Conversion** - Guidare verso booking call/assessment

### 3.3 Routing Logic
```
IF tipo_utente = "Industrial R&D"
  → Focus su sfide operative, ROI, POC
  → CTA: Climate Innovation Assessment

IF tipo_utente = "Investor"
  → Focus su deal flow, IP, team
  → CTA: Investor Briefing
```

---

## 4. Lead Data Structure

### 4.1 Campi da Raccogliere

#### Comuni
| Campo | Priorità | Momento |
|-------|----------|---------|
| Nome | Alta | Inizio conversazione |
| Email aziendale | Alta | Prima di CTA |
| Azienda | Alta | Discovery |
| Ruolo | Media | Discovery |
| Telefono | Bassa | Solo se richiesto follow-up |

#### Per Industrial
| Campo | Priorità | Momento |
|-------|----------|---------|
| Settore industriale | Alta | Discovery |
| Sfida principale | Alta | Discovery |
| Cluster di interesse | Alta | Matching |
| Budget R&D | Bassa | Se pertinente |
| Timeline progetto | Media | Qualification |

#### Per Investor
| Campo | Priorità | Momento |
|-------|----------|---------|
| Tipo fondo | Alta | Discovery |
| Ticket size | Media | Qualification |
| Stage preferito | Media | Matching |
| Settori focus | Alta | Matching |

### 4.2 Lead Scoring

| Livello | Criteri | Azione |
|---------|---------|--------|
| **HOT** | Email + Azienda + Interesse esplicito in call | Contatto entro 24h |
| **WARM** | Email + Interesse generico | Nurturing + Follow-up 48h |
| **COLD** | Solo navigazione/info generiche | Newsletter + Content |

---

## 5. Integrazioni Email

### 5.1 Template Email

#### Email 1: Invio Materiale (Nurturing)
```
Subject: [Nome], ecco le risorse Tech4You per {{cluster}}
Body: Breve intro + Link materiali + CTA soft
```

#### Email 2: Notifica Team (Lead HOT)
```
To: team@tech4you.it
Subject: Nuovo Lead HOT - {{azienda}}
Body: Recap conversazione + Dati lead + Azione richiesta
```

#### Email 3: Conferma Assessment/Briefing
```
Subject: Conferma {{tipo_call}} Tech4You
Body: Data/ora + Link calendario + Cosa aspettarsi
```

### 5.2 Credenziali Necessarie
- [ ] Account Gmail/SMTP per invio
- [ ] OAuth2 setup per Gmail API

---

## 6. Widget Chat

### 6.1 Configurazione UI
- [ ] **Colori brand**: Primary #0053CE, Accent #FBE91B
- [ ] **Font**: Poppins
- [ ] **Messaggio iniziale**:
  ```
  Ciao! Sono l'assistente Tech4You.
  Posso aiutarti a scoprire le tecnologie climate-tech più adatte
  alle tue esigenze. Come posso assisterti?
  ```
- [ ] **Posizione**: Bottom-right
- [ ] **Dimensioni**: 400x600px

### 6.2 CSS Personalizzato
```css
:root {
  --chat--color-primary: #0053CE;
  --chat--color-secondary: #07667A;
  --chat--color-accent: #FBE91B;
  --chat--color-dark: #212529;
  --chat--font-family: 'Poppins', sans-serif;
}
```

---

## 7. Landing Page Dedicata

### 7.1 Elementi Pagina
- [ ] **Hero section** con value prop
- [ ] **Widget chat** integrato (non popup)
- [ ] **Trust signals** - Loghi partner, numeri
- [ ] **Cluster overview** - 6 card cliccabili
- [ ] **CTA secondaria** - Per chi preferisce form tradizionale

### 7.2 Integrazione Tecnica
```html
<!-- n8n Chat Widget Embed -->
<script>
  window.n8nChatConfig = {
    webhookUrl: 'https://your-n8n-instance/webhook/xxx',
    initialMessages: ['Ciao! Come posso aiutarti?'],
    // ... altre config
  };
</script>
<script src="https://cdn.n8n.io/chat/latest/chat.bundle.js"></script>
```

---

## 8. Analytics & Monitoring

### 8.1 Metriche da Tracciare
- [ ] **Conversazioni iniziate** / giorno
- [ ] **Completion rate** - % che arriva a CTA
- [ ] **Lead generati** per livello (HOT/WARM/COLD)
- [ ] **Conversion to call** - % che prenota
- [ ] **Cluster più richiesti**
- [ ] **Domande frequenti** (per migliorare KB)

### 8.2 Strumenti
- [ ] Google Analytics 4 (eventi custom)
- [ ] n8n execution logs
- [ ] Dashboard Google Sheets/Data Studio

---

## 9. Checklist Pre-Launch

### Infrastruttura
- [ ] n8n instance attiva e configurata
- [ ] Database Supabase creato con schema
- [ ] OpenAI API key con billing attivo
- [ ] Google Sheets strutturati e popolati
- [ ] Gmail OAuth2 configurato

### Content
- [ ] System prompt completo e testato
- [ ] Knowledge base popolata (almeno 50% tech)
- [ ] FAQ inserite (almeno 20 domande)
- [ ] Template email pronti
- [ ] Materiali PDF caricati

### Testing
- [ ] Test conversazione Industrial (5 scenari)
- [ ] Test conversazione Investor (5 scenari)
- [ ] Test lead scoring (HOT/WARM/COLD)
- [ ] Test invio email
- [ ] Test salvataggio lead su Sheets

### Go-Live
- [ ] Landing page pubblicata
- [ ] Widget embed testato cross-browser
- [ ] Team notificato su processo lead
- [ ] Monitoring attivo

---

## 10. Timeline Stimata

| Fase | Durata | Dipendenze |
|------|--------|------------|
| Setup infrastruttura | 1-2 giorni | Account attivi |
| Creazione Knowledge Base | 3-5 giorni | Documenti Tech4You |
| Sviluppo System Prompt | 2-3 giorni | KB completata |
| Configurazione Workflow | 2-3 giorni | Prompt pronto |
| Testing & Refinement | 3-5 giorni | Workflow funzionante |
| **Totale** | **11-18 giorni** | |

---

## Note

- I tempi possono variare in base alla disponibilità dei contenuti Tech4You
- Il system prompt richiederà iterazioni basate sui test
- Consigliato soft launch con gruppo ristretto prima del go-live pubblico
