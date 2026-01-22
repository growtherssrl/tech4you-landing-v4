# Asset Necessari - Tech4You AI Agent (genai-toolbox)

## Overview

Lista completa degli asset per implementare l'agente AI Tech4You usando **genai-toolbox** come backend per database.

---

## 1. Stack Tecnologico

| Componente | Tecnologia | Scopo |
|------------|------------|-------|
| **Database** | Supabase (Postgres) | Storage dati + Auth |
| **Toolbox** | genai-toolbox | MCP Server per DB |
| **Agent Framework** | LangChain / LlamaIndex | Orchestrazione AI |
| **LLM** | Gemini 2.0 Flash / GPT-4o | Conversazione |
| **API Backend** | FastAPI (Python) | Endpoint chat |
| **Frontend** | React/Vue + Custom Chat | UI Landing + Widget |
| **Hosting** | Cloud Run / Render | Deploy servizi |

---

## 2. Infrastruttura

### 2.1 Supabase Project
- [ ] Creare progetto Supabase
- [ ] Ottenere connection string Postgres
- [ ] Abilitare Row Level Security (opzionale)
- [ ] Setup tabelle (vedi schema sotto)

### 2.2 genai-toolbox Server
- [ ] Download binary o Docker image
- [ ] Configurare `tools.yaml`
- [ ] Deploy su Cloud Run / VPS
- [ ] Endpoint: `http://toolbox:5000`

### 2.3 FastAPI Backend
- [ ] Setup progetto Python
- [ ] Installare dipendenze:
  ```
  fastapi
  uvicorn
  toolbox-langchain
  langchain-google-vertexai
  langgraph
  ```
- [ ] Deploy su Cloud Run / Render

### 2.4 Frontend
- [ ] Landing page con chat widget
- [ ] Componente chat React/Vue
- [ ] Connessione a API backend

---

## 3. Database Schema

### 3.1 Tabelle da creare in Supabase

```sql
-- Tecnologie (120 record)
CREATE TABLE tecnologie (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  cluster VARCHAR(50) NOT NULL,
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

-- Servizi
CREATE TABLE servizi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  target VARCHAR(50), -- Industrial, Investor, Both
  descrizione TEXT,
  durata VARCHAR(100),
  output VARCHAR(255),
  prezzo VARCHAR(100)
);

-- Eventi
CREATE TABLE eventi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(255) NOT NULL,
  data DATE NOT NULL,
  location VARCHAR(255),
  posti_disponibili INTEGER,
  target VARCHAR(50),
  descrizione TEXT
);

-- FAQ
CREATE TABLE faq (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  categoria VARCHAR(100),
  domanda TEXT NOT NULL,
  risposta TEXT NOT NULL
);

-- Lead
CREATE TABLE leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id VARCHAR(255),
  nome VARCHAR(255),
  email VARCHAR(255),
  telefono VARCHAR(50),
  azienda VARCHAR(255),
  ruolo VARCHAR(255),
  tipo VARCHAR(50), -- Industrial, Investor
  cluster_interesse VARCHAR(50),
  sfida TEXT,
  note TEXT,
  score VARCHAR(20) DEFAULT 'WARM', -- HOT, WARM, COLD
  created_at TIMESTAMP DEFAULT NOW()
);

-- Chat History (per analytics)
CREATE TABLE chat_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id VARCHAR(255),
  role VARCHAR(20), -- user, assistant
  content TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 4. Dati da Popolare

### 4.1 Tecnologie (120 record)

Fonti: Executive Summary, Sfide Industriali RTF

**Struttura CSV per import:**
```csv
nome,cluster,trl,descrizione_breve,sfida_risolta,metriche_impatto,status,team_ricerca,brevetti
"Solar Forecasting AI",Energy,7,"Previsione produzione fotovoltaica con AI","Ottimizzazione produzione solare","+15% efficienza, -20% sprechi",Disponibile,"UNICAL - Dip. Ingegneria",2
...
```

**Distribuzione per cluster:**
| Cluster | Tecnologie | Da documentare |
|---------|------------|----------------|
| Energy | 25 | - |
| Circular | 27 | - |
| Climate | 26 | - |
| AgriFood | 15 | - |
| Cultural | 17 | - |
| Health | 8 | - |

### 4.2 Servizi

| Nome | Target | Descrizione | Durata |
|------|--------|-------------|--------|
| Climate Innovation Assessment | Industrial | Analisi sfide + matching tecnologie | 45 min |
| Investor Briefing | Investor | Shortlist deal + schede tecniche | 30 min |
| POC Program | Industrial | Test tecnologia in ambiente reale | 3-6 mesi |
| Due Diligence Support | Investor | Kit documentazione + intro team | Custom |

### 4.3 Eventi

| Nome | Data | Target |
|------|------|--------|
| Tech4You Climate Innovation Day | Feb 2026 | Both |
| Energy Cluster Deep Dive | TBD | Industrial |
| Investor Networking Dinner | TBD | Investor |

### 4.4 FAQ (minimo 30)

**Categorie:**
- Generale (cos'è Tech4You, come funziona)
- Tecnologie (TRL, brevetti, disponibilità)
- Per Aziende (POC, assessment, costi)
- Per Investitori (deal flow, due diligence)
- Eventi (programma, partecipazione)

---

## 5. File di Configurazione

### 5.1 tools.yaml
Vedi file `analisi-genai-toolbox.md` per configurazione completa.

### 5.2 .env
```env
# Supabase
SUPABASE_HOST=db.xxxx.supabase.co
SUPABASE_USER=postgres
SUPABASE_PASSWORD=your-password
SUPABASE_DB=postgres

