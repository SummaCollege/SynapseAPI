import "@typespec/openapi3";
import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Medewerker, iemand die bij onze organisatie werkzaamheden uitvoert
 */
@extension("x-tags", #["Medewerkers"])
@summary("Medewerker")
model Medewerker is Persoon {
    ...IsGekoppeldAanOrganisatieEenheden;
    ...IsBeperktActief;
    ...HeeftIdentifiers;

    /**
     * Groepen die de medewerker begeleidt
     */
    groepen?: Groep[];

    /**
     * Aanstellingen
     */
    aanstellingen?: AanstellingComponent[];
}
