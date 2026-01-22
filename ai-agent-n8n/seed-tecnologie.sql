-- =====================================================
-- TECH4YOU - SEED TECNOLOGIE (30 Demo Flagship)
-- Fonte: Sfide industriali tech4you.rtf
-- =====================================================

-- CLUSTER: ENERGY (5 tecnologie)
INSERT INTO tecnologie (nome, cluster, trl, descrizione_breve, descrizione_estesa, sfida_risolta, metriche_impatto, team_ricerca, brevetti, status) VALUES

-- ENERGY 1
(
  'SMPPT AI Algorithm for Photovoltaic Optimization',
  'Energy',
  7,
  'Algoritmo AI per ottimizzazione MPPT fotovoltaico',
  'Gli impianti fotovoltaici operano spesso al di sotto del potenziale a causa di algoritmi MPPT non ottimali, perdendo fino al 15-20% di energia producibile in condizioni variabili di irraggiamento. SMPPT è un algoritmo AI testato che migliora il tracking del punto di massima potenza anche in condizioni di ombreggiamento parziale.',
  'Ottimizzazione della Produzione Fotovoltaica',
  '8-12% incremento produzione annua; per impianto 1MW = +80-120 MWh/anno = €12.000-18.000/anno risparmiati',
  'SPOKE2',
  1,
  'Disponibile'
),

-- ENERGY 2
(
  'Smart Microgrids with Dual Storage (Battery + Hydrogen)',
  'Energy',
  7,
  'Sistema storage ibrido batterie + idrogeno per microgrids',
  'Le comunità energetiche e le microgrids necessitano di sistemi di storage flessibili che bilancino costi, durata e velocità di risposta. Il sistema integra batterie al litio per la risposta rapida e idrogeno verde per lo storage stagionale, già testato in ambiente operativo.',
  'Storage Energetico Ibrido per Microgrids',
  'Riduzione 20-30% costi storage; aumento autonomia da 4h a 48h; incremento autoconsumo REC dal 40% all''80%',
  'SPOKE2',
  2,
  'Disponibile'
),

-- ENERGY 3
(
  'U-OWC Wave Energy Converter',
  'Energy',
  7,
  'Convertitore energia dal moto ondoso integrabile in infrastrutture',
  'Le zone costiere hanno un enorme potenziale energetico dal moto ondoso, ma le tecnologie tradizionali sono costose e invasive. La tecnologia OWC (Oscillating Water Column) converte l''energia delle onde in elettricità senza parti mobili sommerse. Testato presso il laboratorio NOEL di Reggio Calabria con efficienza del 35%.',
  'Energia dal Moto Ondoso',
  'Potenziale 2-5 kW/m di fronte ondoso; integrazione in porti e dighe senza nuove strutture; costo energia competitivo con offshore wind',
  'SPOKE2 - NOEL Reggio Calabria',
  2,
  'Disponibile'
),

-- ENERGY 4
(
  'Trombe Wall Innovative Solution',
  'Energy',
  7,
  'Pareti Trombe di nuova generazione per efficienza edifici',
  'Il retrofit energetico degli edifici esistenti è costoso e invasivo. Le pareti Trombe di nuova generazione accumulano calore solare d''inverno e ventilano naturalmente d''estate, senza consumi. Sistema installato e validato in edifici universitari, dimostrando -35% sui consumi di climatizzazione.',
  'Efficienza Energetica degli Edifici Esistenti',
  'Riduzione 25-40% consumi HVAC; payback 3-5 anni senza incentivi; miglioramento classe energetica di 1-2 livelli',
  'SPOKE2',
  1,
  'Disponibile'
),

-- ENERGY 5
(
  'REC Management Platform',
  'Energy',
  6,
  'Piattaforma gestione Comunità Energetiche Rinnovabili',
  'Le Comunità Energetiche Rinnovabili richiedono piattaforme software per ottimizzare produzione, consumo e scambio energia tra membri. La piattaforma integra previsioni meteo, profili di consumo e algoritmi di ottimizzazione per massimizzare gli incentivi GSE.',
  'Gestione Intelligente delle Comunità Energetiche (REC)',
  '+15-25% energia condivisa rispetto a gestione manuale; conformità automatica normativa GSE; riduzione tempi amministrativi 80%',
  'SPOKE2',
  0,
  'Disponibile'
),

