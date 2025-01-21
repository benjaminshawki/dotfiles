# Stappenplan voor A/B-testplatform

## Fase 1: Onderzoek & Planning

### Notities:
- Dataverzamellaag
- Paginaopbouw
- Recording

- Middleware niveau bucketing, Component Niveau, Blokniveau.

Vragen:
- Hoe ziet een bucketing proces eruit?

Bucketing:
- Land, taal (locale)
- vercel niveau 

Configuratie:
- Profielopbouw
- left-right of % based

- Leg een koppeling met UX'er

1. **Marktonderzoek**
    - Evalueer bestaande en nieuwe A/B-testoplossingen zoals Insider, Growthbook, Posthog, Optimizely en Splitter om hun aanpak en functionaliteiten te begrijpen.
    - https://www.split.io/
    - https://www.builder.io/ (niet te betalen voor PLNTS, gebruik voor onderzoek)
    - Google analytics (Optimize)
    - Next.js dataopslag edge-niveau <- (Vercel)
    - kv postgres
    - https://www.bloomreach.com/en check anlys

2. **SEO & Cookie Beleid**
    - Onderzoek de impact van oude en nieuwe toolings op SEO en het cookiebeleid. ab testing gpr avg

3. **Data Metrics & Recording**
    - Beslis welke data en metrics gemeten moeten worden.
    - Plan een 'dataverzamellaag' om de benodigde data vast te leggen.
    - Om over-analyse te voorkomen test met een specifiek doel 

4. **Technische Vereisten & Paginaopbouw**
    - Bepaal de technische eisen en architectuur, inclusief hoe de pagina's moeten worden opgebouwd voor A/B-testen.

5. **Resource Planning**
    - Schat de benodigde tijd en middelen in.

6. **Scope**
    - Definieer de scope van het project. Bijvoorbeeld, machine learning voor gebruikersgedrag valt buiten de scope.

## Fase 2: Ontwikkeling

### Notities:
- Informatie is verzameld
- Analytics API
- Conclusies uit cijfers

1. **Setup Development Environment**
    - Configureer alle technologieën en middleware zoals Next.js rewrites.

2. **Back-End Implementatie**
    - Ontwikkel de back-end logica mbv in Strapi, en neem de 'dataverzamellaag' op.

3. **Front-End Implementatie**
    - Integreer de A/B-testlogica en paginaopbouw in de front-end met React en Next.js.

4. **Dashboard Ontwikkeling**
    - Verzamel en toon data via analytics API calls.
    - Ontwikkel methoden om conclusies te trekken uit de verzamelde data.

## Fase 3: Testen

### Notities:
- Meetbare acties
- Gebruikersgedrag

1. **Integratietesten**
    - Test de complete flow van dataverzameling tot het trekken van conclusies.

2. **A/B Test**
    - Voer een A/B-test uit, gericht op meetbare acties en gebruikersgedrag.

## Fase 4: Implementatie & Monitoring

1. **Deployment**
    - Implementeer de nieuwe feature in de productieomgeving.

2. **Monitoring**
    - Monitor de prestaties en impact op SEO en conversie.

3. **Iteratie**
    - Voer verbeteringen uit op basis van de verzamelde data en trek conclusies voor toekomstige optimalisaties.

## Extra

### Middleware
- Overweeg het gebruik van Next.js middleware voor rewrites en andere "rewrite rules".

### Marketing
- Bepaal hoe marketingteams de tool kunnen gebruiken in combinatie met Strapi en de front-end.

