import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "./src/gemeenschappelijk/componenten.tsp";
import "./src/gemeenschappelijk/parameters.tsp";
import "./src/modellen/inschrijvingen.tsp";
import "./src/modellen/groepen.tsp";
import "./src/modellen/cursussen.tsp";
import "./src/modellen/personen.tsp";
import "./src/modellen/aanstellingen.tsp";
import "./src/modellen/organisaties.tsp";
import "./src/routes.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@service(#{ title: "Summa API Platform (Synapse) - Draft" })
@info(#{
  version: "0.2.0",
  contact: #{
    url: "https://www.summacollege.nl",
    name: "Summa College - Integratie en ontwikkeling",
    email: "devops@summacollege.nl",
  },
})
@doc("""
  # Summa Synapse
  Welkom bij de Summa College API documentatie! Deze API biedt toegang tot belangrijke gegevens over studenten, medewerkers en cursussen binnen onze onderwijsinstelling. Of je nu een ontwikkelaar bent die integraties bouwt of een applicatie wilt maken, deze documentatie helpt je op weg.
  
  ## Opzet van de API en endpoints
  
  - De API hanteert een duidelijke en consistente structuur voor alle endpoints: `/entiteit`, `/entiteit/{id}` en `/entiteit/{id}/subentiteit`.
  - Wanneer je een entiteit of subentiteit rechtstreeks via het pad opvraagt (zoals `/studenten/{id}` of `/studenten/{id}/inschrijvingen`), ontvang je altijd het meest uitgebreide (volledige) model van die resource.
  - Relaties tussen entiteiten (zoals stamgroepen of inschrijvingen bij een student) worden momenteel nog **NIET** als embedded object in responses opgenomen.
  - Hoewel de schema’s verschillende modeltypes (basis, hoofd, volledig) tonen, wordt er op dit moment per endpoint of relatie altijd één type response teruggegeven: volledig model zonder gerelateerde data (tenzij anders aangegeven).
  
  ## Toekomstige ontwikkelingen
  - We werken aan het verbeteren van de embedded relaties, zodat je in één keer alle benodigde data kunt ophalen zonder extra requests.
  - ** In de toekomst wordt het mogelijk om per relatie aan te geven of je deze wilt ophalen en in welke variant (basis- of hoofdmodel). **
    Zo kun je bijvoorbeeld bij het ophalen van een student straks kiezen om stamgroepen als hoofdmodel op te halen, maar inschrijvingen helemaal niet.
  - In de verre toekomst willen we naast onze eigen Synapse API ook vertaling maken naar de OOAPI standaard, zodat je ook OOAPI-conforme endpoints kunt gebruiken.
  - We blijven de API uitbreiden met nieuwe entiteiten en functionaliteit, dus houd deze documentatie in de gaten voor updates.
  """)
@server("https://api.summacollege.nl", "Productie")
@server("https://api-acc.summacollege.nl", "Acceptatie")
@server("https://api-dev.summacollege.nl", "Dev/Test (alleen intern)")
@tagMetadata(#[
  #{
    name: "Personen",
    description: """
      **Persoonsinformatie**
      
      Informatie over studenten en medewerkers, zoals naam, geboortedatum en contactgegevens. Gebruik deze endpoints om basisgegevens van personen op te halen.
      """,
  },
  #{
    name: "Gebruikers",
    description: """
      **Gebruikersgegevens (SSO)**
      
      Informatie over gebruikersaccounts afkomstig uit het Identity Provider (IDP) systeem. Handig voor Single Sign-On (SSO) en authenticatie.
      """,
  },
  #{
    name: "Contactgegevens",
    description: """
      **Contactgegevens**
      
      Telefoonnummer(s) en e-mailadressen van personen, studenten en medewerkers. Gebruik deze endpoints om actuele contactinformatie op te vragen.
      """,
  },
  #{
    name: "Studenten",
    description: """
      **Studentgegevens**
      
      Gegevens van en gerelateerd aan studenten, zoals inschrijvingen, stamgroepen en contactinformatie. Zie ook de voorbeelden bij de endpoints.
      """,
  },
  #{
    name: "Inschrijvingen",
    description: """
      **Inschrijvingen**
      
      Informatie over inschrijvingen van studenten op opleidingen, arrangementen en cursussen. Handig voor het volgen van studievoortgang.
      """,
  },
  #{
    name: "Medewerkers",
    description: """
      **Medewerkersgegevens**
      
      Gegevens van en gerelateerd aan medewerkers, inclusief aanstellingen en contactinformatie.
      """,
  },
  #{
    name: "Stamgroepen",
    description: """
      **Stamgroepen**
      
      Stamgroepen koppelen studenten aan studiecoaches (studieloopbaanbegeleiders). Gebruik deze endpoints om groepsindelingen en begeleiders op te halen.
      """,
  },
  #{
    name: "Aanstellingen",
    description: """
      **Aanstellingen**
      
      Informatie over aanstellingen van medewerkers bij verschillende organisatie-eenheden. Zie de voorbeelden voor structuur.
      """,
  },
  #{
    name: "Cursussen",
    description: """
      **Cursusgegevens**
      
      Gegevens over aangeboden cursussen, zoals naam, code en status. Gebruik deze endpoints om cursusinformatie op te halen.
      """,
  },
  #{
    name: "Groepen",
    description: """
      **Groepen**
      
      Groepen koppelen studenten o.a. aan studiecoaches (studieloopbaanbegeleiders). Gebruik deze endpoints om groepsindelingen en begeleiders op te halen.
      """,
  },
  #{
    name: "Studentbegeleiders",
    description: """
      **Studentbegeleiders**
      
      Gebruik deze endpoints om de begeleiders van een student op te halen.
      """,
  },
  #{
    name: "Adressen",
    description: """
      **Addressen**
      
      Adressen van personen, studenten en medewerkers. Gebruik deze endpoints om actuele adresgegevens op te vragen.
      """,
  },
  #{
    name: "Organisaties",
    description: """
      **Organisaties**
      
      Gegevens van en gerelateerd aan organisaties, zoals inschrijvingen en contactinformatie. Zie ook de voorbeelden bij de endpoints.
      """,
  },
  #{
    name: "Componenten",
    description: """
      **Componenten**
      
      Dit zijn kleine herbruikbare componenten die in verschillende schema's terug komen.
      """,
  }
])
namespace SummaSynapse;