-- CLUSTER: CIRCULAR_WATER (5 tecnologie)

-- CIRCULAR 1
(
  'Experimental Plant for Lithium Battery Recycling',
  'Circular',
  8,
  'Impianto pilota riciclo batterie litio con processo idrometallurgico',
  'L''esplosione della mobilità elettrica genera milioni di batterie a fine vita. Il riciclo tradizionale recupera solo il 50% dei materiali critici. L''impianto pilota ha dimostrato recupero >90% di litio e cobalto con processo a basso impatto, già testato su scala semi-industriale.',
  'Riciclo Batterie al Litio',
  'Recupero 90%+ materiali critici; riduzione import materie prime strategiche; valore recuperato €15-25/kg batteria',
  'SPOKE2',
  3,
  'Disponibile'
),

-- CIRCULAR 2
(
  'Wastewater Treatment Pilot Plant for Biomass Cultivation',
  'Circular',
  7,
  'Impianto pilota trattamento reflui con coltivazione microalghe',
  'Le acque reflue industriali e urbane contengono nutrienti valorizzabili, ma i trattamenti tradizionali li disperdono. L''impianto pilota a Metaponto tratta 50 m3/giorno di reflui producendo biomassa per biocarburanti e fertilizzanti organici.',
  'Trattamento Acque Reflue per Riuso',
  'Recupero 80% acqua per riuso; produzione biomassa algale 10-20 t/ha/anno; riduzione costi depurazione 30-40%',
  'SPOKE2 - Metaponto',
  1,
  'Disponibile'
),

-- CIRCULAR 3
(
  'Marine Drone for Microplastic Removal',
  'Circular',
  7,
  'Drone marino autonomo per raccolta microplastiche con piattaforma digitale',
  'Le microplastiche inquinano i mari e entrano nella catena alimentare. Il Marine Drone integra raccolta, analisi e georeferenziazione delle microplastiche, già testato nel porto di Cetraro con 85% efficacia.',
  'Rimozione Microplastiche dalle Acque Marine',
  'Rimozione 80-90% microplastiche in aree portuali; copertura 10.000 m2/giorno per unità; dati real-time su inquinamento',
  'SPOKE2',
  1,
  'Disponibile'
),

-- CIRCULAR 4
(
  'CO2 Valorization System for Biogas',
  'Circular',
  7,
  'Sistema cattura e valorizzazione CO2 da biogas',
  'Gli impianti biogas producono 40-50% di CO2, attualmente emessa o dispersa. Il sistema installato presso UNICAL cattura e purifica la CO2 del biogas per usi industriali, con payback < 3 anni.',
  'Valorizzazione CO2 da Biogas',
  'Recupero 200-400 kg CO2/giorno per impianto 1MW; valore €50-100/tonnellata; carbon credit aggiuntivi',
  'SPOKE2 - UNICAL Campus',
  1,
  'Disponibile'
),

-- CIRCULAR 5
(
  'YOLOv8 Algorithm for Marine Species Photo-Identification',
  'Circular',
  8,
  'Algoritmo AI per identificazione automatica specie marine',
  'La tutela degli ecosistemi marini richiede monitoraggi frequenti e costosi. L''algoritmo YOLOv8, addestrato su 50.000 immagini di fauna mediterranea, automatizza il censimento delle specie dimezzando tempi e costi.',
  'Monitoraggio Ecosistemi Marini',
  'Riduzione 80% tempi monitoraggio; copertura 10x maggiore a parità di budget; dati standardizzati per reporting MSFD',
  'SPOKE2',
  0,
  'Disponibile'
),

-- CLUSTER: CLIMATE_RISK (5 tecnologie)

-- CLIMATE 1
(
  'Hypes - HYdro Prediction Engine System',
  'Climate',
  7,
  'Sistema predittivo AI per previsione e allerta alluvioni',
  'I sistemi di early warning esistenti hanno preavvisi troppo brevi (1-2 ore). Hypes integra database afflusso-deflusso, generatore stocastico meteo e AI decisionale: testato sul bacino del Crati con 95% affidabilità.',
  'Previsione e Allerta Alluvioni',
  'Preavviso esteso a 6-12 ore; riduzione 50% falsi allarmi; riduzione danni alluvionali 30-50%',
  'SPOKE1',
  1,
  'Disponibile'
),

