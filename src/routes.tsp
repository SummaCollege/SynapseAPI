import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SummaSynapse;

// ==========================================
// Groepen
// ==========================================

@tag("Groepen")
@route("/groepen")
@summary("/groepen")
@doc("Alle (actieve) groepen ophalen")
@operationId("GetGroepen")
@get
op getGroepen(...QueryParameterVelden, ...QueryParameterUitbreiden):
  | Groep[]
  | BadRequestRespons
  | NotFoundRespons
  | InternalServerErrorRespons
  | BadGatewayRespons;

@tag("Groepen")
@route("/groepen/{identifier}")
@summary("/groepen/{identifier}")
@doc("Een enkele groep ophalen")
@operationId("GetGroep")
@get
op getGroep(
  @doc("Unieke identifier van de groep.")
  @path
  identifier: string,
): VolledigModelGroep;

// ==========================================
// Cursussen
// ==========================================

@tag("Cursussen")
@route("/cursussen")
@summary("/cursussen")
@doc("De beschikbare cursussen ophalen")
@operationId("GetCursussen")
@get
op getCursussen(...QueryParameterVelden, ...QueryParameterUitbreiden):
  | BasisModelCursus
  | BadRequestRespons
  | NotFoundRespons
  | InternalServerErrorRespons
  | BadGatewayRespons;

@tag("Cursussen")
@route("/cursussen/{identifier}")
@summary("/cursussen/{identifier}")
@doc("De opgegeven cursus ophalen")
@operationId("GetCursus")
@get
op getCursus(...PadParameterCursusIdentifier): VolledigModelCursus;

// ==========================================
// Studenten
// ==========================================

@tag("Studenten")
@route("/studenten")
@summary("/studenten")
@doc("Alle studenten ophalen")
@operationId("GetStudenten")
@get
op getStudenten(): Student[];

@tag("Studenten")
@route("/studenten/{identifier}")
@summary("/studenten/{identifier}")
@doc("Een specifieke student ophalen")
@operationId("GetStudent")
@get
op getStudent(...PadParameterStudentIdentifier): VolledigModelStudent;

@tag("Studenten")
@tag("Adressen")
@route("/studenten/{identifier}/adressen")
@summary("/studenten/{identifier}/adressen")
@doc("De adressen van een specifieke student opvragen")
@operationId("GetStudentAdressen")
@get
op getStudentAdressen(...PadParameterStudentIdentifier): ComponentAdres;

@tag("Studenten")
@tag("Gebruikers")
@route("/studenten/{identifier}/gebruiker")
@summary("/studenten/{identifier}/gebruiker")
@doc("De gebruiker voor een specifieke student ophalen")
@operationId("GetStudentGebruiker")
@get
op getStudentGebruiker(
  ...PadParameterStudentIdentifier,
): VolledigModelGebruiker;

@tag("Studenten")
@tag("Studentbegeleiders")
@route("/studenten/{identifier}/begeleiders")
@summary("/studenten/{identifier}/begeleiders")
@doc("Alle begeleiders ophalen van de opgegeven student")
@operationId("getBegeleiders")
@get
op getStudentBegeleiders(
  @doc("Unieke identifier van de student.")
  @path
  identifier: string,
): Begeleider[];

@tag("Inschrijvingen")
@route("/studenten/{identifier}/inschrijvingen")
@summary("/studenten/{identifier}/inschrijvingen")
@doc("De inschrijvingen van een specifieke student opvragen")
@operationId("GetStudentInschrijvingen")
@get
op getStudentInschrijvingen(
  ...PadParameterStudentIdentifier,
): HoofdModelInschrijving;

@tag("Contactgegevens")
@tag("Studenten")
@route("/studenten/{identifier}/contactgegevens")
@summary("/studenten/{identifier}/contactgegevens")
@doc("De contactgegevens van een specifieke student opvragen")
@operationId("GetStudentContactGegevens")
@get
op getStudentContactGegevens(
  ...PadParameterStudentIdentifier,
): ComponentContactgegeven;

