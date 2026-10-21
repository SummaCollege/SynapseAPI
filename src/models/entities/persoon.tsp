import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Geslacht
 */
enum PersoonGeslacht {
    /**
     * Man
     */
    man,

    /**
     * Vrouw
     */
    vrouw,

    /**
     * Onbekend/overig
     * **LET OP:**
     * Vanwege beperkingen en verschillen in bronsystemen is dit voorlopig de
     * fallback indien een bronsysteem een andere waarde dan `man` of `vrouw` bevat.
     */
    onbekend,
}

/**
 * Persoon, alle persoonsgegevens van een persoon
 */
@extension("x-tags", #["Personen"])
@summary("Persoon")
model Persoon extends IdentifiableEntity {
    /**
     * Geslacht
     */
    geslacht: PersoonGeslacht;

    /**
     * Roepnaam
     */
    roepnaam: string;

    /**
     * Voornamen
     */
    voornamen: string[];

    /**
     * Achternaam
     */
    achternaam: string;

    /**
     * Voorletters
     */
    @pattern("^\\p{Lu}+$", "Alleen (latijn) hoofdletters toegestaan")
    voorletters?: string;

    /**
     * Geboortedatum
     */
    geboortedatum: plainDate;

    /**
     * Tussenvoegsel
     */
    tussenvoegsel?: string;

    /**
     * Meisjesnaamtussenvoegsel
     */
    meisjesnaamtussenvoegsel?: string;

    /**
     * (IdP) Gebruiker gekoppeld aan deze persoon
     */
    gebruiker?: Gebruiker;

    /**
     * Contactgegeven, bijv. telefoonnummer, email etc.
     */
    contactgegevens?: ContactgegevenComponent[];

    /**
     * Adressen gekoppeld aan de persoon
     */
    addressen?: AdresComponent[];
}
