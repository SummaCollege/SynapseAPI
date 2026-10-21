import "@typespec/http";

using Http;

namespace Synapse.Models;

/**
 * Datum filter parameters
 */
model ActiefFilterParameters {
    /**
     * Peildatum, als deze opgegeven wordt worden de situatie zoals nu geregisteerd voor de
     * opgegeven datum getoond waar mogelijk. Niet overal is acurate historische data beschikbaar.
     */
    @query
    peildatum?: string;

    /**
     * Actief vanaf, alleen items actief vanaf de opgegeven datum (inclusief) worden teruggegeven.
     */
    @query
    actiefVanaf?: string;

    /**
     * Actief tot, alleen items actief tot de opgegeven datum (exclusief) worden teruggegeven
     */
    @query
    actiefTot?: string;
}
