-- =====================================================
-- TECH4YOU ASSISTANT - DATABASE SCHEMA
-- Project: Tech4YouAssistant (jfcwreeugwpkjywhahqn)
-- =====================================================

-- 1. TECNOLOGIE
-- Catalogo delle 120 tecnologie climate-tech
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

-- 2. SERVIZI
-- Servizi offerti a Industrial e Investor
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

-- 3. EVENTI
-- Eventi Tech4You
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

-- 4. FAQ
-- Domande frequenti per il chatbot
CREATE TABLE IF NOT EXISTS faq (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  categoria VARCHAR(100),
  domanda TEXT NOT NULL,
  risposta TEXT NOT NULL,
  ordine INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. LEADS
-- Lead generati dal chatbot
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

-- 6. CHAT HISTORY
-- Storico conversazioni per analytics
CREATE TABLE IF NOT EXISTS chat_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id VARCHAR(255) NOT NULL,
  role VARCHAR(20) CHECK (role IN ('user', 'assistant')),
  content TEXT,
  metadata JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================================================
-- INDICI PER PERFORMANCE
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_tecnologie_cluster ON tecnologie(cluster);
CREATE INDEX IF NOT EXISTS idx_tecnologie_status ON tecnologie(status);
CREATE INDEX IF NOT EXISTS idx_tecnologie_trl ON tecnologie(trl);
CREATE INDEX IF NOT EXISTS idx_leads_tipo ON leads(tipo);
CREATE INDEX IF NOT EXISTS idx_leads_score ON leads(score);
CREATE INDEX IF NOT EXISTS idx_leads_created ON leads(created_at);
CREATE INDEX IF NOT EXISTS idx_chat_history_session ON chat_history(session_id);
CREATE INDEX IF NOT EXISTS idx_chat_history_created ON chat_history(created_at);
CREATE INDEX IF NOT EXISTS idx_faq_categoria ON faq(categoria);
CREATE INDEX IF NOT EXISTS idx_eventi_data ON eventi(data);

-- =====================================================
-- DATI INIZIALI - SERVIZI
-- =====================================================
INSERT INTO servizi (nome, target, descrizione, durata, output, prezzo, cta_text) VALUES
(
  'Climate Innovation Assessment',
  'Industrial',
  'Analisi delle sfide aziendali e matching con tecnologie Tech4You. Include mappatura processi, identificazione opportunità, e roadmap implementazione.',
  '45 minuti',
  'Report con 3-5 tecnologie raccomandate + next steps',
  'Gratuito',
  'Prenota Assessment'
),
(
  'Investor Briefing',
  'Investor',
  'Presentazione deal flow personalizzata con shortlist tecnologie, schede IP, metriche team, e intro diretta ai founder.',
  '30 minuti',
  'Shortlist 5-10 deal + due diligence kit',
  'Gratuito',
  'Richiedi Briefing'
),
(
  'POC Program',
  'Industrial',
  'Programma di Proof of Concept per testare tecnologie in ambiente reale. Include setup, supporto tecnico, e valutazione risultati.',
  '3-6 mesi',
  'Report POC con metriche e raccomandazioni scale-up',
  'Su progetto',
  'Richiedi Info'
),
(
  'Technology Scouting',
  'Both',
  'Ricerca tecnologie specifiche nel network Tech4You basata su requisiti custom.',
  '2-4 settimane',
  'Shortlist tecnologie + schede comparative',
  'Su progetto',
  'Contattaci'
);

-- =====================================================
-- DATI INIZIALI - EVENTI
-- =====================================================
INSERT INTO eventi (nome, data, location, posti_disponibili, target, descrizione, programma) VALUES
(
  'Tech4You Climate Innovation Day',
  '2026-02-15',
  'Milano Bicocca',
  80,
  'Both',
  'Technology showcase dei 6 cluster con demo live, panel con ricercatori e imprese, speed matching facilitato.',
  '09:00 Welcome | 09:30 Keynote | 10:30 Cluster Showcase | 12:30 Networking Lunch | 14:00 Deep Dive Sessions | 16:00 Speed Matching | 17:30 Closing'
);

-- =====================================================
-- DATI INIZIALI - FAQ
-- =====================================================
INSERT INTO faq (categoria, domanda, risposta, ordine) VALUES
-- Generale
('Generale', 'Cos''è Tech4You?', 'Tech4You è l''Ecosistema d''Innovazione sul Climate Change, parte del programma PNRR. Connette 120 tecnologie avanzate TRL 6-9, 433 ricercatori, e 93 imprese per trasformare le sfide climatiche in vantaggi competitivi.', 1),
('Generale', 'Quali sono i 6 cluster tecnologici?', 'I cluster sono: Energy (efficienza energetica e rinnovabili), Circular (economia circolare e risorse idriche), Climate (rischio climatico e monitoraggio), AgriFood (agricoltura di precisione), Cultural (patrimonio culturale), Health (salute e nutraceutica).', 2),
('Generale', 'Cosa significa TRL?', 'Technology Readiness Level, scala da 1 a 9 che indica la maturità di una tecnologia. TRL 6-9 significa che le tecnologie sono validate in ambiente operativo e pronte per test industriali o mercato.', 3),
('Generale', 'Quante tecnologie avete disponibili?', 'Abbiamo 120 prototipi TRL 6-9 distribuiti in 6 cluster: Energy (25), Circular (27), Climate (26), AgriFood (15), Cultural (17), Health (8).', 4),

-- Per Aziende
('Per Aziende', 'Come posso accedere alle tecnologie?', 'Il primo step è un Climate Innovation Assessment gratuito di 45 minuti dove analizziamo le tue sfide e identifichiamo le tecnologie più rilevanti.', 10),
('Per Aziende', 'Quanto costa un POC?', 'I costi variano in base alla complessità. Molti POC sono co-finanziati attraverso bandi PNRR, Horizon Europe o accordi per l''innovazione.', 11),
('Per Aziende', 'Quali settori industriali supportate?', 'Supportiamo tutti i settori impattati dal climate change: manifatturiero, energy, utility, food & beverage, agricoltura, turismo, PA, e altri.', 12),
('Per Aziende', 'Quanto dura un POC tipico?', 'Un POC dura tipicamente 3-6 mesi, a seconda della complessità tecnologica e degli obiettivi di validazione.', 13),

-- Per Investitori
('Per Investitori', 'Che tipo di deal flow offrite?', 'Offriamo accesso a 120 tecnologie pre-screened con IP validato, TRL 6-9, team accademici pronti per spin-off o licensing.', 20),
('Per Investitori', 'Come funziona l''Investor Briefing?', 'È una call di 30 minuti dove presentiamo una shortlist personalizzata di 5-10 deal basata sui tuoi criteri di investimento, con schede tecniche e intro ai team.', 21),
('Per Investitori', 'Quali round sono disponibili?', 'Le opportunità variano da pre-seed a Series A, con ticket da €500K a €5M. Molte tecnologie hanno già validazione industriale tramite POC.', 22),
('Per Investitori', 'Quanti brevetti avete nel portfolio?', 'Il portfolio include 65 brevetti distribuiti tra i vari cluster, con freedom-to-operate verificato.', 23),

-- Eventi
('Eventi', 'Cos''è il Climate Innovation Day?', 'È l''evento annuale Tech4You a Milano Bicocca con demo live delle tecnologie, panel con ricercatori, e speed matching tra aziende, investitori e team di ricerca.', 30),
('Eventi', 'Come posso partecipare agli eventi?', 'Puoi richiedere l''accesso tramite il nostro assistente o compilando il form sul sito. I posti sono limitati e la selezione è basata sul profilo.', 31);

-- =====================================================
-- ROW LEVEL SECURITY (opzionale, per produzione)
-- =====================================================
-- ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE chat_history ENABLE ROW LEVEL SECURITY;

-- Policy per inserimento anonimo (chatbot)
-- CREATE POLICY "Allow anonymous insert" ON leads FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Allow anonymous insert" ON chat_history FOR INSERT WITH CHECK (true);
