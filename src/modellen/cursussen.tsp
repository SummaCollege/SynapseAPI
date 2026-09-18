import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

@pattern("CURS[0-9]{1,8}")
@summary("Identifier, cursus")
@doc("Unieke cursuscode, bijvoorbeeld CURS123.")
scalar IdentifierCursus extends string;

@doc("Status van de cursus")
enum CursusStatus {
  @doc("In ontwerp")
  Ontwerp: "Ontwerp",

  @doc("Gepubliceerd en beschikbaar")
  Gepubliceerd: "Gepubliceerd",

  @doc("Beëindigd")
  Beeindigd: "Beeindigd",
}

@summary("Basis model, cursus")
@doc("Basismodel voor een cursus.")
@example(#{ identifier: "CURS123" })
model BasisModelCursus {
  @doc("Unieke identifier van de cursus")
  identifier: IdentifierCursus;
}

@summary("Hoofd model, cursus")
@doc("Hoofdmodel voor een cursus met naam en flexibiliteit.")
@example(#{
  identifier: "CURS123",
  naam: "Nederlands B1",
  flexibel: false,
  status: CursusStatus.Gepubliceerd,
})
model HoofdModelCursus extends BasisModelCursus {
  @doc("Naam van de cursus")
  naam: string;

  @doc("Geeft aan of de cursus flexibel te volgen is")
  flexibel: boolean;

  @doc("Status van de cursus")
  status?: CursusStatus;
}

@summary("Volledig model, cursus")
@doc("Volledig model voor een cursus inclusief ontwikkelaars en leeractiviteiten.")
@example(#{
  identifier: "CURS123",
  naam: "Nederlands B1",
  flexibel: false,
  status: CursusStatus.Gepubliceerd,
  ontwikkelaars: #[
    #{ identifier: "123456", roepnaam: "Jan", achternaam: "Jansen" }
  ],
  leeractiviteiten: #[],
})
model VolledigModelCursus extends HoofdModelCursus {
  @doc("Medewerkers die de cursus hebben ontwikkeld")
  ontwikkelaars: Medewerker[];

  @doc("Leeractiviteiten binnen deze cursus")
  leeractiviteiten: Record<unknown>[];
}

@summary("Cursus")
@doc("Cursus representatie (hoofd- of basismodel).")
@oneOf
union Cursus {
  hoofd: HoofdModelCursus,
  basis: BasisModelCursus,
}

@summary("Cursus schema's")
@doc("Alle mogelijke cursus modellen.")
@oneOf
union CursusModellen {
  volledig: VolledigModelCursus,
  hoofd: HoofdModelCursus,
  basis: BasisModelCursus,
}
