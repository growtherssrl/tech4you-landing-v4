# Analisi genai-toolbox per Tech4You

## Cos'è genai-toolbox

**MCP Toolbox for Databases** è un server open-source che semplifica la creazione di tool AI con accesso ai database. Agisce come middleware tra applicazioni AI e database.

### Differenze con n8n

| Aspetto | n8n | genai-toolbox |
|---------|-----|---------------|
| Tipo | Workflow automation | MCP Server per DB |
| UI | Visual editor | Config YAML |
| Focus | Integrazioni (1000+) | Database queries |
| Chat Widget | Incluso | Da implementare |
| Hosting | Cloud/Self-hosted | Self-hosted |
| Complessità | Media | Bassa |
| Costo | €20-50/mese cloud | Gratuito (infra) |

### Vantaggi genai-toolbox
- **Semplicità**: ~10 righe di codice per integrare
- **Performance**: Connection pooling nativo
- **Flessibilità**: Supporta LangChain, LlamaIndex, ADK
- **Controllo**: Più controllo sul flusso dell'agente

### Svantaggi
- Richiede più sviluppo custom
- Nessun widget chat pronto
- Nessuna UI per gestione workflow

---

## Architettura Proposta per Tech4You

```
┌─────────────────────────────────────────────────────────┐
│                    FRONTEND                              │
│  ┌─────────────────────────────────────────────────┐    │
│  │  Landing Page + Chat Widget (custom React/Vue)  │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    API LAYER                             │
│  ┌─────────────────────────────────────────────────┐    │
│  │  FastAPI / Flask (Python)                        │    │
│  │  - Endpoint /chat                                │    │
│  │  - Session management                            │    │
│  │  - Lead capture                                  │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    AGENT LAYER                           │
│  ┌─────────────────────────────────────────────────┐    │
│  │  LangChain / LlamaIndex Agent                    │    │
│  │  - System Prompt                                 │    │
│  │  - Memory (ConversationBufferMemory)             │    │
│  │  - Tools da genai-toolbox                        │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    TOOLBOX LAYER                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │  genai-toolbox (MCP Server)                      │    │
│  │  - tools.yaml configuration                      │    │
│  │  - SQL queries predefinite                       │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    DATA LAYER                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Supabase    │  │  Supabase    │  │  Supabase    │  │
│  │  Tecnologie  │  │  FAQ         │  │  Leads       │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
```

---

## Configurazione tools.yaml per Tech4You

