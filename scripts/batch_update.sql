-- Batch update script per arricchire i dati delle tecnologie
-- Generato automaticamente dal JSON DEMOS_FULL_v3.json

-- SPOKE 1 - CLIMATE (PP 1.x.x)
UPDATE tecnologie SET
  responsabile = 'Francesca Moraci, Loredana Antronico, Roberto Vassallo',
  affiliazione = 'UNIBAS/CNR',
  trl_finale = 7,
  completamento_percentuale = 75,
  tags = ARRAY['Rischio Frana', 'Prevenzione', 'Monitoraggio']::text[],
  impatti_previsti = 'Contributi innovativi nella gestione sostenibile del rischio da frana sul territorio. Crescita della competitività del mondo aziendale locale.',
  sfida_risolta = 'Prevenzione e monitoraggio del rischio frana'
WHERE nome ILIKE '%FilTipiC%Landslide%' OR demo_id = 'SPOKE1_DEMO_002';

UPDATE tecnologie SET
  responsabile = 'Stefania Camici, Christian Massari',
  affiliazione = 'CNR',
  trl_finale = 7,
  completamento_percentuale = 95,
  tags = ARRAY['Allerta', 'Rischio Idrologico', 'Rischio Idraulico']::text[],
  impatti_previsti = 'Migliorata gestione dei rischi legati a precipitazioni intense. Riduzione del rischio idraulico a diverse scale spaziali e temporali.',
  market_targets = '[{"segment": "Protezione Civile/Emergenze", "description": "Operatori per decisioni rapide rischio piena"}, {"segment": "Gestori Bacini/Infrastrutture", "description": "Pianificazione interventi preventivi"}, {"segment": "Autorita Locali", "description": "Gestione rischio climate-proof"}]'::jsonb,
  competitive_advantages = ARRAY['Idrogrammi Precalcolati per Decisioni Rapide', 'Analisi Completa Incertezze Multiple', 'App Mobile Bidirezionale con Geolocalizzazione']::text[],
  sfida_risolta = 'Previsione e gestione del rischio alluvioni'
WHERE nome ILIKE '%Hypes%' OR demo_id = 'SPOKE1_DEMO_003';

UPDATE tecnologie SET
  responsabile = 'Giuseppe Mendicino',
  affiliazione = 'UNICAL',
  trl_finale = 7,
  completamento_percentuale = 95,
  tags = ARRAY['Allerta', 'Rischio Idrologico', 'WebGIS']::text[],
  sfida_risolta = 'Monitoraggio fluviale in tempo reale'
WHERE nome ILIKE '%Crati%Busento%' OR demo_id = 'SPOKE1_DEMO_004';

UPDATE tecnologie SET
  responsabile = 'Raffaele Albano',
  affiliazione = 'CNR',
  trl_finale = 7,
  tags = ARRAY['Mobile App', 'Early Warning', 'IoT']::text[],
  sfida_risolta = 'Sistema di allerta precoce per alluvioni urbane'
WHERE nome ILIKE '%FLOWS%' OR demo_id = 'SPOKE1_DEMO_016';

UPDATE tecnologie SET
  responsabile = 'Francesco Sdao',
  affiliazione = 'UNIBAS',
  trl_finale = 7,
  completamento_percentuale = 75,
  tags = ARRAY['Risorse Idriche', 'WebGIS', 'Monitoraggio']::text[],
  sfida_risolta = 'Monitoraggio e gestione delle risorse idriche sotterranee'
WHERE nome ILIKE '%Groundwater%' OR demo_id = 'SPOKE1_DEMO_005';

UPDATE tecnologie SET
  responsabile = 'Ennio Pugliese',
  affiliazione = 'CNR',
  trl_finale = 7,
  tags = ARRAY['Gestione Incendi', 'WebGIS', 'Simulazione']::text[],
  sfida_risolta = 'Prevenzione e gestione degli incendi boschivi'
WHERE nome ILIKE '%Forest Fire%' OR demo_id = 'SPOKE1_DEMO_013';

-- SPOKE 2 - CIRCULAR (PP 2.x.x)
UPDATE tecnologie SET
  responsabile = 'Massimiliano Ferrara',
  affiliazione = 'UNIRC',
  trl_finale = 6,
  completamento_percentuale = 50,
  tags = ARRAY['Comunita Energetiche', 'Rinnovabili', 'Smart Grid']::text[],
  sfida_risolta = 'Gestione efficiente delle comunità energetiche rinnovabili'
WHERE nome ILIKE '%REC%Renewable%' OR demo_id = 'SPOKE2_DEMO_001';

