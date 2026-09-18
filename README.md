# Summa Synapse API Documentatie

Deze repository bevat het ontwerp van de publieke API's voor het integratieplatform van Stichting ROC Summa College, genaamd Summa Synapse.

De specificaties beschrijven het beoogde contract van deze API's en niet de huidige implementatie. Het API-platform, een onderdeel van Summa Synapse, exposeert informatie over interne entiteiten volgens onze eigen modellen en schema's, zoals vastgelegd in de OpenAPI-specificatie.

Interne ontwikkelaars gebruiken deze OpenAPI-specificatie als doelcontract bij het ontwikkelen van eigen API-translatieservices. Daarmee kunnen externe en SaaS-bronssystemen op een abstracte manier worden ontsloten, zonder dat elke API-consument hoeft te worden aangepast wanneer we overstappen op andere partners of systemen.

> **LET OP:** Deze specificaties representeren de **"gewenste"** (doel) situatie, **niet** the huidige ("as is") implementatie.
> **NOTE:** These specs represent the **"to be"** (target) situation, **not** the current ("as is") implementation.

## Huidige weergave

De huidige versie van de specificatie uit de main-branch is te bekijken via de volgende rendering:

- [Redoc-weergave](https://redocly.github.io/redoc/3.x/?url=https%3A%2F%2Fraw.githubusercontent.com%2FSummaCollege%2FSynapseAPI%2Frefs%2Fheads%2Fmain%2Fopenapi.yaml&nocors)

## Structuur

- `main.tsp` — het hoofdbestand van de TypeSpec-specificatie.
- `src/` — modulaire TypeSpec bronbestanden:
  - `src/gemeenschappelijk/` — gedeelde componenten (adressen, contactgegevens, identifiers, parameters, foutresponsen).
  - `src/modellen/` — domeinmodellen (groepen, cursussen, personen, aanstellingen, organisaties, inschrijvingen).
  - `src/routes.tsp` — alle REST-endpoints en operaties.
- `openapi.yaml` — gegenereerde OpenAPI 3.0-specificatie vanuit TypeSpec.
- `tspconfig.yaml` — TypeSpec compiler- en emitter-configuratie.

## Gebruik

De API-specificatie wordt onderhouden in **TypeSpec** en geëxporteerd naar OpenAPI 3.x.

### Vereisten
- Node.js (v18 of hoger)
- npm

### Installatie
```bash
npm install
```

### Compileren naar OpenAPI
Om `openapi.yaml` te genereren vanuit de TypeSpec-broncode:
```bash
npm run build
```
of direct via:
```bash
npx tsp compile .
```

### Formatteren
Om alle TypeSpec-bestanden te formatteren volgens standaarden:
```bash
npm run format
```

## Bijdragen

1. Breng wijzigingen aan in de relevante `.tsp` bestanden onder `src/` (volg Nederlandse naamgeving en documentatie).
2. Voer `npm run build` uit om de `openapi.yaml` bij te werken.
3. Formatteer de bestanden met `npm run format`.
4. Controleer de wijzigingen met een linter voordat je een pull request opent.
5. Open een pull request en beschrijf de voorgestelde API-wijzigingen.
