# Setup Workflow Tech4You Assistant

## Prerequisiti

1. **n8n** installato (self-hosted o cloud)
2. **Account OpenAI** con API key
3. **Supabase** progetto configurato (ref: `jfcwreeugwpkjywhahqn`)

---

## Step 1: Importa il Workflow

1. Apri n8n
2. Vai su **Workflows** → **Import from File**
3. Seleziona `workflow-tech4you-assistant.json`
4. Il workflow verrà importato con tutti i nodi

---

## Step 2: Configura le Credenziali

### OpenAI API

1. Vai su **Settings** → **Credentials** → **Add Credential**
2. Cerca **OpenAI API**
3. Inserisci la tua API Key
4. Salva e annota l'ID della credenziale

### Supabase Postgres

1. Vai su **Settings** → **Credentials** → **Add Credential**
2. Cerca **Postgres**
3. Configura con i dati Supabase:

```
Host: db.jfcwreeugwpkjywhahqn.supabase.co
Database: postgres
User: postgres
Password: [la tua password Supabase]
Port: 5432
SSL: Require
```

4. Salva e annota l'ID della credenziale

---

## Step 3: Aggiorna i Nodi

Dopo l'import, devi aggiornare gli ID delle credenziali nei nodi:

### Nodi da aggiornare:

| Nodo | Credenziale |
|------|-------------|
| OpenAI Chat Model | OpenAI API |
| Postgres Chat Memory | Supabase Postgres |
| DB Search Technologies | Supabase Postgres |
| DB Save Lead | Supabase Postgres |
| DB Search FAQ | Supabase Postgres |
| DB Get Events | Supabase Postgres |

Per ogni nodo:
1. Clicca sul nodo
2. Vai alla sezione **Credentials**
3. Seleziona la credenziale corretta dal dropdown

---

## Step 4: Configura il Chat Widget

### Opzione A: Embed Diretto

Il Chat Trigger genera un widget embeddabile. Per usarlo:

1. Attiva il workflow
2. Copia l'URL del webhook: `https://[tuo-n8n]/webhook/tech4you-assistant/chat`
3. Aggiungi al tuo sito:

```html
<script>
  window.ChatWidgetConfig = {
    webhookUrl: 'https://[tuo-n8n]/webhook/tech4you-assistant/chat',
    title: 'Tech4You Assistant',
    subtitle: 'Ecosistema d\'Innovazione sul Climate Change'
  };
</script>
<script src="https://[tuo-n8n]/webhook/tech4you-assistant/chat/widget.js"></script>
```

### Opzione B: Iframe

```html
<iframe
  src="https://[tuo-n8n]/webhook/tech4you-assistant/chat"
  style="width: 400px; height: 600px; border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.15);"
></iframe>
```

---

## Step 5: Configura i Tool Workflows

I tool (`search_technologies`, `save_lead`, `search_faq`, `get_events`) sono configurati come sub-workflow. Per attivarli:

1. Crea 4 workflow separati per ogni tool OPPURE
2. Usa i nodi Execute Workflow per chiamare i nodi DB direttamente

### Struttura consigliata:

```
Main Workflow (Tech4You Assistant)
├── Chat Trigger
├── AI Agent
│   ├── OpenAI Chat Model
│   ├── Postgres Memory
│   └── Tools
│       ├── search_technologies → DB Search Technologies
│       ├── save_lead → DB Save Lead
│       ├── search_faq → DB Search FAQ
│       └── get_events → DB Get Events
```

---

## Step 6: Test del Workflow

1. Attiva il workflow (toggle in alto a destra)
2. Apri il webhook URL in una nuova tab
3. Verifica che appaia il messaggio di benvenuto
4. Testa i seguenti scenari:

### Scenario 1: Utente Industrial
```
Tu: Rappresento un'azienda del settore energetico
Bot: [Dovrebbe qualificare come Industrial e chiedere la sfida]
Tu: Vogliamo ottimizzare la produzione fotovoltaica
Bot: [Dovrebbe cercare tecnologie Energy e presentarne 2-3]
```

### Scenario 2: Utente Investor
```
Tu: Sono un venture capital interessato al climate tech
Bot: [Dovrebbe qualificare come Investor e presentare il valore]
Tu: Cerco opportunità nel circular economy
Bot: [Dovrebbe cercare tecnologie Circular e parlare di IP/brevetti]
```

### Scenario 3: Raccolta Dati
```
Tu: Mi chiamo Marco Rossi
Bot: [Dovrebbe chiedere l'organizzazione]
Tu: Lavoro per Enel Green Power
Bot: [Dovrebbe chiedere l'email]
Tu: marco.rossi@enel.com
Bot: [Dovrebbe salvare il lead e preparare il redirect]
```

---

## Step 7: Configurazione CORS (Produzione)

Nel nodo **Chat Trigger**, configura i domini autorizzati:

```json
{
  "allowedOrigins": "https://tech4you.it,https://www.tech4you.it,https://landing.tech4you.it"
}
```

---

## Troubleshooting

### Il chat non risponde
- Verifica che il workflow sia attivo
- Controlla i log di n8n per errori
- Verifica le credenziali OpenAI

### Errore database
- Verifica la connessione Postgres
- Controlla che le tabelle esistano (schema.sql)
- Verifica SSL attivo

### Il bot non trova tecnologie
- Verifica che i dati siano stati inseriti (seed-tecnologie.sql)
- Controlla i filtri nella query SQL

### Email personali accettate
- Il controllo è nel system prompt, l'agente dovrebbe rifiutare
- Se persiste, aggiungi validazione nel nodo DB Save Lead

---

## Monitoraggio

### Metriche da tracciare:
1. **Conversation Start Rate**: % utenti che iniziano
2. **Qualification Rate**: % chat che identificano il tipo
3. **Lead Capture Rate**: % che lasciano email
4. **Redirect Rate**: % che arrivano alla landing step2

### Log consigliati:
- Aggiungi un nodo **HTTP Request** per inviare eventi ad analytics
- Usa **Supabase Realtime** per monitoraggio live

---

## Prossimi Step

1. [ ] Creare landing page con widget integrato
2. [ ] Configurare dominio produzione
3. [ ] Setup analytics eventi
4. [ ] A/B test messaggi di benvenuto
5. [ ] Integrazione calendario (Calendly/Cal.com)
