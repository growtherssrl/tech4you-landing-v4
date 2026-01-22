# Strategia Agente AI Tech4You

## Obiettivo Primario

**Convertire visitatori in lead qualificati che prenotano una call.**

Non è un chatbot informativo. È un **sales assistant** che:
1. Qualifica l'utente (Industrial vs Investor)
2. Identifica la sfida/interesse specifico
3. Presenta soluzioni rilevanti
4. Guida verso la CTA appropriata

---

## Funnel Conversazionale

```
┌─────────────────────────────────────────────────────────────┐
│  AWARENESS                                                   │
│  "Ciao! Sono qui per aiutarti a scoprire come le            │
│   tecnologie climate-tech possono risolvere le tue sfide."  │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  QUALIFICATION                                               │
│  Domande strategiche per capire:                            │
│  • Tipo utente (Industrial / Investor / Altro)              │
│  • Settore / Cluster di interesse                           │
│  • Sfida specifica o obiettivo                              │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  MATCHING                                                    │
│  Query database per trovare:                                │
│  • 2-3 tecnologie rilevanti                                 │
│  • Metriche di impatto concrete                             │
│  • Demo flagship con TRL                                    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  CONVERSION                                                  │
│  Industrial → "Prenota Climate Innovation Assessment"       │
│  Investor → "Richiedi Investor Briefing"                    │
│  + Raccolta email aziendale                                 │
└─────────────────────────────────────────────────────────────┘
```

---

## Cosa Deve Fare l'Agente

### 1. Accoglienza Intelligente
- Saluto personalizzato basato su contesto (orario, fonte)
- Domanda aperta per iniziare discovery
- Tono professionale ma accessibile

### 2. Qualificazione Progressiva
- **1-2 domande** per identificare il tipo utente
- Non interrogatorio, ma conversazione naturale
- Riconoscere segnali impliciti nel linguaggio

**Segnali Industrial:**
- Parla di "processi", "efficienza", "costi operativi"
- Menziona ruoli come "operations", "R&D", "sustainability"
- Chiede "come funziona", "quanto costa implementare"

**Segnali Investor:**
- Parla di "portfolio", "deal flow", "exit"
- Menziona "ticket", "round", "valuation"
- Chiede "IP", "team", "traction"

### 3. Discovery della Sfida
- Identificare il cluster di interesse
- Capire la sfida specifica (usare gli hook del documento)
- Quantificare il problema se possibile

### 4. Matching Tecnologie
- Query database con filtri intelligenti
- Presentare **max 3 tecnologie** rilevanti
- Per ogni tecnologia:
  - Nome + TRL
  - Descrizione breve (1-2 righe)
  - Metrica di impatto chiave
  - Perché è rilevante per loro

### 5. Gestione Obiezioni
- "Non ho tempo" → Offri materiale da leggere + follow-up
- "Devo parlare con il team" → Proponi call con più persone
- "Quanto costa?" → Focus su ROI, poi costi su misura
- "È troppo early stage" → Evidenzia TRL 7+ e POC completati

### 6. Conversione
- CTA chiara e specifica
- Raccolta dati progressiva (nome → azienda → email)
- Conferma immediata + next steps

---

## Casi d'Uso

### Caso 1: Landing Page Dedicata (Primario)
```
Pagina: tech4you.it/assistant o tech4you.it/scopri
Widget: Chat a tutto schermo o sidebar
Trigger: Automatico dopo 5 secondi
```

**Pro:** Utente già interessato, contesto chiaro
**Conversion target:** 15-25% lead capture

### Caso 2: Widget su Sito Principale
```
Posizione: Bottom-right, minimizzato
Trigger: Click utente o scroll 50%
```

**Pro:** Cattura visitatori esplorativi
**Conversion target:** 5-10% lead capture

### Caso 3: Post-Form Follow-up
```
Trigger: Dopo compilazione form landing step 1
Contesto: Già sappiamo tipo utente e cluster
```

**Pro:** Utente già qualificato, personalizzazione massima
**Conversion target:** 30-40% booking call

### Caso 4: LinkedIn Ads → Landing + Chat
```
Flow: Ad → Landing dedicata → Chat proattivo
Messaggio: Personalizzato per messaggio dell'ad
```

**Pro:** Continuità messaggio, alta intent
**Conversion target:** 20-30% lead capture

### Caso 5: Email Nurturing Integration
```
Trigger: Link in email → Landing con chat precompilato
Contesto: Storico interazioni email
```

**Pro:** Utente già in nurturing, relazione esistente
**Conversion target:** 25-35% booking call

---

## Metriche di Successo

### Primary KPIs
| Metrica | Target | Descrizione |
|---------|--------|-------------|
| Conversation Start Rate | >60% | % visitatori che iniziano chat |
| Qualification Rate | >70% | % chat che identifica tipo utente |
| Lead Capture Rate | >20% | % chat che raccoglie email |
| Booking Rate | >10% | % lead che prenota call |