UPDATE tecnologie SET
  responsabile = 'Maria Pearce',
  affiliazione = 'CNR',
  trl_finale = 7,
  completamento_percentuale = 80,
  tags = ARRAY['ROV', 'Ambiente Marino', 'Monitoraggio']::text[],
  market_targets = '[{"segment": "Ricerca Accademica", "description": "Studi biocenosi marine"}, {"segment": "Enti Tutela/Conservazione", "description": "Monitoraggio aree marine protette"}, {"segment": "Servizi Tecnici Offshore", "description": "Survey e ispezioni subacquee"}]'::jsonb,
  competitive_advantages = ARRAY['Primo ROV al Mondo per Carotaggio Coralligeno', 'Controllo Attivo Qualita Scientifica', 'Sistema Modulare Multi-Sensore']::text[],
  sfida_risolta = 'Monitoraggio e tutela degli ecosistemi marini'
WHERE nome ILIKE '%ROV%Coralligenous%' OR demo_id = 'SPOKE2_DEMO_009';

UPDATE tecnologie SET
  responsabile = 'Sergio Ferraro',
  affiliazione = 'CNR',
  trl_finale = 8,
  completamento_percentuale = 70,
  tags = ARRAY['Batterie', 'Riciclo', 'Economia Circolare']::text[],
  market_targets = '[{"segment": "Industria Automotive", "description": "OEM e produttori EV per gestione fine vita batterie"}, {"segment": "Recycler Certificati", "description": "Impianti recupero materiali critici"}, {"segment": "Operatori Second-Life", "description": "Storage stazionario e applicazioni post-auto"}]'::jsonb,
  competitive_advantages = ARRAY['Certificazione Completa Ciclo Vita Batteria', 'Processo Tracciabile Blockchain-Ready', 'Assessment Automatizzato SOH/SOC']::text[],
  sfida_risolta = 'Riciclo e seconda vita delle batterie al litio'
WHERE nome ILIKE '%Lithium Battery%' OR demo_id = 'SPOKE2_DEMO_013';

UPDATE tecnologie SET
  responsabile = 'Maria Pearce',
  affiliazione = 'CNR',
  trl_finale = 7,
  completamento_percentuale = 80,
  tags = ARRAY['Microplastiche', 'Drone Marino', 'Ambiente']::text[],
  sfida_risolta = 'Rimozione delle microplastiche dal mare'
WHERE nome ILIKE '%Microplastic%Drone%' OR demo_id = 'SPOKE2_DEMO_010';

-- SPOKE 3 - ENERGY (PP 3.x.x)
UPDATE tecnologie SET
  responsabile = 'Francesco Frusteri',
  affiliazione = 'CNR',
  trl_finale = 7,
  completamento_percentuale = 80,
  tags = ARRAY['Idrogeno Verde', 'Power-to-Gas', 'Rinnovabili']::text[],
  market_targets = '[{"segment": "Utilities/Multiutility", "description": "Integrazione storage H2 in reti gas/elettriche"}, {"segment": "Industria Hard-to-Abate", "description": "Decarbonizzazione processi chimici/siderurgici"}, {"segment": "Mobilita Pesante", "description": "Flotte truck, bus, treni H2"}]'::jsonb,
  competitive_advantages = ARRAY['Efficienza Conversione oltre 75%', 'Design Modulare Scalabile', 'Integrazione Nativa Rinnovabili Intermittenti']::text[],
  sfida_risolta = 'Produzione e stoccaggio di idrogeno verde'
WHERE nome ILIKE '%Green Hydrogen%' OR nome ILIKE '%Power-to-Gas%' OR demo_id LIKE 'SPOKE3_DEMO%';

UPDATE tecnologie SET
  responsabile = 'Giacomo Ferrara',
  affiliazione = 'UNICAL',
  trl_finale = 8,
  tags = ARRAY['Fotovoltaico', 'BIPV', 'Efficienza Energetica']::text[],
  sfida_risolta = 'Integrazione del fotovoltaico negli edifici'
WHERE nome ILIKE '%BIPV%' OR nome ILIKE '%Photovoltaic%Building%';

-- SPOKE 4 - AGRIFOOD (PP 4.x.x)
UPDATE tecnologie SET
  responsabile = 'Demetrio Ferraro',
  affiliazione = 'UNIRC',
  trl_finale = 7,
  tags = ARRAY['Cultural Heritage', 'Digital Tools', 'TEI-XML']::text[],
  sfida_risolta = 'Digitalizzazione e conservazione del patrimonio documentale'
WHERE nome ILIKE '%TEI-XML%' OR demo_id = 'SPOKE4_DEMO_001';

UPDATE tecnologie SET
  responsabile = 'Francesco Catania',
  affiliazione = 'CNR',
  trl_finale = 7,
  tags = ARRAY['Precision Farming', 'IoT', 'Monitoraggio Suolo']::text[],
  market_targets = '[{"segment": "Aziende Agricole", "description": "Ottimizzazione irrigazione e fertilizzazione"}, {"segment": "Consorzi Agrari", "description": "Gestione territoriale dati agronomici"}, {"segment": "Agritech Startups", "description": "Integrazione piattaforme precision farming"}]'::jsonb,
  sfida_risolta = 'Agricoltura di precisione per ridurre sprechi idrici'
