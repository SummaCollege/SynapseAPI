import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

@summary("Identifier, groep")
@doc("Unieke code of identifier van de groep.")
scalar IdentifierGroep extends string;

@doc("Type groep")
enum GroepType {
  @doc("Stamgroep")
  Stamgroep: "Stamgroep",

  @doc("Lesgroep")
  Lesgroep: "Lesgroep",

  @doc("Klas")
  Klas: "Klas",

  @doc("Tutorgroep")
  Tutorgroep: "Tutorgroep",

  @doc("Sectie")
  Sectie: "Sectie",

  @doc("Examenklas")
  Examenklas: "Examenklas",

  @doc("Overige groepering")
  Overig: "Overig",
}

@summary("Basis model, groep")
@doc("Basismodel voor een groep.")
@example(#{ identifier: "1234-1a-ST" })
model BasisModelGroep {
  @doc("Unieke identifier van de groep")
  identifier: IdentifierGroep;
}

@summary("Hoofd model, groep")
@doc("Hoofdmodel voor een groep met aanvullende eigenschappen.")
@example(#{
  identifier: "1234-1a-ST",
  naam: "Stamgroep 1A",
  type: GroepType.Stamgroep,
  actief: #{ nu: true, vanaf: plainDate.fromISO("2023-09-01") },
})
model HoofdModelGroep extends BasisModelGroep {
  @doc("Naam van de groep")
  naam?: string;

  @summary("Type")
  @doc("Type van de groep")
  type?: GroepType;

  @doc("Actieve periode van de groep")
  actief?: ComponentActief;
}

@doc("Student gekoppeld aan een groep (groepslid) inclusief activiteitstatus.")
@oneOf
union GroepStudent {
  @doc("Student (hoofdmodel) met activiteitstatus")
  hoofd: HoofdModelStudent & {
    @doc("Actieve periode van de student binnen de groep")
    actief: ComponentActief,
  },

  @doc("Student (basismodel) met activiteitstatus")
  basis: BasisModelStudent & {
    @doc("Actieve periode van de student binnen de groep")
    actief: ComponentActief,
  },
}

@doc("Begeleider gekoppeld aan een groep (groepslid) inclusief activiteitstatus.")
@oneOf
union GroepBegeleider {
  @doc("Medewerker (hoofdmodel) met activiteitstatus")
  hoofd: HoofdModelMedewerker & {
    @doc("Actieve periode van de medewerker binnen de groep")
    actief: ComponentActief,
  },

  @doc("Medewerker (basismodel) met activiteitstatus")
  basis: BasisModelMedewerker & {
    @doc("Actieve periode van de medewerker binnen de groep")
    actief: ComponentActief,
  },
}

@summary("Volledig model, groep")
@doc("Volledig model voor een groep inclusief leden (studenten en begeleiders) en referenties.")
@example(#{
  identifier: "SG123",
  naam: "Stamgroep 1A",
  type: GroepType.Stamgroep,
  actief: #{ nu: true },
  studenten: #[
    #{
      identifier: "AV12345",
      roepnaam: "Lisa",
      achternaam: "Peters",
      actief: #{ nu: true },
    }
  ],
  begeleiders: #[
    #{ roepnaam: "Jan", achternaam: "Jansen", actief: #{ nu: true } }
  ],
  referenties: #[#{ entiteit: "Medewerker", identifier: "123456" }],
})
model VolledigModelGroep extends HoofdModelGroep {
  @doc("Studenten (leden) behorend tot de groep")
  studenten?: GroepStudent[];

  @doc("Begeleiders (leden) van de groep")
  begeleiders: GroepBegeleider[];

  @summary("Referenties")
  @doc("Referenties naar andere entiteiten")
  referenties: ComponentReferentie[];
}

@summary("Groep")
@doc("Groep representatie (hoofd- of basismodel).")
@oneOf
union Groep {
  hoofd: HoofdModelGroep,
  basis: BasisModelGroep,
}

// ==========================================
// Stamgroepen (verouderd / deprecated)
// ==========================================

#deprecated "Stamgroep is verouderd. Gebruik Groep in plaats hiervan."
@summary("Basis model, stamgroep")
@doc("Basismodel voor een stamgroep.")
@example(#{ identifier: "SG123", naam: "Stamgroep 1A" })
model BasisModelStamgroep {
  @summary("Naam")
  @doc("Naam van de stamgroep")
  naam?: string;

  @summary("Identifier")
  @doc("Unieke identifier van de stamgroep")
  identifier: string;
}

#deprecated "Stamgroep is verouderd. Gebruik Groep in plaats hiervan."
#suppress "deprecated" "Stamgroep modellen zijn zelf verouderd."
@summary("Hoofd model, stamgroep")
@doc("Hoofdmodel voor een stamgroep.")
@example(#{ identifier: "SG123", naam: "Stamgroep 1A", actief: #{ nu: true } })
model HoofdModelStamgroep extends BasisModelStamgroep {
  @doc("Actieve periode van de stamgroep")
  actief?: ComponentActief;
}

#deprecated "Stamgroep is verouderd. Gebruik Groep in plaats hiervan."
#suppress "deprecated" "Stamgroep modellen zijn zelf verouderd."
@summary("Volledig model, stamgroep")
@doc("Volledig model voor een stamgroep inclusief studenten en begeleiders.")
@example(#{
  identifier: "SG123",
  naam: "Stamgroep 1A",
  actief: #{ nu: true },
  begeleiders: #[#{ roepnaam: "Jan", achternaam: "Jansen" }],
})
model VolledigModelStamgroep extends HoofdModelStamgroep {
  @doc("Studenten in de stamgroep")
  studenten?: Student[];

  @doc("Begeleiders van de stamgroep")
  begeleiders: Medewerker[];
}

#deprecated "Stamgroep is verouderd. Gebruik Groep in plaats hiervan."
#suppress "deprecated" "Stamgroep modellen zijn zelf verouderd."
@summary("Stamgroep")
@doc("Stamgroep representatie (hoofd- of basismodel).")
@oneOf
union Stamgroep {
  hoofd: HoofdModelStamgroep,
  basis: BasisModelStamgroep,
}

#deprecated "Stamgroep schema's zijn verouderd."
#suppress "deprecated" "Stamgroep modellen zijn zelf verouderd."
@summary("Stamgroep schema's")
@doc("Alle mogelijke stamgroep modellen.")
@oneOf
union StamgroepModellen {
  volledig: VolledigModelStamgroep,
  hoofd: HoofdModelStamgroep,
  basis: BasisModelStamgroep,
}
