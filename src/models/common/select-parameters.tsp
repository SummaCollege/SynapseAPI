import "@typespec/http";
import "@typespec/openapi";

using Http;
using OpenAPI;

namespace Synapse.Models;

model SelectParameters {
    /**
     * Velden, een pipe `|` gescheiden lijst van de velden van het object die teruggegeven moeten worden.
     *
     * **LET OP!**
     * - Indien leeg/niet opgegeven: de standaard set eigenschappen wordt teruggegeven
     * - Als om velden gevraagd word waarop geen rechten verleend zijn worden deze NIET teruggegeven, ook niet leeg.
     */
    @query(#{ explode: false })
    @encode(ArrayEncoding.pipeDelimited)
    velden?: string[];

    /**
     * Uitbreiden, een pipe `|` gescheiden lijst van relaties die opgehaald moeten worden.
     *
     * **LET OP!**
     * - Indien leeg/niet opgegeven: een standaard set aan gerelateerde items kan teruggegeven worden indien
     *   het bronsysteem de gerelateerde gegevens standaard meeleverd en rechten verleend zijn op de betreffende
     *   gerelateerde gegevens.
     *   **Vertrouw hier NIET op en geef altijd zelf op welke relaties teruggegeven moeten worden.**
     * - Vraag alleen om relaties die je daadwerkelijk nodig hebt op het moment van opvragen, verkies het ophalen
     *   van de gerelateerde gegevens via het sub-endpoint over deze optie als de gevraagde gegevens NIET op exact
     *   hetzelfde moment benodigd zijn.
     */
    @query(#{ explode: false })
    @encode(ArrayEncoding.pipeDelimited)
    uitbreiden?: string[];
}
