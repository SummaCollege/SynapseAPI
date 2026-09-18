import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

@summary("Identifier, aanstelling")
@doc("Voorlopig gebruiken we hier een intern HR UUID, **GEBRUIK DEZE IDENTIFIER NOG NIET!**")
scalar IdentifierAanstelling extends string;

@doc("Categorie van de aanstelling")
enum AanstellingCategorie {
  @doc("Onderwijsgerelateerde aanstelling")
  onderwijs: "onderwijs",

  @doc("Bedrijfsvoering aanstelling")
  bedrijfsvoering: "bedrijfsvoering",
}

@doc("Functiegegevens binnen een aanstelling.")
@example(#{ code: "DOC", naam: "Docent", groep: "Onderwijs" })
model AanstellingFunctie {
  @summary("Code")
  @doc("Functiecode")
  code: string;

  @summary("Naam")
  @doc("Functienaam")
  naam: string;

  @summary("Groep")
  @doc("Functiegroep")
  groep: string;
}

@summary("Basis model, aanstelling")
@doc("Basismodel voor een aanstelling.")
@example(#{ categorie: AanstellingCategorie.onderwijs, identifier: "AAN123" })
model BasisModelAanstelling {
  @doc("Categorie van de aanstelling")
  categorie: AanstellingCategorie;

  @doc("Unieke identifier van de aanstelling")
  identifier: IdentifierAanstelling;
}

@summary("Hoofd model, aanstelling")
@doc("Hoofdmodel voor een aanstelling inclusief functie en organisatie-eenheid.")
@example(#{
  categorie: AanstellingCategorie.onderwijs,
  identifier: "AAN123",
  actief: #{ nu: true },
  functie: #{ code: "DOC", naam: "Docent", groep: "Onderwijs" },
  organisatieeenheid: #{
    type: OrganisatieeenheidType.team,
    identifier: "TEAM1",
  },
})
model HoofdModelAanstelling extends BasisModelAanstelling {
  @doc("Actieve periode van de aanstelling")
  actief: ComponentActief;

  @summary("Functie")
  @doc("Functie behorende bij de aanstelling")
  functie?: AanstellingFunctie;

  @doc("Organisatie-eenheid waaronder de aanstelling valt")
  organisatieeenheid: OrganisatieEenheid;
}

@summary("Volledig model, aanstelling")
@doc("Volledig model voor een aanstelling inclusief gekoppelde medewerker.")
@example(#{
  categorie: AanstellingCategorie.onderwijs,
  identifier: "AAN123",
  actief: #{ nu: true },
  functie: #{ code: "DOC", naam: "Docent", groep: "Onderwijs" },
  organisatieeenheid: #{
    type: OrganisatieeenheidType.team,
    identifier: "TEAM1",
  },
  medewerker: #{ identifier: "123456", roepnaam: "Jan", achternaam: "Jansen" },
})
model VolledigModelAanstelling extends HoofdModelAanstelling {
  @doc("Medewerker die de aanstelling heeft")
  medewerker: Medewerker;
}

@summary("Aanstelling")
@doc("Aanstelling representatie (hoofd- of basismodel).")
@oneOf
union Aanstelling {
  hoofd: HoofdModelAanstelling,
  basis: BasisModelAanstelling,
}

@summary("Aanstelling schema's")
@doc("Alle mogelijke aanstelling modellen.")
@oneOf
union AanstellingModellen {
  volledig: VolledigModelAanstelling,
  hoofd: HoofdModelAanstelling,
  basis: BasisModelAanstelling,
}
