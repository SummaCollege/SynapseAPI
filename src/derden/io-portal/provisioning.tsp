import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

using Http;
using OpenAPI;

@service(#{ title: "Summa Synapse API Platform" })
@info(#{
    contact: #{
        name: "Summa College - Integratie en ontwikkeling",
        email: "devops@summacollege.nl",
        url: "https://synapse.summacollege.nl",
    },
    version: "0.0.1",
    license: #{ name: "MIT License", identifier: "MIT" },
})
@server("Local Summa Mock", "summa-portal.local")
namespace Synapse.Derden.IoPortal.Provisioning;

/**
 * (Voor Summa) extern systeem
 */
enum ExternSysteem {
    activeDirectory,
    afas,
    canvas,
    eduarte,
    educator,
}

/**
 * (Unieke) identifier voor een gebruiker in een bepaald systeem
 */
model Identifier {
    /**
     * Het systeem waar de identifier in gebruikt word
     */
    systeem: ExternSysteem;

    /**
     * De naam van de identifier in het geval dat er voor een
     * systeem sprake is van meer dan één identifier
     */
    naam: string;

    /**
     * De waarde van de identifier (altijd als string)
     */
    waarde: string;
}

/**
 * De verschillende typen contactgegevens
 */
enum ContactgegevenType {
    /**
     * Mobiel telefoonnummer
     */
    mobiel,

    /**
     * E-mail adres
     */
    email,
}

/**
 * Contactgegeven
 *
 * **LET OP:**
 * Er is nu voor gekozen alleen organisatie gegevens te delen,
 * in de toekomst kunnen we dit uitbreiden en dan zal er een
 * `gebruik` eigenschap bijkomen om onderscheid tussen intern/extern
 * te gebruiken gegevens bijv. duidelijk te maken.
 */
model ContactgegevenComponent {
    /**
     * Type contactgegeven
     */
    type: ContactgegevenType;

    /**
     * De waarde van het contactgegeven, bijv. een telefoonnummer
     * Altijd als string en **NIET** onderworpen aan formattering
     * of validatie buiten wat het bronsysteem zelf bied.
     */
    waarde: string;
}

/**
 * Medewerker functie
 */
model Functie {
    /**
     * Functie omschrijving
     */
    omschrijving: string;

    /**
     * Naam team
     */
    team: string;

    /**
     * Naam propositie/dienst
     */
    propositie: string;
}

/**
 * Type gebruiker
 */
enum GebruikerType {
    /**
     * Medewerker
     */
    medewerker,

    /**
     * Student
     */
    student,
}

/**
 * Gebruiker model
 */
model Gebruiker {
    /**
     * Basis type/rol van de gebruiker
     */
    type: GebruikerType;

    /**
     * Hoofd Summa Identifier voor de gebruiker
     */
    identifier: string;

    /**
     * # Identifiers
     *
     * ## Active Directory / Entra ID / Office 365
     * - cn (PS123456/ABCD)
     * - upn (PS123456@summacollege.nl/ABCD@summacollege.nl)
     *
     * ## AFAS
     * - Medewerkernummer (SN######)
     *
     * ## Canvas
     * - SIS_USER_ID
     *
     */
    overigeIdentifiers: Identifier[];

    /**
     * Roepnaam
     */
    roepnaam: string;

    /**
     * Tussenvoegsel
     */
    tussenvoegsel: string;

    /**
     * Achternaam
     */
    achternaam: string;

    /**
     * Email adres,
     * alleen te gebruiken voor het geautomatiseerde mailen van de gebruiker,
     * als een persoon voor meerdere Summa geleerde organisaties werkt kan deze
     * meerdere email adressen hebben, de te tonen email adressen worden voor het
     * smoellenboek als `Contactgegevens` gedeeld.
     */
    contactEmailadres: string;
}

/**
 * Smoelenboek gebruiker (momenteel alleen medewerkers)
 */
model SmoelenboekGebruiker extends Gebruiker {
    contactgegevens: ContactgegevenComponent[];
    functies?: Functie[];
}

@route("/gebruikers")
interface UserProvisioning {
    @put
    provision(@body gebruiker: Gebruiker | SmoelenboekGebruiker):
        | OkResponse
        | CreatedResponse;
}

// Alleen inbegrepen als voorbeeld, niet daadwerkelijk de bedoeling om hier iets mee te doen

/**
 * Enumeratie met de mogelijk dagen voor werktijd
 */
#deprecated "Alleen toegevoegd om een voorbeeld "
enum Werkdag {
    Maandag,
    Dinsdag,
    Woensdag,
    Donderdag,
    Vrijdag,
    Zaterdag,
    Zondag,
}

/**
 * Standaard werktijd van een medewerker voor een bepaalde dag
 */
#deprecated "Voor nu gaan we er vanuit dat dit ingvuld zal worden in de portal. Dit dient alleen als voorbeeld!"
model Werktijd {
    dagVanDeWeek: Werkdag;
    startTijd: plainTime;
    eindTijd: plainTime;
}

/**
 * Standaard werklocatie van een medewerker,
 * omdat dit om een voorbeeld gaat bijv. niet gekoppeld aan werkdag.
 */
#deprecated "Voor nu gaan we er vanuit dat dit ingvuld zal worden in de portal. Dit dient alleen als voorbeeld!"
model Werklocatie {
    naam: string;
    adress: unknown;
}
