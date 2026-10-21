import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Gebruikersaccount voor één persoon, bevat de IdP identifier, weergavenaam en actieve periode van de gebruiker
 */
@extension("x-tags", #["Gebruikers"])
@summary("Gebruiker")
model Gebruiker extends IdentifiableEntity {
    ...IsBeperktActief;

    /**
     * Weergavenaam van de gebruiker
     *
     * **LET OP!:**
     * Het heeft onze sterke voorkeur deze naam te gebruiken overal waar de volledige
     * naam van de gebruiker getoond moet worden. Dit om de gebruiker een consistente
     * ervaring binnen verschillende applicaties te bieden.
     */
    weergaveNaam?: string;
}