-- CLIMATE 2
(
  'FilTipiC - Multiscale Platform with LabSit Integration',
  'Climate',
  7,
  'Piattaforma multi-scala per gestione rischio frane',
  'L''Italia ha 600.000 frane attive, ma i sistemi di monitoraggio sono frammentati. FilTipiC integra i LabSit calabresi in una piattaforma multi-scala che monitora frane lente e rapide in tempo reale.',
  'Gestione Rischio Frane',
  'Copertura 100% aree a rischio con sensori IoT low-cost; riduzione tempi risposta emergenza 60%; ottimizzazione interventi manutenzione',
  'SPOKE1',
  0,
  'Disponibile'
),

-- CLIMATE 3
(
  'Real-Time Fire Monitoring System',
  'Climate',
  7,
  'Sistema monitoraggio incendi in tempo reale con AI',
  'Gli incendi vengono rilevati quando sono già estesi. Il sistema installato nel Parco della Sila monitora 50.000 ettari con 8 telecamere termiche, riducendo del 50% il tempo di intervento.',
  'Prevenzione Incendi Boschivi',
  'Riduzione tempo detection da 30 a 5 minuti; riduzione area bruciata 40-60%; ottimizzazione posizionamento mezzi',
  'SPOKE1 - Sila National Park',
  1,
  'Disponibile'
),

-- CLIMATE 4
(
  'BaC DSS - Drought Analysis System',
  'Climate',
  7,
  'Sistema decisionale per analisi siccità con campo sperimentale',
  'Le siccità ricorrenti richiedono sistemi decisionali per gestire la risorsa idrica. BaC DSS integra dati meteo, satellitari e di campo per supportare le decisioni di gestione idrica in Calabria e Basilicata.',
  'Monitoraggio Siccità e Gestione Risorsa Idrica',
  'Ottimizzazione allocazione idrica tra settori; riduzione perdite irrigue 30-40%; early warning siccità con 3 mesi anticipo',
  'SPOKE1',
  0,
  'Disponibile'
),

-- CLIMATE 5
(
  'AI Vision System for Bridge Structural Defect Detection',
  'Climate',
  6,
  'Sistema AI per rilevamento difetti strutturali ponti',
  'Ponti, viadotti e edifici pubblici richiedono ispezioni manuali costose. Il sistema AI Vision ha analizzato 50 ponti calabresi, creando un database georeferenziato dei difetti per pianificare le manutenzioni.',
  'Monitoraggio Strutturale Infrastrutture',
  'Riduzione 70% costi ispezione; copertura 100% patrimonio infrastrutturale; prioritizzazione oggettiva manutenzioni',
  'SPOKE1',
  1,
  'Disponibile'
),

-- CLUSTER: AGRIFOOD (5 tecnologie)

-- AGRIFOOD 1
(
  'Smart Water Platform with IRRIFRAME Integration',
  'AgriFood',
  7,
  'Piattaforma irrigazione di precisione con integrazione IRRIFRAME',
  'L''irrigazione tradizionale spreca 30-50% dell''acqua. La Smart Water Platform integra IRRIFRAME, sensori IoT e previsioni meteo per consigliare quando e quanto irrigare ogni parcella.',
  'Irrigazione di Precisione',
  'Risparmio idrico 30-50%; aumento rese 10-15%; riduzione costi energetici pompaggio 40%',
  'SPOKE3',
  0,
  'Disponibile'
),

-- AGRIFOOD 2
(
  'WoodTrace 4.0 - Blockchain Platform for Forest-Wood Supply Chain',
  'AgriFood',
  7,
  'Piattaforma blockchain per tracciabilità filiera legno-foresta',
  'I consumatori richiedono trasparenza sulla filiera. WoodTrace 4.0 traccia la filiera legno-foresta con blockchain, già conforme al Regolamento UE anti-deforestazione.',
  'Tracciabilità della Filiera Agroalimentare',
  'Premium price 10-20% per prodotti tracciati; accesso mercati GDO premium; conformità Reg. UE 2023/1115 (deforestazione)',
  'SPOKE3',
  0,
  'Disponibile'
),

