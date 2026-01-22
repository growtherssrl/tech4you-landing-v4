# Analisi Workflow n8n di Riferimento

## Overview

Workflow analizzato: **Website Sales Assistant - V4 OPTIMIZED**
Contesto: Chatbot AI per lead qualification e sales automation nel settore formazione HR.

---

## Architettura del Workflow

### 1. Trigger Layer
```
[Chat Trigger] → Widget embeddabile su sito web
```
- **Nodo**: `@n8n/n8n-nodes-langchain.chatTrigger`
- **Funzione**: Riceve messaggi dal widget chat sul sito
- **Configurazione**:
  - Public: true (accessibile senza auth)
  - Messaggio iniziale personalizzabile
  - CSS customizzabile per branding
  - CORS: allowed origins configurabili

### 2. AI Agent Core
```
[Chat Trigger] → [AI Agent] → [Response]
```
- **Nodo**: `@n8n/n8n-nodes-langchain.agent`
- **Modello**: GPT-4o-mini (bilanciamento costo/performance)
- **Componenti collegati**:
  - LLM (OpenAI Chat Model)
  - Memory (Postgres Chat Memory)
  - Tools (Gmail, Google Sheets)

### 3. Memory Layer
```
[Postgres Chat Memory] ←→ [AI Agent]
```
- **Database**: Supabase (Postgres)
- **Funzione**: Persistenza conversazioni per session_id
- **Benefici**:
  - Context window esteso
  - Recupero storico conversazioni
  - Analisi post-hoc

### 4. Tools Layer
```
AI Agent può chiamare:
├── Gmail - Team Assistenza (escalation)
├── Gmail - Invio brochure (nurturing)
├── Google Sheets - Prodotti DB (catalogo)
├── Google Sheets - Promozioni DB
└── Google Sheets - Docenti DB
```

### 5. Post-Processing Layer
```
[AI Agent Response] → [Recupero Conversazione] → [Lead Scoring] → [Data Extraction] → [CRM]
```

**Flow dettagliato:**
1. **Recupero Conversazione**: Codice JS che recupera transcript completo da Postgres
2. **Lead Scoring Switch**: Classifica lead in HOT/WARM/COLD
3. **Information Extractor**: Estrae dati strutturati (nome, email, telefono, azienda)
4. **Summarization Chain**: Crea recap per team sales
5. **Build Row**: Prepara dati per Google Sheets
6. **Google Sheets Append**: Salva lead nel CRM

---

## Dettaglio System Prompt

### Struttura XML del Prompt
Il prompt utilizza un formato XML strutturato con sezioni:

```xml
<agent_config>
  <meta>              <!-- Identità e contesto -->
  <core_principles>   <!-- Regole fondamentali -->
  <databases>         <!-- Fonti dati disponibili -->
  <workflow>          <!-- Logica di routing -->
  <promotions>        <!-- Gestione sconti -->
  <upsell_logic>      <!-- Logica upgrade -->
  <conversation>      <!-- Stile conversazionale -->
  <output_format>     <!-- Formattazione risposte -->
  <objections>        <!-- Gestione obiezioni -->
  <errors>            <!-- Fallback errori -->
  <checklist>         <!-- Pre-flight check -->
  <critical_rules>    <!-- Regole non negoziabili -->
</agent_config>
```

### Elementi Chiave del Prompt

1. **Core Principles**
   - Valore prima di dati personali
   - Tono professionale mai aggressivo
   - Max 3 prodotti per risposta
   - Mai inventare dati

2. **Workflow di Routing**
   - Analisi intent → Selezione DB appropriato
   - Query database → Filtro risultati
   - Selezione top 2-3 → Arricchimento
   - Verifica promozioni → Presentazione

3. **Lead Qualification implicita**
   - Raccolta progressiva info
   - Discovery con 1 domanda per messaggio
   - Richiesta dati solo per azioni specifiche

---

## Lead Scoring System

### Criteri di Classificazione

| Livello | Criteri | Azione |
|---------|---------|--------|
| **HOT** | Tutti i dati + interesse esplicito | Contatto immediato |
| **WARM** | Interesse dimostrato, dati parziali | Follow-up 24-48h |
| **COLD** | Solo curiosità, pochi dati | Nurturing newsletter |

### Dati Estratti per Lead
```json
{
  "nome": "",
  "cognome": "",
  "email": "",
  "telefono": "",
  "azienda": "",
  "tipo_azienda": "",
  "prodotti_interesse": [],
  "sconto_interesse": "",
  "livello_interesse": "HOT|WARM|COLD",
  "priorita": "ALTA|MEDIA|BASSA",
  "recap_chat": "",
  "azione_richiesta": ""
}
```

---

## Stack Tecnologico

| Componente | Tecnologia | Scopo |
|------------|------------|-------|
| Orchestration | n8n | Workflow automation |
| LLM | OpenAI GPT-4o-mini | Conversazione AI |
| Memory | Supabase (Postgres) | Persistenza chat |
| CRM | Google Sheets | Lead management |
| Email | Gmail API | Outreach automation |
| Frontend | n8n Chat Widget | UI embeddabile |

---

## Pattern Riutilizzabili per Tech4You

### 1. Struttura System Prompt
- Formato XML per chiarezza e manutenibilità
- Sezioni separate per ogni aspetto
- Esempi concreti nel prompt
- Checklist pre-risposta

### 2. Lead Qualification Flow
- Scoring automatico post-conversazione
- Estrazione dati strutturati
- Routing basato su interesse
- Summarization per team

### 3. Tool Integration
- Database prodotti/servizi consultabili
- Email automation per follow-up
- CRM integration per tracking

### 4. Memory Management
- Postgres per persistenza
- Session-based context
- Recupero transcript per analisi

---

## Fonti

- [n8n AI Chatbot Templates](https://n8n.io/workflows/categories/ai-chatbot/)
- [Real Estate Lead Qualification Chatbot](https://n8n.io/workflows/6162-real-estate-lead-qualification-chatbot-with-gpt-4o-mini/)
- [BANT Lead Qualification Workflow](https://n8n.io/workflows/8773-automate-lead-qualification-and-multi-channel-follow-up-with-ai-bant/)
- [Branded AI Website Chatbot](https://n8n.io/workflows/2786-create-a-branded-ai-powered-website-chatbot/)
