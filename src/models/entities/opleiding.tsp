import "@typespec/openapi3";
import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Type inschrijving
 */
enum OpleidingLeerweg {
    /**
     * BOL (Voltijd, bekostigd)
     */
    bol,

    /**
     * OVO (Voltijd, niet bekostigd)
     */
    ovo,

    /**
     * BBL (Deeltijd, bekostigd)
     */
    bbl,

    /**
     * ODT (Deeltijd, niet bekostigd)
     */
    odt,
}

/**
 * Opleiding, een opleiding is een samengesteld onderwijsaanbod met een vaste afronding.
 */
@extension("x-tags", #["Opleidingen"])
@summary("Opleiding")
model Opleiding extends IdentifiableEntity {
    ...IsBeperktActief;

    /**
     * Code
     */
    code: string;

    /**
     * Naam
     */
    naam: string;

    /**
     * Crebocode opleiding
     */
    crebo?: string;

    /**
     * Leerweg (afwezig indien anders dan BOL/BBL of OVO/ODT)
     */
    leerweg?: OpleidingLeerweg;
}

/**
 * Opleiding aanbod, is de koppeling tussen een opleiding
 */
@extension("x-tags", #["Opleidingen"])
@summary("OpleidingAanbod")
model OpleidingAanbod extends Opleiding {
    ...IsGekoppeldAanOrganisatieEenheid;
}