```yaml
sources:
  tech4you-db:
    kind: postgres
    host: ${SUPABASE_HOST}
    port: 5432
    database: postgres
    user: ${SUPABASE_USER}
    password: ${SUPABASE_PASSWORD}

tools:
  # ============================================
  # RICERCA TECNOLOGIE
  # ============================================
  search-technologies-by-cluster:
    kind: postgres-sql
    source: tech4you-db
    description: "Cerca tecnologie per cluster (Energy, Circular, Climate, AgriFood, Cultural, Health)"
    parameters:
      - name: cluster
        type: string
        description: "Nome del cluster: Energy, Circular, Climate, AgriFood, Cultural, Health"
    statement: |
      SELECT id, nome, cluster, trl, descrizione_breve, sfida_risolta, metriche_impatto
      FROM tecnologie
      WHERE LOWER(cluster) = LOWER($1)
      AND status = 'Disponibile'
      ORDER BY trl DESC
      LIMIT 5;

  search-technologies-by-challenge:
    kind: postgres-sql
    source: tech4you-db
    description: "Cerca tecnologie basate su una sfida industriale specifica"
    parameters:
      - name: challenge
        type: string
        description: "Descrizione della sfida industriale dell'utente"
    statement: |
      SELECT id, nome, cluster, trl, descrizione_breve, sfida_risolta, metriche_impatto
      FROM tecnologie
      WHERE sfida_risolta ILIKE '%' || $1 || '%'
      OR descrizione_estesa ILIKE '%' || $1 || '%'
      AND status = 'Disponibile'
      ORDER BY trl DESC
      LIMIT 5;

  get-technology-details:
    kind: postgres-sql
    source: tech4you-db
    description: "Ottieni dettagli completi di una tecnologia specifica"
    parameters:
      - name: tech_id
        type: string
        description: "ID della tecnologia"
    statement: |
      SELECT *
      FROM tecnologie
      WHERE id = $1;

  # ============================================
  # CLUSTER INFO
  # ============================================
  get-cluster-overview:
    kind: postgres-sql
    source: tech4you-db
    description: "Ottieni panoramica di un cluster con statistiche"
    parameters:
      - name: cluster
        type: string
        description: "Nome del cluster"
    statement: |
      SELECT
        cluster,
        COUNT(*) as num_tecnologie,
        AVG(trl) as trl_medio,
        SUM(brevetti) as totale_brevetti
      FROM tecnologie
      WHERE LOWER(cluster) = LOWER($1)
      GROUP BY cluster;

  list-all-clusters:
    kind: postgres-sql
    source: tech4you-db
    description: "Elenca tutti i cluster con conteggio tecnologie"
    parameters: []
    statement: |
      SELECT
        cluster,
        COUNT(*) as num_tecnologie,
        STRING_AGG(DISTINCT sfida_risolta, ', ') as sfide_principali
      FROM tecnologie
      WHERE status = 'Disponibile'
      GROUP BY cluster
      ORDER BY num_tecnologie DESC;

  # ============================================
  # FAQ
  # ============================================
  search-faq:
    kind: postgres-sql
    source: tech4you-db
    description: "Cerca nelle FAQ per rispondere a domande comuni"
    parameters:
      - name: query
        type: string
        description: "Domanda dell'utente"
    statement: |
      SELECT categoria, domanda, risposta
      FROM faq
      WHERE domanda ILIKE '%' || $1 || '%'
      OR risposta ILIKE '%' || $1 || '%'
      LIMIT 3;

  # ============================================
  # SERVIZI
  # ============================================
  get-services-by-target:
    kind: postgres-sql
    source: tech4you-db
    description: "Ottieni servizi disponibili per target (Industrial o Investor)"
    parameters:
      - name: target
        type: string
        description: "Tipo di target: Industrial, Investor, Both"
    statement: |
      SELECT nome, descrizione, durata, output, prezzo
      FROM servizi
      WHERE target = $1 OR target = 'Both'
      ORDER BY nome;

  # ============================================
  # EVENTI
  # ============================================
  get-upcoming-events:
    kind: postgres-sql
    source: tech4you-db
    description: "Ottieni prossimi eventi Tech4You"
    parameters: []
    statement: |
      SELECT nome, data, location, posti_disponibili, target, descrizione
      FROM eventi
      WHERE data >= CURRENT_DATE
      ORDER BY data ASC
      LIMIT 5;

  # ============================================
  # LEAD MANAGEMENT
  # ============================================
  save-lead:
    kind: postgres-sql
    source: tech4you-db
    description: "Salva un nuovo lead nel database"
    parameters:
      - name: nome
        type: string
        description: "Nome del lead"
      - name: email
        type: string
        description: "Email aziendale"
      - name: azienda
        type: string
        description: "Nome azienda"
      - name: ruolo
        type: string
        description: "Ruolo in azienda"
      - name: tipo
        type: string
        description: "Tipo: Industrial o Investor"
      - name: cluster_interesse
        type: string
        description: "Cluster di interesse"
      - name: note
        type: string
        description: "Note dalla conversazione"
    statement: |
      INSERT INTO leads (nome, email, azienda, ruolo, tipo, cluster_interesse, note, created_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7, NOW())
      RETURNING id;

# ============================================
# TOOLSETS
# ============================================
toolsets:
  # Per conversazioni generali
  discovery:
    - list-all-clusters
    - search-faq
    - get-services-by-target
    - get-upcoming-events

  # Per ricerca tecnologie
  technology-search:
    - search-technologies-by-cluster
    - search-technologies-by-challenge
    - get-technology-details
    - get-cluster-overview

  # Per lead capture
  lead-capture:
    - save-lead

  # Tutti i tool
  full:
    - list-all-clusters
    - search-technologies-by-cluster
    - search-technologies-by-challenge
    - get-technology-details
    - get-cluster-overview
    - search-faq
    - get-services-by-target
    - get-upcoming-events
    - save-lead
```

---

## Schema Database Supabase