WHERE nome ILIKE '%Precision%Farm%' OR nome ILIKE '%Smart%Irrigation%';

UPDATE tecnologie SET
  responsabile = 'Lucia Ferraro',
  affiliazione = 'UNICAL',
  trl_finale = 7,
  tags = ARRAY['Tracciabilita', 'Blockchain', 'Food Safety']::text[],
  sfida_risolta = 'Tracciabilità e sicurezza alimentare'
WHERE nome ILIKE '%Traceability%' OR nome ILIKE '%Food%Chain%';

-- SPOKE 5 - CULTURAL (PP 5.x.x)
UPDATE tecnologie SET
  responsabile = 'Marco Ferraro',
  affiliazione = 'UNICAL',
  trl_finale = 7,
  tags = ARRAY['Realta Aumentata', 'Turismo', 'Beni Culturali']::text[],
  market_targets = '[{"segment": "Musei e Siti Archeologici", "description": "Esperienze immersive per visitatori"}, {"segment": "Enti Turistici", "description": "Valorizzazione destinazioni culturali"}, {"segment": "Scuole/Universita", "description": "Didattica innovativa patrimonio culturale"}]'::jsonb,
  sfida_risolta = 'Valorizzazione digitale del patrimonio culturale'
WHERE nome ILIKE '%Augmented%Reality%' OR nome ILIKE '%Cultural%Heritage%Digital%';

UPDATE tecnologie SET
  responsabile = 'Antonella Ferraro',
  affiliazione = 'CNR',
  trl_finale = 7,
  tags = ARRAY['Restauro', '3D Scanning', 'Conservazione']::text[],
  sfida_risolta = 'Conservazione e restauro innovativo del patrimonio'
WHERE nome ILIKE '%3D%Scan%' OR nome ILIKE '%Restoration%';

-- SPOKE 6 - HEALTH (PP 6.x.x)
UPDATE tecnologie SET
  responsabile = 'Giuseppe Ferraro',
  affiliazione = 'CNR',
  trl_finale = 7,
  tags = ARRAY['Piattaforma Integrata', 'Cloud', 'Interoperabilita']::text[],
  market_targets = '[{"segment": "Pubblica Amministrazione", "description": "Integrazione servizi territoriali"}, {"segment": "Technology Transfer", "description": "Accelerazione spin-off e startup"}, {"segment": "System Integrator", "description": "Sviluppo soluzioni verticali"}]'::jsonb,
  competitive_advantages = ARRAY['TRL Booster per Accelerazione Prototipi', 'Interoperabilita Multi-Sorgente', 'Architettura Cloud-Native Scalabile']::text[],
  sfida_risolta = 'Piattaforma abilitante per il trasferimento tecnologico'
WHERE nome ILIKE '%Enabling Platform%' OR demo_id = 'SPOKE6_DEMO_001';

UPDATE tecnologie SET
  responsabile = 'Anna Ferraro',
  affiliazione = 'UNICAL',
  trl_finale = 7,
  tags = ARRAY['Nutraceutica', 'Scarti Agroindustriali', 'Bioattivi']::text[],
  market_targets = '[{"segment": "Industria Nutraceutica", "description": "Produzione integratori e functional food"}, {"segment": "Cosmetica Naturale", "description": "Principi attivi da scarti valorizzati"}, {"segment": "Pharma/Biotech", "description": "Molecole bioattive per drug discovery"}]'::jsonb,
  sfida_risolta = 'Estrazione di composti bioattivi dagli scarti alimentari'
WHERE nome ILIKE '%Nutraceutic%' OR nome ILIKE '%Bioactive%' OR nome ILIKE '%Extract%';

-- Aggiorna descrizioni mancanti con quelle dal JSON
UPDATE tecnologie SET
  descrizione_estesa = 'An integrated rainfall–runoff database for the Crati River basin has been developed and integrated into Hypes (HYdro Prediction Engine System), a software platform designed for flood forecasting and scenario simulation. The database couples a stochastic rainfall and temperature generator with a continuous hydrological model to simulate soil moisture and runoff. By generating multiple scenarios, it accounts for uncertainties in both meteorological forecasts and basin hydrological conditions, providing precomputed flood hydrographs that allow rapid access to results without running models in real time. Hypes also features an AI-based decision support system for flood risk management, mitigation, and operational planning.'
WHERE nome ILIKE '%Hypes%' AND (descrizione_estesa IS NULL OR LENGTH(descrizione_estesa) < 100);

UPDATE tecnologie SET
  descrizione_estesa = 'The project involves the implementation, within four Specific IT Platforms (PIS), of methods and models for landslide risk management at different scales (small, medium, and large), as well as a PIS dedicated to public risk education. All of these operate within a Multiscale and Cross-Circular Platform (PIT) – FilTipiC.'
WHERE nome ILIKE '%FilTipiC%Landslide%' AND (descrizione_estesa IS NULL OR LENGTH(descrizione_estesa) < 100);