// ==========================================
// Medewerkers
// ==========================================

@tag("Medewerkers")
@route("/medewerkers")
@summary("/medewerkers")
@doc("Alle medewerkers ophalen")
@operationId("GetMedewerkers")
@get
op getMedewerkers(): Medewerker[];

@tag("Medewerkers")
@route("/medewerkers/{identifier}")
@summary("/medewerkers/{identifier}")
@doc("Een specifieke medewerker ophalen")
@operationId("GetMedewerker")
@get
op getMedewerker(...PadParameterMedewerkerIdentifier): VolledigModelMedewerker;

@tag("Medewerkers")
@tag("Adressen")
@route("/medewerkers/{identifier}/adressen")
@summary("/medewerkers/{identifier}/adressen")
@doc("De adressen van een specifieke medewerker opvragen")
@operationId("getAdressen")
@get
op getMedewerkerAdressen(...PadParameterMedewerkerIdentifier): ComponentAdres;

@tag("Gebruikers")
@tag("Medewerkers")
@route("/medewerkers/{identifier}/gebruiker")
@summary("/medewerkers/{identifier}/gebruiker")
@doc("De gebruiker voor een specifieke medewerker ophalen")
@operationId("GetMedewerkerGebruiker")
@get
op getMedewerkerGebruiker(
  ...PadParameterMedewerkerIdentifier,
): VolledigModelGebruiker;

@tag("Medewerkers")
@tag("Aanstellingen")
@route("/medewerkers/{identifier}/aanstellingen")
@summary("/medewerkers/{identifier}/aanstellingen")
@doc("De aanstellingen van een specifieke medewerker opvragen")
@operationId("GetMedewerkerAanstellingen")
@get
op getMedewerkerAanstellingen(
  ...PadParameterMedewerkerIdentifier,
): VolledigModelAanstelling;

@tag("Contactgegevens")
@tag("Medewerkers")
@route("/medewerkers/{identifier}/contactgegevens")
@summary("/medewerkers/{identifier}/contactgegevens")
@doc("De contactgegevens van een specifieke medewerker opvragen")
@operationId("GetMedewerkerContactGegevens")
@get
op getMedewerkerContactGegevens(
  ...PadParameterMedewerkerIdentifier,
): ComponentContactgegeven;

// ==========================================
// Organisaties
// ==========================================

@tag("Organisaties")
@route("/organisaties")
@summary("/organisaties")
@doc("Alle organisaties ophalen")
@operationId("GetOrganisaties")
@get
op getOrganisaties(): Organisatie[];

@tag("Organisaties")
@route("/organisaties/{identifier}")
@summary("/organisaties/{identifier}")
@doc("Een specifieke organisatie ophalen")
@operationId("GetOrganisatie")
@get
op getOrganisatie(
  ...PadParameterOrganisatieIdentifier,
): VolledigModelOrganisatie;

// ==========================================
// Stamgroepen (verouderd / deprecated)
// ==========================================

#deprecated "Stamgroepen zijn verouderd. Gebruik /groepen in plaats hiervan."
#suppress "deprecated" "Verouderde operatie behouden voor backwards compatibility."
@tag("Stamgroepen")
@route("/stamgroepen")
@summary("/stamgroepen")
@doc("Alle stamgroepen ophalen")
@operationId("GetStamgroepen")
@get
op getStamgroepen(): Stamgroep[];

#deprecated "Stamgroepen zijn verouderd. Gebruik /groepen/{identifier} in plaats hiervan."
#suppress "deprecated" "Verouderde operatie behouden voor backwards compatibility."
@tag("Stamgroepen")
@route("/stamgroepen/{identifier}")
@summary("/stamgroepen/{identifier}")
@doc("Een enkele stamgroep ophalen")
@operationId("GetStamgroep")
@get
op getStamgroep(
  @doc("Unieke identifier van de stamgroep.")
  @path
  identifier: string,
): VolledigModelStamgroep;