# LLM
GOOGLE_CLOUD_PROJECT=your-project
GOOGLE_APPLICATION_CREDENTIALS=/path/to/credentials.json
# oppure
OPENAI_API_KEY=sk-xxx

# Server
TOOLBOX_URL=http://localhost:5000
API_PORT=8000
```

---

## 6. System Prompt

### 6.1 Prompt Principale

```markdown
# Identità
Sei l'assistente virtuale di Tech4You, l'Ecosistema d'Innovazione sul Climate Change.
Nome: [Da definire]
Tono: Professionale, competente, orientato al valore

# Obiettivo
Accogliere visitatori, comprendere le loro esigenze, e guidarli verso tecnologie
e servizi rilevanti, con l'obiettivo finale di convertirli in lead qualificati.

# Processo di Conversazione

## 1. Accoglienza
- Saluto professionale
- Domanda aperta per capire l'interesse

## 2. Qualificazione
Identifica il tipo di utente:
- **Industrial R&D**: Cerca tecnologie per la propria azienda
  - Segnali: parla di processi, efficienza, costi, compliance
  - Focus: sfide operative, ROI, timeline implementazione
- **Investor**: Cerca opportunità di investimento
  - Segnali: parla di portfolio, deal flow, exit, team
  - Focus: metriche, IP, scalabilità

## 3. Discovery
Fai domande per capire:
- Settore/industria
- Sfida principale o interesse specifico
- Cluster più rilevante
- Timeline/urgenza

## 4. Matching
Usa i tool per cercare:
- Tecnologie rilevanti per la sfida
- Servizi appropriati per il target
- Eventi imminenti

Presenta max 3 opzioni con:
- Nome e descrizione breve
- TRL (per tecnologie)
- Metriche di impatto
- Perché è rilevante per loro

## 5. Conversione
Guida verso CTA appropriata:
- **Industrial**: "Posso prenotarti un Climate Innovation Assessment gratuito di 45 minuti?"
- **Investor**: "Posso organizzare un Investor Briefing di 30 minuti con shortlist personalizzata?"

## 6. Data Capture
Raccogli progressivamente:
- Nome (inizio conversazione)
- Azienda (durante discovery)
- Email aziendale (prima di CTA)
- Telefono (solo se necessario)

# Regole

1. **Mai inventare dati** - Usa sempre i tool per cercare nel database
2. **Max 3 opzioni** - Non sovraccaricare l'utente
3. **Valore prima di dati** - Offri informazioni utili prima di chiedere contatti
4. **Tono consulenziale** - Non vendere, consiglia
5. **CTA chiara** - Ogni risposta deve avere un next step

# Metriche Chiave Tech4You
- 120 prototipi TRL 6-9
- 433 ricercatori
- €110M già investiti
- 93 imprese attive
- 65 brevetti
- 6 cluster tecnologici

