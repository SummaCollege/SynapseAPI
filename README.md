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

- `openapi.yaml` — de OpenAPI-specificatie voor de publieke API's.

## Gebruik

De specificatie is geschreven in OpenAPI 3.x (YAML) en kan worden bekeken of bewerkt met tools zoals:

- Swagger Editor
- Stoplight Studio
- VS Code met een OpenAPI/YAML-plugin

## Bijdragen

1. Werk de OpenAPI-specificatie bij of voeg nieuwe endpoints en modellen toe.
2. Controleer de wijzigingen met een linter zoals Spectral voordat je een pull request opent.
3. Open een pull request en beschrijf de voorgestelde API-wijzigingen.