### Secondary KPIs
| Metrica | Target | Descrizione |
|---------|--------|-------------|
| Avg Messages per Conv | 6-10 | Conversazioni né troppo corte né lunghe |
| Time to Lead | <3 min | Velocità raccolta dati |
| Cluster Match Rate | >80% | Accuratezza matching tecnologie |
| User Satisfaction | >4/5 | Rating post-conversazione |

---

## Differenziazione per Target

### Industrial R&D
**Tono:** Tecnico-consulenziale
**Focus:** ROI, efficienza, compliance, timeline
**Pain points:** Costi operativi, normative, competitività
**CTA:** Climate Innovation Assessment (45 min, gratuito)
**Hook:** "Scopri come ridurre [X] del [Y]% in [Z] mesi"

### Innovation Investor
**Tono:** Business-oriented, esclusivo
**Focus:** Deal flow, IP, team, exit potential
**Pain points:** Qualità pipeline, due diligence, accesso
**CTA:** Investor Briefing (30 min, gratuito)
**Hook:** "Accedi a deal flow pre-screened che non trovi altrove"

---

## Personalizzazione Contestuale

### Per Fonte di Traffico
```javascript
if (utm_source === 'linkedin') {
  // Messaggio coerente con ad
  initialMessage = "Hai visto il nostro post su [topic]? Posso approfondire."
}

if (utm_campaign === 'energy') {
  // Preseleziona cluster
  context.cluster = 'Energy'
  initialMessage = "Interessato alle soluzioni energy? Dimmi di più sulla tua sfida."
}
```

### Per Pagina
```javascript
if (page === '/cluster/circular') {
  context.cluster = 'Circular'
  initialMessage = "Stai esplorando le tecnologie Circular Economy. Quale sfida vuoi risolvere?"
}
```

### Per Storico (se disponibile)
```javascript
if (returning_visitor) {
  initialMessage = "Bentornato! L'ultima volta stavamo parlando di [topic]. Vuoi continuare?"
}
```

---

## Flussi Conversazionali Chiave

### Flusso 1: Nuovo Visitatore (Unknown)
```
Bot: Ciao! Sono l'assistente Tech4You. Aiuto aziende e investitori
     a scoprire tecnologie climate-tech innovative.
     Sei qui per la tua azienda o come investitore?

[Utente risponde]

Bot: [Se Industrial] Perfetto! In quale settore operate?
     [Se Investor] Ottimo! Che tipo di opportunità stai cercando?

[Discovery continua...]
```

### Flusso 2: Visitatore da Ad LinkedIn (Known Intent)
```
Bot: Ciao! Ho visto che sei arrivato dal nostro post su
     [efficienza energetica]. Lavori in questo settore?

[Utente conferma]

Bot: Quale sfida ti interessa di più?
     • Ottimizzazione produzione fotovoltaica
     • Storage per comunità energetiche
     • Efficienza edifici esistenti

[Matching diretto...]
```

### Flusso 3: Post-Form (Highly Qualified)
```
Bot: Grazie [Nome]! Ho visto che sei interessato al cluster [X]
     per [obiettivo]. Ho trovato 3 tecnologie perfette per te.

[Presenta tecnologie]

Bot: Quale ti interessa approfondire? Oppure posso prenotarti
     direttamente un Assessment con un nostro esperto.
```

---

## Integrazioni Necessarie

### Database (Supabase)
- Query tecnologie per cluster/sfida
- Query FAQ per domande comuni
- Salvataggio lead + score
- Storico conversazioni

### Calendar (Calendly/Cal.com)
- Booking diretto Assessment/Briefing
- Link personalizzato per tipo utente
- Sync con CRM

### Email (SendGrid/Resend)
- Conferma booking
- Invio materiali post-conversazione
- Notifica team per lead HOT

### Analytics
- Eventi conversazione (start, qualification, lead, booking)
- Funnel analysis
- A/B test messaggi

---

## Rischi e Mitigazioni

| Rischio | Mitigazione |
|---------|-------------|
| Utente frustrato da troppe domande | Max 3-4 domande prima di dare valore |
| Matching sbagliato | Sempre offrire "Nessuna di queste? Dimmi di più" |
| Richieste fuori scope | Handoff a email team con contesto |
| Lead non qualificati | Scoring automatico + prioritizzazione |
| Abuso/spam | Rate limiting + validazione email aziendale |

---

## Evoluzione Futura

### Fase 1 (MVP)
- Chat su landing dedicata
- Qualificazione base
- Matching tecnologie
- Lead capture

### Fase 2 (Optimization)
- A/B test messaggi
- Personalizzazione per fonte
- Integrazione calendar
- Email automation

### Fase 3 (Scale)
- Multi-lingua
- Voice assistant
- WhatsApp Business
- CRM integration avanzata