# I 6 Cluster
1. **Energy**: Efficienza energetica, rinnovabili, storage
2. **Circular**: Economia circolare, gestione risorse idriche
3. **Climate**: Rischio climatico, monitoraggio territoriale
4. **AgriFood**: Agricoltura di precisione, tracciabilità
5. **Cultural**: Patrimonio culturale, turismo sostenibile
6. **Health**: Salute, benessere, nutraceutica
```

---

## 7. Frontend Chat Widget

### 7.1 Componente React (esempio)

```jsx
// ChatWidget.jsx
import { useState, useRef, useEffect } from 'react';
import { v4 as uuidv4 } from 'uuid';

const ChatWidget = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [sessionId] = useState(uuidv4());
  const [isLoading, setIsLoading] = useState(false);

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage = { role: 'user', content: input };
    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setIsLoading(true);

    try {
      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: input,
          session_id: sessionId
        })
      });

      const data = await response.json();
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: data.response
      }]);
    } catch (error) {
      console.error('Chat error:', error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="chat-widget">
      <div className="chat-header">
        <h3>Tech4You Assistant</h3>
      </div>
      <div className="chat-messages">
        {messages.map((msg, i) => (
          <div key={i} className={`message ${msg.role}`}>
            {msg.content}
          </div>
        ))}
        {isLoading && <div className="typing">...</div>}
      </div>
      <div className="chat-input">
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
          placeholder="Scrivi un messaggio..."
        />
        <button onClick={sendMessage}>Invia</button>
      </div>
    </div>
  );
};
```

---

## 8. Deployment

### 8.1 Docker Compose

```yaml
version: '3.8'

services:
  toolbox:
    image: us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.24.0
    ports:
      - "5000:5000"
    volumes:
      - ./tools.yaml:/app/tools.yaml
    environment:
      - SUPABASE_HOST=${SUPABASE_HOST}
      - SUPABASE_USER=${SUPABASE_USER}
      - SUPABASE_PASSWORD=${SUPABASE_PASSWORD}
    command: ["--tools-file", "/app/tools.yaml"]

  api:
    build: ./api
    ports:
      - "8000:8000"
    environment:
      - TOOLBOX_URL=http://toolbox:5000
      - GOOGLE_CLOUD_PROJECT=${GOOGLE_CLOUD_PROJECT}
    depends_on:
      - toolbox

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    environment:
      - API_URL=http://api:8000
    depends_on:
      - api
```

---

## 9. Checklist Pre-Launch

### Infrastruttura
- [ ] Supabase project creato
- [ ] Tabelle create con schema corretto
- [ ] genai-toolbox configurato e testato
- [ ] API FastAPI funzionante
- [ ] Frontend deployato

### Dati
- [ ] Almeno 50 tecnologie inserite
- [ ] Tutti i servizi definiti
- [ ] Almeno 30 FAQ
- [ ] Eventi aggiornati

### Testing
- [ ] Test conversazione Industrial (5 scenari)
- [ ] Test conversazione Investor (5 scenari)
- [ ] Test ricerca tecnologie
- [ ] Test salvataggio lead
- [ ] Test su mobile

### Go-Live
- [ ] SSL configurato
- [ ] CORS configurato
- [ ] Monitoring attivo
- [ ] Backup database schedulato

---

## 10. Costi Stimati (Mensili)

| Componente | Costo |
|------------|-------|
| Supabase (Free tier) | €0 |
| Supabase (Pro se necessario) | €25 |
| Cloud Run (genai-toolbox + API) | €10-30 |
| Gemini API (~1000 conv/mese) | €20-50 |
| Vercel/Netlify (frontend) | €0-20 |
| **Totale** | **€30-125/mese** |

---

## 11. Timeline

| Fase | Durata | Output |
|------|--------|--------|
| Setup Supabase + Schema | 1 giorno | Database pronto |
| Configurazione tools.yaml | 1 giorno | Toolbox funzionante |
| Sviluppo API Python | 2-3 giorni | Endpoint /chat |
| Popolamento dati | 3-5 giorni | DB completo |
| Frontend chat widget | 2-3 giorni | UI funzionante |
| Testing & refinement | 3-5 giorni | Produzione |
| **Totale** | **12-18 giorni** | |