-- AGRIFOOD 3
(
  'GreenHouse Smart Platform for Soilless Cultivation',
  'AgriFood',
  6,
  'Piattaforma smart per serre idroponiche con raccolta robotizzata',
  'L''agricoltura tradizionale dipende da stagioni e clima. La GreenHouse Smart Platform integra coltivazione idroponica, sensori ambientali e raccolta robotizzata per produzioni orticole premium.',
  'Agricoltura Verticale e Serre Smart',
  'Produzione 10-20x per m2; riduzione 90% consumo acqua vs pieno campo; produzione tutto l''anno',
  'SPOKE3',
  1,
  'Disponibile'
),

-- AGRIFOOD 4
(
  'PASCOLO - IoT Livestock Monitoring System',
  'AgriFood',
  7,
  'Sistema IoT monitoraggio allevamenti estensivi',
  'Gli allevamenti estensivi sono difficili da monitorare. PASCOLO monitora bovini e ovini al pascolo con GPS, accelerometri e alert automatici, testato su 500 capi in Calabria.',
  'Monitoraggio Allevamenti Estensivi',
  'Riduzione 80% perdite per smarrimento; early detection malattie; ottimizzazione rotazione pascoli',
  'SPOKE3',
  0,
  'Disponibile'
),

-- AGRIFOOD 5
(
  'Orange Peel Waste Full Valorization Technologies',
  'AgriFood',
  6,
  'Tecnologie valorizzazione completa scarti agrumi',
  'L''industria agroalimentare produce milioni di tonnellate di scarti smaltiti come rifiuti. Le tecnologie estraggono pectine, limonene e bioattivi dalle bucce d''arancia, trasformando un costo in un ricavo.',
  'Valorizzazione Scarti Agroalimentari',
  'Valorizzazione 60-80% scarti; produzione bioplastiche, nutraceutici, mangimi; economia circolare certificata',
  'SPOKE3',
  2,
  'Disponibile'
),

-- CLUSTER: CULTURAL_HERITAGE (5 tecnologie)

-- CULTURAL 1
(
  'ARCHEOrecords - Archaeological Documentation Mobile App',
  'Cultural',
  9,
  'App mobile per documentazione archeologica conforme ICCD',
  'La documentazione di scavi e siti archeologici è ancora largamente manuale. ARCHEOrecords è l''unica app italiana per documentazione archeologica mobile con export ICCD, già usata in 15 scavi.',
  'Documentazione Archeologica Digitale',
  'Riduzione 60% tempi documentazione; dati strutturati e ricercabili; conformità standard nazionali',
  'SPOKE4',
  0,
  'Disponibile'
),

-- CULTURAL 2
(
  'XR Platform for Cultural Heritage',
  'Cultural',
  7,
  'Piattaforma XR con authoring tool per esperienze AR/VR',
  'Molti siti culturali non sono visitabili o offrono esperienze poco coinvolgenti. La piattaforma XR include authoring tool per creare esperienze AR/VR senza programmazione, già usata per 5 siti UNESCO.',
  'Fruizione Immersiva del Patrimonio',
  'Accessibilità 100% siti inaccessibili; aumento permanenza visitatori 40%; nuovi ricavi da esperienze XR',
  'SPOKE4',
  1,
  'Disponibile'
),

-- CULTURAL 3
(
  'SOCRATE - AI-Powered Cultural Itinerary Platform',
  'Cultural',
  7,
  'Piattaforma AI per itinerari culturali personalizzati',
  'I flussi turistici si concentrano sui siti principali, mentre il patrimonio diffuso resta invisibile. SOCRATE genera itinerari culturali su misura per Basilicata e Calabria, integrando 500+ punti di interesse minori.',
  'Itinerari Turistici Intelligenti',
  'Redistribuzione 20-30% flussi su siti minori; aumento permanenza media territoriale; destagionalizzazione',
  'SPOKE6',
  0,
  'Disponibile'
),

-- CULTURAL 4
(
  'Underwater Cultural Heritage Documentation System',
  'Cultural',
  8,
  'Sistema documentazione patrimonio subacqueo con drone e sensori',
  'I siti archeologici subacquei sono difficili da documentare e impossibili da fruire. Il sistema ha documentato relitti e siti sommersi in Calabria, creando tour virtuali fruibili da musei e scuole.',
  'Patrimonio Culturale Subacqueo',
  'Documentazione 100% siti subacquei; accesso virtuale per non subacquei; valorizzazione turistica aree costiere',
  'SPOKE4',
  1,
  'Disponibile'
),

