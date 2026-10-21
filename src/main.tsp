import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "./models";
import "./routes";
import "./config.tsp";

using Http;
using OpenAPI;

/**
 * # Summa Synapse
 * Welkom bij de Summa College API documentatie! Deze API biedt toegang tot belangrijke gegevens over studenten, medewerkers en cursussen binnen onze onderwijsinstelling. Of je nu een ontwikkelaar bent die integraties bouwt of een applicatie wilt maken, deze documentatie helpt je op weg.
 *
 * ## Opzet van de API en endpoints
 *
 * - De API hanteert een duidelijke en consistente structuur voor alle endpoints: `/entiteit`, `/entiteit/{id}` en `/entiteit/{id}/subentiteit`.
 * - Wanneer je een entiteit of subentiteit rechtstreeks via het pad opvraagt (zoals `/studenten/{id}` of `/studenten/{id}/inschrijvingen`), ontvang je altijd het meest uitgebreide model van die resource.
 * - Relaties tussen entiteiten (zoals stamgroepen of inschrijvingen bij een student) worden momenteel nog **NIET** als embedded object in responses opgenomen.
 *
 * ## Toekomstige ontwikkelingen
 * - We werken aan het verbeteren van de embedded relaties, zodat je in één keer alle benodigde data kunt ophalen zonder extra requests.
 * - **In de toekomst wordt het mogelijk om per relatie aan te geven of je deze wilt ophalen.**
 *   Zo kun je bijvoorbeeld bij het ophalen van een student straks kiezen om groepen op te halen, maar inschrijvingen helemaal niet.
 * - In de verre toekomst willen we naast onze eigen Synapse API ook vertaling maken naar de OOAPI standaard, zodat je ook OOAPI-conforme endpoints kunt gebruiken.
 * - We blijven de API uitbreiden met nieuwe entiteiten en functionaliteit, dus houd deze documentatie in de gaten voor updates.
 */
@service(#{ title: "Summa Synapse API Platform" })
@info(#{
    contact: #{
        name: "Summa College - Integratie en ontwikkeling",
        email: "devops@summacollege.nl",
        url: "https://synapse.summacollege.nl",
    },
})
@server(EnvironmentServers.Prd, EnvironmentNames.Prd)
@server(EnvironmentServers.Acc, EnvironmentNames.Acc)
@server(EnvironmentServers.Tst, EnvironmentNames.Tst)
@server(EnvironmentServers.Local, EnvironmentNames.Local)
@tagMetadata(#[
    #{
        name: "Personen",
        description: "Deze endpoints bieden toegang tot gegevens van of gerelateerd aan personen.",
    },
    #{
        name: "Medewerkers",
        description: "Deze endpoints bieden toegang tot gegevens van of gerelateerd aan medewerkers.",
    },
    #{
        name: "Studenten",
        description: "Deze endpoints bieden toegang tot gegevens van of gerelateerd aan studenten.",
    },
    #{
        name: "Inschrijvingen",
        description: "Deze endpoints bieden toegang tot gegevens van of gerelateerd aan inschrijvingen.",
    }
])
namespace Synapse;

using Synapse.Config;
using Synapse.Routes;
