# Analisi Plugin: html.to.design by divRiots

## Overview

**Plugin**: html.to.design
**Sviluppatore**: ‹div›RIOTS
**Piattaforma**: Figma (plugin) + Chrome (estensione)
**Utenti**: +1 milione
**Pricing**: 12 import gratuiti/mese, piani PRO disponibili

---

## Come Funziona

### Metodi di Import

| Metodo | Descrizione | Uso consigliato |
|--------|-------------|-----------------|
| **URL Import** | Incolla URL → Click "Import" | Siti pubblici |
| **Chrome Extension** | Cattura pagina dal browser → Genera file .h2d → Drag&drop nel plugin | Pagine private, login required |
| **HTML Tab** | Incolla codice HTML/CSS direttamente | Landing page custom, snippet AI |

### Flusso di lavoro tipico

```
1. Inserisci URL o incolla codice HTML/CSS
2. Seleziona viewport (desktop/tablet/mobile)
3. Seleziona tema (light/dark se disponibile)
4. Click "Import"
5. Modifica il design in Figma
```

---

## Cosa Viene Convertito

### Elementi importati

| Elemento | Conversione | Note |
|----------|-------------|------|
| **Testo** | Layer di testo editabili | Font preservati |
| **Colori** | Stili locali Figma | Automatico con opzione "Create styles" |
| **Immagini** | Layer immagine | Estraibili singolarmente |
| **Bottoni** | Layer editabili | Stili hover come componenti |
| **Form** | Elementi editabili | Struttura preservata |
| **Layout** | Struttura gerarchica | Auto-layout opzionale |
| **Spaziature** | Preservate | Padding/margin mantenuti |

### Opzioni di import

- **Auto Layout**: Applica automaticamente auto-layout ai frame
- **Create Styles**: Genera stili locali per colori e font
- **Create Variables**: Crea variabili Figma
- **Hover States**: Converte stati hover in componenti Figma

---

## Best Practices per HTML Ottimizzato

### Struttura HTML

```html
<!-- USA tag semantici -->
<header>...</header>
<nav>...</nav>
<main>
  <section>...</section>
  <section>...</section>
</main>
<footer>...</footer>

<!-- EVITA div generici eccessivi -->
<!-- NO: <div><div><div>content</div></div></div> -->
```

### Convenzioni di naming

```html
<!-- Usa classi descrittive che corrispondono ai layer Figma -->
<div class="hero-section">
  <h1 class="hero-title">Titolo</h1>
  <p class="hero-subtitle">Sottotitolo</p>
  <button class="cta-primary">Call to Action</button>
</div>
```

### CSS consigliato

```css
/* Usa unità standard e valori espliciti */
.hero-section {
  padding: 80px 40px;
  background-color: #0053CE;
  color: #FFFFFF;
}

/* Definisci font esplicitamente */
.hero-title {
  font-family: 'Poppins', sans-serif;
  font-size: 48px;
  font-weight: 700;
  line-height: 1.2;
}

/* Usa flexbox per layout (convertito meglio in auto-layout) */
.container {
  display: flex;
  flex-direction: column;
  gap: 24px;
  align-items: center;
}
```

### Immagini

```html
<!-- Sempre includere alt text -->
<img src="image.jpg" alt="Descrizione immagine" />

<!-- Specificare dimensioni quando possibile -->
<img src="logo.png" width="200" height="80" alt="Logo Tech4You" />
```

---

## Limitazioni Note

| Limitazione | Workaround |
|-------------|------------|
| **Accuratezza ~80-90%** | Ritocchi manuali post-import |
| **Auto-layout in beta** | Verificare struttura dopo import |
| **Animazioni non importate** | Ricreare in Figma se necessario |
| **JavaScript non eseguito** | Usare Chrome extension per contenuti dinamici |
| **Protezione anti-bot** | Usare Chrome extension per bypassare |
| **Font non standard** | Verificare disponibilità font in Figma |

---

## Configurazione Ottimale per il Progetto Tech4You

### Viewport consigliati

| Device | Larghezza | Uso |
|--------|-----------|-----|
| Desktop | 1440px | Landing page principale |
| Tablet | 768px | Versione responsive |
| Mobile | 375px | Mobile-first design |

### Impostazioni import consigliate

- [x] Apply Auto Layout
- [x] Create Styles (per colori e font Tech4You)
- [x] Create Variables
- [x] Convert hover states as components

---

## Workflow per Landing Page Tech4You

### Step 1: Preparazione HTML

```
1. Creare HTML semantico con classi descrittive
2. Usare palette colori Tech4You (vedi brand-identity)
3. Includere font Poppins e Lora via Google Fonts
4. Strutturare con flexbox per auto-layout ottimale
```

### Step 2: Import in Figma

```
1. Aprire plugin html.to.design in Figma
2. Selezionare tab "HTML"
3. Incollare codice HTML + CSS
4. Configurare opzioni import
5. Click "Import"
```

### Step 3: Post-processing

```
1. Verificare stili locali creati
2. Controllare auto-layout su tutti i frame
3. Sostituire placeholder con immagini finali
4. Creare componenti per elementi riutilizzabili
5. Organizzare layer con naming consistente
```

---

## Template HTML Base per Landing Tech4You

```html
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&family=Lora:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      color: #212529;
      background: #FFFFFF;
    }

    /* Colori Tech4You */
    :root {
      --primary: #0053CE;
      --spoke-1: #8FC68E;
      --spoke-2: #6ABEA4;
      --spoke-3: #3FABB2;
      --spoke-4: #0098BB;
      --spoke-5: #0C919C;
      --spoke-6: #07667A;
      --accent: #FBE91B;
      --dark: #212529;
      --light: #F7F7F7;
    }
  </style>
</head>
<body>
  <!-- Contenuto landing page -->
</body>
</html>
```

---

## Risorse e Link Utili

- [Plugin Figma](https://www.figma.com/community/plugin/1159123024924461424)
- [Chrome Extension](https://chromewebstore.google.com/detail/htmltodesign/ldnheaepmnmbjjjahokphckbpgciiaed)
- [Documentazione ufficiale](https://html.to.design/docs/what-is-html-to-design/)
- [Blog divRiots](https://divriots.com/blog/introducing-html-to-design/)
- [Guida import codice](https://html.to.design/blog/new-feature-import-code-in-figma)
- [Da web a Figma](https://html.to.design/blog/from-web-to-figma/)

---

## Note per il Team

### Pro del workflow HTML → Figma

1. **Velocità**: Creazione rapida di layout complessi
2. **Consistenza**: Stili automaticamente allineati
3. **Iterazione**: Facile testare varianti
4. **Collaborazione**: Designer e developer allineati
5. **AI-ready**: Compatibile con output da ChatGPT, Bolt, Lovable

### Attenzione a

1. Verificare sempre accuratezza post-import
2. Font devono essere disponibili in Figma
3. Hover states richiedono configurazione
4. Immagini placeholder da sostituire
5. Auto-layout potrebbe richiedere aggiustamenti

---

*Documento creato: Gennaio 2026*
*Per progetto: Tech4You - Landing Pages & Creatività*
