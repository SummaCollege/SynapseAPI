import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

// ==========================================
// Organisatie modellen
// ==========================================

@pattern("[A-Za-z0-9_-]+")
@summary("Identifier, organisatie")
@doc("Unieke identifier voor een organisatie.")
scalar IdentifierOrganisatie extends string;

@doc("Type relatie met de organisatie")
enum OrganisatieRelatieType {
  @doc("Beroepspraktijkvorming (stage / leerwerkplek)")
  BPV: "BPV",

  @doc("Overige relatie")
  Overig: "Overig",
}

@summary("Basis model, organisatie")
@doc("Basismodel voor een externe organisatie.")
@example(#{ identifier: "ORG-001" })
model BasisModelOrganisatie {
  @doc("Unieke identifier van de organisatie")
  identifier?: IdentifierOrganisatie;
}

@summary("Hoofd model, organisatie")
@doc("Hoofdmodel voor een organisatie met naam en relatietype.")
@example(#{
  identifier: "ORG-001",
  naam: "ASML Netherlands B.V.",
  actief: #{ nu: true },
  relatieType: OrganisatieRelatieType.BPV,
})
model HoofdModelOrganisatie extends BasisModelOrganisatie {
  @doc("Naam van de organisatie")
  naam: string;

  @doc("Actieve periode van de organisatie")
  actief: ComponentActief;

  @doc("Type relatie met de organisatie")
  relatieType: OrganisatieRelatieType;
}

@doc("Externe identifier varianten voor organisaties.")
@oneOf
union OrganisatieIdentifierVariant {
  @doc("Debiteurnummer in Eduarte")
  eduarteDebiteurnummer: ComponentIdentifierEduarteDebiteurnummer,

  @doc("Overige externe identifier")
  overig: ComponentIdentifier,
}

@summary("Volledig model, organisatie")
@doc("Volledig model voor een organisatie inclusief adressen, identifiers, referenties en contactgegevens.")
@example(#{
  identifier: "ORG-001",
  naam: "ASML Netherlands B.V.",
  actief: #{ nu: true },
  relatieType: OrganisatieRelatieType.BPV,
  contactgegevens: #[
    #{
      type: ContactgegevenType.email,
      waarde: "stage@asml.com",
      gebruik: ContactgegevenGebruik.organisatie,
    }
  ],
  adressen: #[
    #{
      land: #{ code: "NLD", naam: "Nederland", engelseNaam: "Netherlands" },
      type: AdresType.woon,
      actief: #{ nu: true },
      plaats: "Veldhoven",
      straat: "De Run",
      postcode: "5504 DR",
      huisnummer: "6501",
      huisnummerOnderdelen: #{ basis: "6501" },
    }
  ],
})
model VolledigModelOrganisatie extends HoofdModelOrganisatie {
  @summary("Adressen")
  @doc("Adresgegevens van de organisatie")
  adressen?: ComponentAdres[];

  @doc("Externe identifiers van de organisatie")
  identifiers?: OrganisatieIdentifierVariant[];

  @summary("Referenties")
  @doc("Referenties naar andere entiteiten")
  referenties?: ComponentReferentie[];

  @doc("Inschrijvingen gerelateerd aan deze organisatie")
  inschrijvingen?: Inschrijving[];

  @summary("Contactgegevens")
  @doc("Contactgegevens van de organisatie")
  contactgegevens?: ComponentContactgegeven[];
}

@summary("Organisatie")
@doc("Organisatie representatie (hoofd- of basismodel).")
@oneOf
union Organisatie {
  hoofd: HoofdModelOrganisatie,
  basis: BasisModelOrganisatie,
}

@summary("Organisatie schema's")
@doc("Alle mogelijke organisatie modellen.")
@oneOf
union OrganisatieModellen {
  volledig: VolledigModelOrganisatie,
  hoofd: HoofdModelOrganisatie,
  basis: BasisModelOrganisatie,
}

// ==========================================
// Organisatie-eenheid modellen
// ==========================================

@summary("Identifier, organisatie-eenheid")
@doc("Unieke identifier voor een interne organisatie-eenheid.")
scalar IdentifierOrganisatieeenheid extends string;

@doc("Type organisatie-eenheid")
enum OrganisatieeenheidType {
  @doc("Onderwijsinstelling")
  instelling: "instelling",

  @doc("Propositie / sector / cluster")
  propositie: "propositie",

  @doc("Onderwijsteam of afdeling")
  team: "team",
}

@summary("Basis model, organisatie-eenheid")
@doc("Basismodel voor een interne organisatie-eenheid.")
@example(#{ type: OrganisatieeenheidType.team, identifier: "TEAM1" })
model BasisModelOrganisatieeenheid {
  @doc("Type organisatie-eenheid")
  type: OrganisatieeenheidType;

  @doc("Unieke identifier van de organisatie-eenheid")
  identifier: IdentifierOrganisatieeenheid;

  @doc("Bovenliggende organisatie-eenheid (moedereenheid)")
  moedereenheid?: BasisModelOrganisatieeenheid;
}

@summary("Hoofd model, organisatie-eenheid")
@doc("Hoofdmodel voor een organisatie-eenheid inclusief leidinggevende.")
@example(#{
  type: OrganisatieeenheidType.team,
  identifier: "TEAM1",
  leidinggevende: #{
    identifier: "123456",
    roepnaam: "Jan",
    achternaam: "Jansen",
  },
})
model HoofdModelOrganisatieEenheid extends BasisModelOrganisatieeenheid {
  @doc("Leidinggevende medewerker van de organisatie-eenheid")
  leidinggevende: Medewerker;
}

@summary("Volledig model, organisatie-eenheid")
@doc("Volledig model voor een organisatie-eenheid inclusief medewerkers.")
@example(#{
  type: OrganisatieeenheidType.team,
  identifier: "TEAM1",
  leidinggevende: #{
    identifier: "123456",
    roepnaam: "Jan",
    achternaam: "Jansen",
  },
  medewerkers: #[
    #{ identifier: "123456", roepnaam: "Jan", achternaam: "Jansen" }
  ],
})
model VolledigModelOrganisatieEenheid extends HoofdModelOrganisatieEenheid {
  @doc("Medewerkers behorend tot deze organisatie-eenheid")
  medewerkers: Medewerker[];
}

@doc("Organisatie-eenheid representatie (hoofd- of basismodel).")
@oneOf
union OrganisatieEenheid {
  basis: BasisModelOrganisatieeenheid,
  hoofd: HoofdModelOrganisatieEenheid,
}

@summary("Organisatie-eenheid schema's")
@doc("Alle mogelijke organisatie-eenheid modellen.")
@oneOf
union OrganisatieEenheidModellen {
  basis: BasisModelOrganisatieeenheid,
  hoofd: HoofdModelOrganisatieEenheid,
  volledig: VolledigModelOrganisatieEenheid,
}
