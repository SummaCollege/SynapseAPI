import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

@summary("Identifier, inschrijving cursus")
@doc("Cursuscode voor inschrijving.")
scalar IdentifierInschrijvingCursus extends string;

@summary("Identifier, inschrijving opleiding")
@doc("Opleidingscode voor inschrijving.")
scalar IdentifierInschrijvingOpleiding extends string;

@summary("Identifier, inschrijving arrangement")
@doc("Arrangementcode voor inschrijving.")
scalar IdentifierInschrijvingArrangement extends string;

@summary("Identifier, inschrijving")
@doc("Unieke identifier voor een inschrijving (opleiding, arrangement of cursus).")
@oneOf
union IdentifierInschrijving {
  opleiding: IdentifierInschrijvingOpleiding,
  arrangement: IdentifierInschrijvingArrangement,
  cursus: IdentifierInschrijvingCursus,
}

@doc("Type inschrijving")
enum InschrijvingType {
  @doc("Inschrijving voor een volledige opleiding")
  opleiding: "opleiding",

  @doc("Inschrijving voor een onderwijsarrangement")
  arrangement: "arrangement",

  @doc("Inschrijving voor een losse cursus of module")
  cursus: "cursus",
}

@doc("Status van de inschrijving")
enum InschrijvingStatus {
  @doc("In intakefase")
  intake: "intake",

  @doc("In voorbereiding")
  voorbereid: "voorbereid",

  @doc("Onderwijscontract opgesteld")
  contract: "contract",

  @doc("Definitief ingeschreven")
  ingeschreven: "ingeschreven",
}

@summary("Basis model, inschrijving")
@doc("Basismodel voor een inschrijving.")
@example(#{ type: InschrijvingType.cursus, identifier: "CURS123" })
model BasisModelInschrijving {
  @doc("Type van de inschrijving")
  type: InschrijvingType;

  @doc("Unieke identifier van de inschrijving")
  identifier: IdentifierInschrijving;
}

@summary("Hoofd model, inschrijving")
@doc("Hoofdmodel voor een inschrijving inclusief activiteit en status.")
@example(#{
  type: InschrijvingType.cursus,
  identifier: "CURS123",
  actief: #{ nu: true },
  status: InschrijvingStatus.ingeschreven,
})
model HoofdModelInschrijving extends BasisModelInschrijving {
  @doc("Actieve periode van de inschrijving")
  actief: ComponentActief;

  @summary("Status")
  @doc("Status van de inschrijving")
  status: InschrijvingStatus;
}

@summary("Volledig model, inschrijving")
@doc("Volledig model voor een inschrijving inclusief gekoppelde student.")
@example(#{
  type: InschrijvingType.cursus,
  identifier: "CURS123",
  actief: #{ nu: true },
  status: InschrijvingStatus.ingeschreven,
  student: #{ identifier: "AV12345", roepnaam: "Lisa", achternaam: "Peters" },
})
model VolledigModelInschrijving extends HoofdModelInschrijving {
  @doc("De ingeschreven student")
  student: Student;
}

@summary("Inschrijving")
@doc("Inschrijving representatie (hoofd- of basismodel).")
@oneOf
union Inschrijving {
  hoofd: HoofdModelInschrijving,
  basis: BasisModelInschrijving,
}

@summary("Inschrijving schema's")
@doc("Alle mogelijke inschrijving modellen.")
@oneOf
union InschrijvingModellen {
  volledig: VolledigModelInschrijving,
  hoofd: HoofdModelInschrijving,
  basis: BasisModelInschrijving,
}
