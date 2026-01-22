# Architettura AI Agent con MCP + Supabase

## Supabase MCP Server

Supabase ha un **MCP Server ufficiale** che permette di connettere AI assistants direttamente al database.

### Configurazione Base

```json
{
  "mcpServers": {
    "supabase": {
      "type": "http",
      "url": "https://mcp.supabase.com/mcp"
    }
  }
}
```

### Opzioni Configurazione

| Parametro | Esempio | Scopo |
|-----------|---------|-------|
| `project_ref` | `?project_ref=abc123` | Limita a un progetto specifico |
| `read_only` | `?read_only=true` | Solo lettura (sicurezza) |
| `features` | `?features=database,docs` | Abilita solo gruppi specifici |

### Tools Disponibili

**Database:**
- `list_tables` - Elenca tabelle
- `execute_sql` - Esegui query SQL
- `apply_migration` - Applica migrazioni DDL
- `list_extensions` - Estensioni Postgres

**Account:**
- `list_projects` - Lista progetti
- `get_project` - Dettagli progetto

**Development:**
- `get_project_url` - URL API
- `generate_typescript_types` - Genera tipi TS

**Docs:**
- `search_docs` - Cerca nella documentazione

---

## Due Scenari d'Uso

### Scenario 1: Sviluppo (Consigliato ora)

Usa Supabase MCP per **sviluppare** il chatbot:
- Crea schema database
- Popola dati tecnologie/FAQ
- Testa query SQL

```
Claude Desktop / Cursor
        │
        ▼
  Supabase MCP
        │
        ▼
  Supabase DB
```

### Scenario 2: Produzione (Chatbot)

Per il **chatbot in produzione**, l'MCP Supabase non è ideale perché:
1. È pensato per tool di sviluppo, non per utenti finali
2. Richiede autenticazione OAuth
3. Non ha rate limiting per chatbot

**Soluzione raccomandata:**

```
Landing Page + Chat Widget
           │
           ▼
      FastAPI Backend
           │
           ├──► LangChain Agent + Supabase SDK (queries)
           │
           └──► Supabase DB (storage lead)
```

---

## Architettura Ibrida Consigliata

### Fase 1: Sviluppo con MCP

Usa Claude Desktop + Supabase MCP per:
1. Creare le tabelle
2. Inserire dati
3. Testare query

### Fase 2: Produzione con SDK

Usa Supabase Python SDK nel backend:

```python
# agent.py
from supabase import create_client
from langchain_google_vertexai import ChatVertexAI
from langchain.agents import create_react_agent
from langchain.tools import Tool

# Supabase client
supabase = create_client(
    os.environ["SUPABASE_URL"],
    os.environ["SUPABASE_KEY"]
)

# Tools basati su Supabase SDK
def search_technologies(cluster: str) -> str:
    """Cerca tecnologie per cluster"""
    result = supabase.table("tecnologie") \
        .select("*") \
        .ilike("cluster", f"%{cluster}%") \
        .limit(5) \
        .execute()
    return str(result.data)

def get_faq(query: str) -> str:
    """Cerca nelle FAQ"""
    result = supabase.table("faq") \
        .select("*") \
        .or_(f"domanda.ilike.%{query}%,risposta.ilike.%{query}%") \
        .limit(3) \
        .execute()
    return str(result.data)

def save_lead(data: dict) -> str:
    """Salva un lead"""
    result = supabase.table("leads") \
        .insert(data) \
        .execute()
    return f"Lead salvato con ID: {result.data[0]['id']}"

# Definisci tools per LangChain
tools = [
    Tool(
        name="search_technologies",
        func=search_technologies,
        description="Cerca tecnologie climate-tech per cluster"
    ),
    Tool(
        name="get_faq",
        func=get_faq,
        description="Cerca risposte nelle FAQ"
    ),
    Tool(
        name="save_lead",
        func=save_lead,
        description="Salva i dati di un lead qualificato"
    ),
]

# Crea agente
agent = create_react_agent(
    llm=ChatVertexAI(model_name="gemini-2.0-flash"),
    tools=tools,
    prompt=SYSTEM_PROMPT
)
```

---

## Setup Supabase MCP per Sviluppo

### 1. Configura Claude Desktop

Modifica `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "supabase": {
      "type": "http",
      "url": "https://mcp.supabase.com/mcp?project_ref=YOUR_PROJECT_REF&features=database,docs"
    }
  }
}
```

### 2. Autenticazione

Al primo uso, Claude chiederà di autenticarti con Supabase.

### 3. Comandi Utili

Una volta connesso, puoi dire a Claude:

```
"Crea una tabella tecnologie con campi: id, nome, cluster, trl, descrizione"

"Inserisci 5 tecnologie di esempio nel cluster Energy"

"Mostrami tutte le tabelle nel database"

"Esegui: SELECT * FROM tecnologie WHERE cluster = 'Energy'"
```

---

## Schema Database per Tech4You

Usa Claude + MCP per creare questo schema:

```sql
-- Prompt per Claude con MCP:
"Crea le seguenti tabelle nel mio progetto Supabase:

1. tecnologie
   - id: uuid primary key
   - nome: varchar(255)
   - cluster: varchar(50) (Energy, Circular, Climate, AgriFood, Cultural, Health)
   - trl: integer (1-9)
   - descrizione_breve: varchar(200)
   - descrizione_estesa: text
   - sfida_risolta: varchar(255)
   - metriche_impatto: varchar(255)
   - status: varchar(50) default 'Disponibile'
   - team_ricerca: varchar(255)
   - brevetti: integer default 0
   - created_at: timestamp

2. servizi
   - id: uuid primary key
   - nome: varchar(255)
   - target: varchar(50) (Industrial, Investor, Both)
   - descrizione: text
   - durata: varchar(100)
   - output: varchar(255)
   - prezzo: varchar(100)

3. eventi
   - id: uuid primary key
   - nome: varchar(255)
   - data: date
   - location: varchar(255)
   - posti_disponibili: integer
   - target: varchar(50)
   - descrizione: text

4. faq
   - id: uuid primary key
   - categoria: varchar(100)
   - domanda: text
   - risposta: text

5. leads
   - id: uuid primary key
   - session_id: varchar(255)
   - nome: varchar(255)
   - email: varchar(255)
   - azienda: varchar(255)
   - ruolo: varchar(255)
   - tipo: varchar(50) (Industrial, Investor)
   - cluster_interesse: varchar(50)
   - note: text
   - score: varchar(20) default 'WARM'
   - created_at: timestamp
"
```

---

## Sicurezza

### Per Sviluppo (MCP)
- Usa progetto di sviluppo, mai produzione
- Abilita `read_only=true` se lavori con dati reali
- Scope a progetto specifico con `project_ref`

### Per Produzione (SDK)
- Usa Supabase Anon Key (RLS protegge i dati)
- Service Role Key solo server-side
- Rate limiting su API endpoint
- Validazione input prima di query

---

## Fonti

- [Supabase MCP Documentation](https://supabase.com/docs/guides/getting-started/mcp)
- [Supabase MCP GitHub](https://github.com/supabase-community/supabase-mcp)
- [MCP Security Best Practices](https://supabase.com/docs/guides/getting-started/mcp#security)