-- CULTURAL 5
(
  'Heritage Conservation Technologies Integrated Suite',
  'Cultural',
  7,
  'Suite integrata tecnologie conservazione preventiva beni culturali',
  'Il degrado dei beni culturali procede lentamente ma inesorabilmente. La suite integra sensori, analisi predittiva e alert per proteggere beni culturali in tempo reale.',
  'Conservazione Preventiva dei Beni Culturali',
  'Riduzione 50% costi restauro; prevenzione perdite irreversibili; pianificazione manutenzione predittiva',
  'SPOKE4',
  0,
  'Disponibile'
),

-- CLUSTER: HEALTH (5 tecnologie)

-- HEALTH 1
(
  'Functional Food and Nutraceutical Product Line',
  'Health',
  8,
  'Linea nutraceutici da scarti agroalimentari con studi clinici',
  'Il mercato dei nutraceutici cresce del 7% annuo, ma le materie prime sono costose. La linea nutraceutica ha sviluppato 12 formulazioni da scarti di agrumi, uva e olive, con studi clinici pubblicati.',
  'Nutraceutici da Scarti Agroalimentari',
  'Costo materie prime -40%; economia circolare certificata; premium positioning "from waste to wellness"',
  'SPOKE5',
  2,
  'Disponibile'
),

-- HEALTH 2
(
  'Functional Dermocosmetic Line from Agro-Food By-Products',
  'Health',
  7,
  'Linea dermocosmetici funzionali da sottoprodotti agroalimentari',
  'Il mercato cosmetico richiede ingredienti naturali, sostenibili e con efficacia dimostrata. La linea include 8 formulazioni con polifenoli da vinacce e oli essenziali da agrumi calabresi.',
  'Dermocosmetici Funzionali',
  'Premium price 30-50% per linee "bio from waste"; accesso mercati green beauty; differenziazione competitiva',
  'SPOKE5',
  1,
  'Disponibile'
),

-- HEALTH 3
(
  'SupportAI - AI Environment for Biomedical Research',
  'Health',
  6,
  'Ambiente AI no-code per ricerca biomedica',
  'L''analisi di dati genomici e proteomici richiede competenze informatiche che i ricercatori spesso non hanno. SupportAI offre pipeline preconfigurate per analisi -omiche, machine learning e visualizzazione dati biomedici.',
  'AI per la Ricerca Biomedica',
  'Accelerazione ricerca 50%; democratizzazione analisi avanzate; riduzione costi collaborazioni bioinformatiche',
  'SPOKE6',
  0,
  'Disponibile'
),

-- HEALTH 4
(
  'EEG Decoding System for Brain-Computer Interface',
  'Health',
  6,
  'Sistema decodifica EEG per interfacce cervello-computer',
  'Le interfacce BCI hanno potenziale enorme per riabilitazione e assistenza. Il sistema BCI decodifica segnali EEG in tempo reale per controllo dispositivi e comunicazione aumentativa.',
  'Interfacce Cervello-Computer (BCI)',
  'Nuove terapie riabilitative; comunicazione per pazienti locked-in; gaming e training cognitivo',
  'SPOKE6',
  1,
  'Disponibile'
),

-- HEALTH 5
(
  'Body Sensor Network (BSN) for Wellness Monitoring',
  'Health',
  6,
  'Rete sensori corporei per monitoraggio benessere con affidabilità clinica',
  'I wearable consumer hanno bassa affidabilità clinica. Il BSN integra sensori ECG, SpO2 e movimento in una rete wireless che trasmette dati al medico in tempo reale.',
  'Monitoraggio Benessere con Wearable',
  'Early detection condizioni croniche; riduzione ospedalizzazioni; dati real-world per studi clinici',
  'SPOKE5 - BIOTECNOMED',
  1,
  'Disponibile'
);

-- =====================================================
-- VERIFICA INSERIMENTO
-- =====================================================
-- SELECT cluster, COUNT(*) as count FROM tecnologie GROUP BY cluster ORDER BY cluster;
-- Risultato atteso:
-- AgriFood: 5
-- Circular: 5
-- Climate: 5
-- Cultural: 5
-- Energy: 5
-- Health: 5
-- TOTALE: 30
