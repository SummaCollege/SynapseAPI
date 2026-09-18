import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SummaSynapse;

@doc("Lijst van velden om op te halen, gescheiden door komma’s.")
model QueryParameterVelden {
  @query("velden")
  @doc("Lijst van velden om op te halen, gescheiden door komma’s.")
  velden?: string;
}

@doc("Lijst van subresources om uit te breiden, gescheiden door komma’s.")
model QueryParameterUitbreiden {
  @query("uitbreiden")
  @doc("Lijst van subresources om uit te breiden, gescheiden door komma’s.")
  uitbreiden?: string;
}

@doc("Pad parameter voor cursus identifier.")
model PadParameterCursusIdentifier {
  @path
  @pattern("CURS[0-9]{1,8}")
  @doc("Een geldige identifier voor een cursus")
  identifier: string;
}

@doc("Pad parameter voor persoon identifier.")
model PadParameterPersoonIdentifier {
  @path
  @pattern("(?:\\p{L}{4})|(?:AV[0-9]+)|(?:PS[0-9]+)")
  @doc("Een geldige identifier voor een medewerker of student")
  identifier: string;
}

@doc("Pad parameter voor student identifier.")
model PadParameterStudentIdentifier {
  @path
  @pattern("(?:AV[0-9]+)|(?:PS[0-9]+)")
  @doc("Een geldige identifier voor een student")
  identifier: string;
}

@doc("Pad parameter voor medewerker identifier.")
model PadParameterMedewerkerIdentifier {
  @path
  @pattern("[0-9]{6}")
  @doc("Een geldige identifier voor een medewerker (uniek Summa personeelsnummer)")
  identifier: string;
}

@doc("Pad parameter voor organisatie identifier.")
model PadParameterOrganisatieIdentifier {
  @path
  @pattern("\\w+")
  @doc("Een geldige identifier voor een organisatie")
  identifier: string;
}

@doc("Ongeldige aanvraag.")
model BadRequestRespons {
  @statusCode statusCode: 400;
  @body body: Foutrespons;
}

@doc("Niet gevonden.")
model NotFoundRespons {
  @statusCode statusCode: 404;
  @body body: Foutrespons;
}

@doc("Interne serverfout.")
model InternalServerErrorRespons {
  @statusCode statusCode: 500;
  @body body: Foutrespons;
}

@doc("Bad gateway.")
model BadGatewayRespons {
  @statusCode statusCode: 502;
  @body body: Foutrespons;
}
