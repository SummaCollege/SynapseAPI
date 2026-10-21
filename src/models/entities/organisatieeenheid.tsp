import "@typespec/openapi3";
import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Orgasatieeenheid type
 */
enum OrganisatieEenheidType {
    instelling,
    propositie,
    team,
}

/**
 * Opleiding, een opleiding is een samengesteld onderwijsaanbod met een vaste afronding.
 */
@extension("x-tags", #["OrganisatieEenheden"])
@summary("OrganisatieEenheid")
model OrganisatieEenheid extends IdentifiableEntity {
    ...IsBeperktActief;

    /**
     * Moedereenheid
     */
    moederEenheid?: OrganisatieEenheid;

    /**
     * Leidinggevenden van het team
     */
    leidinggevenden?: ResourceRef[] | Medewerker[];
}

model IsGekoppeldAanOrganisatieEenheid {
    /**
     * De codes van de organisatie eenheden waarbinnen deze entiteit direct/indirect valt.
     */
    organisatieEenheidCodes?: OrganisatieEenheidCodesComponent;

    /**
     * Organisatie eenheid waarbinnen deze entiteit direct gekoppeld is
     */
    @extension("x-badges", #[#{ name: "DRAFT", color: "red" }])
    organisatieEenheid?: ResourceRef | OrganisatieEenheid;
}

model IsGekoppeldAanOrganisatieEenheden {
    /**
     * De codes van de organisatie eenheden waarbinnen deze entiteit direct/indirect valt.
     */
    organisatieEenhedenCodes?: OrganisatieEenheidCodesComponent[];

    /**
     * Organisatie eenheid waarbinnen deze entiteit direct gekoppeld is
     */
    @extension("x-badges", #[#{ name: "DRAFT", color: "red" }])
    organisatieEenheden?: ResourceRef[] | OrganisatieEenheid[];
}