### Tabella: tecnologie
```sql
CREATE TABLE tecnologie (
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
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Tabella: servizi
```sql
CREATE TABLE servizi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  target VARCHAR(50) CHECK (target IN ('Industrial', 'Investor', 'Both')),
  descrizione TEXT,
  durata VARCHAR(100),
  output VARCHAR(255),
  prezzo VARCHAR(100)
);
```

### Tabella: eventi
```sql
CREATE TABLE eventi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  data DATE NOT NULL,
  location VARCHAR(255),
  posti_disponibili INTEGER,
  target VARCHAR(50) CHECK (target IN ('Industrial', 'Investor', 'Both')),
  descrizione TEXT
);
```

### Tabella: faq
```sql
CREATE TABLE faq (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  categoria VARCHAR(100),
  domanda TEXT NOT NULL,
  risposta TEXT NOT NULL
);
```

### Tabella: leads
```sql
CREATE TABLE leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255),
  email VARCHAR(255),
  azienda VARCHAR(255),
  ruolo VARCHAR(255),
  tipo VARCHAR(50) CHECK (tipo IN ('Industrial', 'Investor')),
  cluster_interesse VARCHAR(50),
  note TEXT,
  score VARCHAR(20) DEFAULT 'WARM',
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## Agent Python (LangChain)

```python
# agent.py
import os
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from langchain_google_vertexai import ChatVertexAI
from langgraph.prebuilt import create_react_agent
from toolbox_langchain import ToolboxClient

app = FastAPI()

# System Prompt per Tech4You
SYSTEM_PROMPT = """
Sei l'assistente virtuale di Tech4You, l'Ecosistema d'Innovazione sul Climate Change.

## Il tuo ruolo
Accogli i visitatori, comprendi le loro esigenze e li guidi verso le tecnologie
e i servizi più rilevanti per loro.

## Regole di comportamento
1. Sii professionale ma accessibile
2. Fai domande per capire se l'utente è:
   - Industrial R&D (cerca tecnologie per la propria azienda)
   - Investor (cerca opportunità di investimento)
3. Presenta massimo 3 tecnologie/servizi per risposta
4. Guida sempre verso una CTA:
   - Industrial → Climate Innovation Assessment (45 min, gratuito)
   - Investor → Investor Briefing (30 min, gratuito)
5. Raccogli dati progressivamente (nome, email, azienda) solo quando pertinente

## I 6 Cluster Tech4You
- Energy: Efficienza energetica, rinnovabili, storage
- Circular: Economia circolare, gestione risorse idriche
- Climate: Rischio climatico, monitoraggio territoriale
- AgriFood: Agricoltura di precisione, tracciabilità
- Cultural: Patrimonio culturale, turismo sostenibile
- Health: Salute, benessere, nutraceutica

## Metriche chiave
- 120 prototipi TRL 6-9
- 433 ricercatori
- €110M già investiti
- 93 imprese attive
- 65 brevetti

Usa i tool disponibili per cercare nel database e fornire informazioni accurate.
"""

class ChatMessage(BaseModel):
    message: str
    session_id: str

class ChatResponse(BaseModel):
    response: str
    session_id: str

# Memoria conversazioni (in produzione usare Redis/Supabase)
conversations = {}

@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatMessage):
    async with ToolboxClient("http://127.0.0.1:5000") as client:
        tools = await client.aload_toolset("full")

        model = ChatVertexAI(
            model_name="gemini-2.0-flash-001",
            temperature=0.7
        )

        agent = create_react_agent(
            model,
            tools,
            state_modifier=SYSTEM_PROMPT
        )

        # Recupera storico conversazione
        history = conversations.get(request.session_id, [])
        history.append(("user", request.message))

        response = await agent.ainvoke({
            "messages": history
        })

        # Salva risposta in memoria
        assistant_message = response["messages"][-1].content
        history.append(("assistant", assistant_message))
        conversations[request.session_id] = history

        return ChatResponse(
            response=assistant_message,
            session_id=request.session_id
        )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

---

## Fonti

- [GitHub - googleapis/genai-toolbox](https://github.com/googleapis/genai-toolbox)
- [Configuration Guide](https://googleapis.github.io/genai-toolbox/getting-started/configure/)
- [Python Quickstart](https://googleapis.github.io/genai-toolbox/getting-started/local_quickstart/)
- [Build a Chatbot for any Database](https://medium.com/google-cloud/building-a-dvd-rental-chatbot-using-llamaindex-agentworkflow-google-genai-toolbox-postgresql-5d6e806d5891)
