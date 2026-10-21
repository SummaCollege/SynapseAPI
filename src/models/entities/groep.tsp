import "@typespec/openapi3";
import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Type groep
 */
enum GroepType {
    stamgroep,
    lesgroep,
    klas,
    sectie,
    examenklas,
    overig,
}

/**
 * Groep studenten met begeleiders
 */
@extension("x-tags", #["Groepen"])
@summary("Groep")
model Groep extends IdentifiableEntity {
    ...IsBeperktActief;
    ...IsGekoppeldAanOrganisatieEenheid;
    ...HeeftReferenties;

    /**
     * Naam groep
     */
    naam: string;

    /**
     * Type groep
     */
    type: GroepType;

    /**
     * Studenten in de groep
     */
    @oneOf
    studenten?: ResourceRef[] | Student[];

    /**W
     * Begeleiders van de groep
     */
    @oneOf
    begeleiders?: ResourceRef[] | Medewerker[];
}
