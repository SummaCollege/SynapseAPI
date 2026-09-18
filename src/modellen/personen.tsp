import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

@doc("Geslacht van een persoon")
enum Geslacht {
  @doc("Mannelijk")
  man: "man",

  @doc("Vrouwelijk")
  vrouw: "vrouw",

  @doc("Onbekend")
  onbekend: "onbekend",
}

// ==========================================
// Persoon modellen
// ==========================================

@summary("Basis model, persoon")
@doc("Basismodel voor een persoon.")
model BasisModelPersoon {}

@summary("Hoofd model, persoon")
@doc("Hoofdmodel voor een persoon met persoonsgegevens.")
@example(#{
  roepnaam: "Lisa",
  achternaam: "Peters",
  geslacht: Geslacht.vrouw,
  geboortedatum: plainDate.fromISO("2001-02-02"),
})
model HoofdModelPersoon extends BasisModelPersoon {
  @summary("Geslacht")
  @doc("Geslacht van de persoon")
  geslacht?: Geslacht;

  @summary("Roepnaam")
  @doc("Roepnaam van de persoon")
  roepnaam: string;

  @summary("Voornamen")
  @doc("Officiële voornamen")
  voornamen?: string[];

  @doc("Achternaam van de persoon")
  achternaam: string;

  @summary("Geboortenaam")
  @doc("Meisjesnaam of geboortenaam")
  meisjesnaam?: string;

  @doc("Voorletters van de persoon")
  voorletters?: string[];

  @summary("Geboortedatum")
  @doc("Geboortedatum van de persoon")
  geboortedatum?: plainDate;

  @doc("Tussenvoegsel van de achternaam (bijv. 'van der')")
  tussenvoegsel?: string;

  @doc("Tussenvoegsel van de meisjesnaam")
  meisjesnaamtussenvoegsel?: string;
}

@summary("Volledig model, persoon")
@doc("Volledig model voor een persoon inclusief adressen, gebruiker en contactgegevens.")
@example(#{
  roepnaam: "Lisa",
  achternaam: "Peters",
  geslacht: Geslacht.vrouw,
  geboortedatum: plainDate.fromISO("2001-02-02"),
  gebruiker: #{
    actief: true,
    identifier: "AV12345@mc-eindhoven.nl",
    weergaveNaam: "Lisa Peters",
  },
  contactgegevens: #[
    #{
      type: ContactgegevenType.email,
      waarde: "l.peters@edu.summacollege.nl",
      gebruik: ContactgegevenGebruik.organisatie,
    }
  ],
})
model VolledigModelPersoon extends HoofdModelPersoon {
  @summary("Adressen")
  @doc("Adresgegevens van de persoon")
  adressen?: ComponentAdres[];

  @doc("Gekoppelde gebruikersaccount")
  gebruiker?: Gebruiker;

  @summary("Contactgegevens")
  @doc("Contactgegevens van de persoon")
  contactgegevens?: ComponentContactgegeven[];
}

@summary("Persoon")
@doc("Persoon representatie (hoofd- of basismodel).")
@oneOf
union Persoon {
  hoofd: HoofdModelPersoon,
  basis: BasisModelPersoon,
}

@summary("Persoon schema's")
@doc("Alle mogelijke persoon modellen.")
@oneOf
union PersoonModellen {
  volledig: VolledigModelPersoon,
  hoofd: HoofdModelPersoon,
  basis: BasisModelPersoon,
}

// ==========================================
// Gebruiker modellen
// ==========================================

@format("email")
@summary("Identifier, gebruiker")
@doc("User Principal Name (UPN) van de gebruiker.")
scalar IdentifierGebruiker extends string;

@summary("Basis model, gebruiker")
@doc("Basismodel voor een gebruikersaccount.")
@example(#{ identifier: "AV12345@mc-eindhoven.nl" })
model BasisModelGebruiker {
  @doc("Unieke identifier van de gebruiker (UPN)")
  identifier: IdentifierGebruiker;
}

@summary("Hoofd model, gebruiker")
@doc("Hoofdmodel voor een gebruikersaccount met activiteitsstatus.")
@example(#{
  identifier: "AV12345@mc-eindhoven.nl",
  actief: true,
  weergaveNaam: "Lisa Peters",
})
model HoofdModelGebruiker extends BasisModelGebruiker {
  @summary("Actief")
  @doc("Geeft aan of het gebruikersaccount actief is")
  actief: boolean;

  @summary("Weergave naam")
  @doc("Volledige weergavenaam van de gebruiker")
  weergaveNaam?: string;
}

@summary("Volledig model, gebruiker")
@doc("Volledig model voor een gebruikersaccount.")
@example(#{
  identifier: "AV12345@mc-eindhoven.nl",
  actief: true,
  weergaveNaam: "Lisa Peters",
})
model VolledigModelGebruiker extends HoofdModelGebruiker {}

@summary("Gebruiker")
@doc("Gebruiker representatie (hoofd- of basismodel).")
@oneOf
union Gebruiker {
  hoofd: HoofdModelGebruiker,
  basis: BasisModelGebruiker,
}

@summary("Gebruiker schema's")
@doc("Alle mogelijke gebruiker modellen.")
@oneOf
union GebruikerModellen {
  volledig: VolledigModelGebruiker,
  hoofd: HoofdModelGebruiker,
  basis: BasisModelGebruiker,
}

// ==========================================
// Student modellen
// ==========================================

@pattern("[A-Za-z]{2}[0-9]+")
@summary("Identifier, gebruiker")
@doc("Gebruikersnaam van de student (bijvoorbeeld AV12345).")
scalar IdentifierStudent extends string;

@summary("Basis model, student")
@doc("Basismodel voor een student.")
@example(#{ identifier: "AV12345" })
model BasisModelStudent {
  @doc("Unieke identifier van de student")
  identifier?: IdentifierStudent;
}

@summary("Hoofd model, student")
@doc("Hoofdmodel voor een student inclusief persoonsgegevens.")
@example(#{
  identifier: "AV12345",
  roepnaam: "Lisa",
  achternaam: "Peters",
  geslacht: Geslacht.vrouw,
  geboortedatum: plainDate.fromISO("2001-02-02"),
})
model HoofdModelStudent extends BasisModelStudent {
  ...HoofdModelPersoon;
}

@summary("Volledig model, student")
@doc("Volledig model voor een student inclusief groepen en inschrijvingen.")
@example(#{
  identifier: "AV12345",
  roepnaam: "Lisa",
  achternaam: "Peters",
  geslacht: Geslacht.vrouw,
  geboortedatum: plainDate.fromISO("2001-02-02"),
  gebruiker: #{
    actief: true,
    identifier: "AV12345@mc-eindhoven.nl",
    weergaveNaam: "Lisa Peters",
  },
  contactgegevens: #[
    #{
      type: ContactgegevenType.email,
      waarde: "l.peters@edu.summacollege.nl",
      gebruik: ContactgegevenGebruik.organisatie,
    }
  ],
})
model VolledigModelStudent extends HoofdModelStudent {
  ...VolledigModelPersoon;

  @doc("Groepen waaraan de student deelneemt")
  groepen?: Groep[];

  @doc("Inschrijvingen van de student")
  inschrijvingen?: Inschrijving[];
}

@summary("Student")
@doc("Student representatie (hoofd- of basismodel).")
@oneOf
union Student {
  hoofd: HoofdModelStudent,
  basis: BasisModelStudent,
}

@summary("Student schema's")
@doc("Alle mogelijke student modellen.")
@oneOf
union StudentModellen {
  volledig: VolledigModelStudent,
  hoofd: HoofdModelStudent,
  basis: BasisModelStudent,
}

// ==========================================
// Medewerker modellen
// ==========================================

@summary("Identifier, medewerker")
@doc("Uniek Summa personeelsnummer.")
scalar IdentifierMedewerker extends string;

@summary("Basis model, medewerker")
@doc("Basismodel voor een medewerker.")
@example(#{ identifier: "123456" })
model BasisModelMedewerker {
  @doc("Unieke medewerker identifier")
  identifier?: IdentifierMedewerker;
}

@summary("Hoofd model, medewerker")
@doc("Hoofdmodel voor een medewerker inclusief persoonsgegevens.")
@example(#{
  identifier: "123456",
  roepnaam: "Jan",
  achternaam: "Jansen",
  geslacht: Geslacht.man,
  geboortedatum: plainDate.fromISO("1980-01-01"),
})
model HoofdModelMedewerker extends BasisModelMedewerker {
  ...HoofdModelPersoon;
}

@summary("Volledig model, medewerker")
@doc("Volledig model voor een medewerker inclusief groepen en aanstellingen.")
@example(#{
  identifier: "123456",
  roepnaam: "Jan",
  achternaam: "Jansen",
  geslacht: Geslacht.man,
  geboortedatum: plainDate.fromISO("1980-01-01"),
  actief: #{ nu: true },
  gebruiker: #{
    actief: true,
    identifier: "JAJA@summacollege.nl",
    weergaveNaam: "Jan Jansen",
  },
  contactgegevens: #[
    #{
      type: ContactgegevenType.email,
      waarde: "j.jansen@summacollege.nl",
      gebruik: ContactgegevenGebruik.organisatie,
    }
  ],
})
model VolledigModelMedewerker extends HoofdModelMedewerker {
  ...VolledigModelPersoon;

  @doc("""
    Actief geeft aan of deze medewerker op dit moment een actieve aanstelling heeft.
    
    **Nu:** Momenteel een actieve aanstelling (zie details).
    **Van:** Datum eerste 'werkdag' ooit bij onze organisatie.
    **Tot:** Datum laatste 'werkdag' ooit bij onze organisatie, behalve als er een aanstelling zonder einddatum is dan blijft deze leeg.
    """)
  actief: ComponentActief;

  @doc("Groepen waarin de medewerker actief is")
  groepen?: Groep[];

  @doc("Aanstellingen van de medewerker")
  aanstellingen?: Aanstelling[];
}

@summary("Medewerker")
@doc("Medewerker representatie (hoofd- of basismodel).")
@oneOf
union Medewerker {
  hoofd: HoofdModelMedewerker,
  basis: BasisModelMedewerker,
}

@summary("Medewerker schema's")
@doc("Alle mogelijke medewerker modellen.")
@oneOf
union MedewerkerModellen {
  volledig: VolledigModelMedewerker,
  hoofd: HoofdModelMedewerker,
  basis: BasisModelMedewerker,
}

// ==========================================
// Begeleider modellen
// ==========================================

@summary("Basis model, begeleider")
@doc("Basismodel voor een studentbegeleider.")
@example(#{ identifier: "123456" })
model BasisModelBegeleider extends BasisModelMedewerker {}

@summary("Hoofd model, begeleider")
@doc("Hoofdmodel voor een studentbegeleider.")
@example(#{
  identifier: "123456",
  roepnaam: "Jan",
  achternaam: "Jansen",
  actief: #{ nu: true },
  contactgegevens: #[
    #{
      type: ContactgegevenType.email,
      waarde: "j.jansen@summacollege.nl",
      gebruik: ContactgegevenGebruik.organisatie,
    }
  ],
})
model HoofdModelBegeleider extends BasisModelBegeleider {
  @doc("Medewerker begeleidt gerelateerde student van/tot")
  actief: ComponentActief;

  @doc("Roepnaam van de begeleider")
  roepnaam: string;

  @doc("Achternaam van de begeleider")
  achternaam: string;

  @doc("Tussenvoegsel van de begeleider")
  tussenvoegsel?: string;

  @doc("Contactgegevens van de begeleider")
  contactgegevens?: ComponentContactgegeven[];
}

@doc("Begeleide student verpakking.")
model BegeleideStudentWrapper {
  @doc("De begeleide student")
  studenten: Student;
}

@summary("Volledig model, begeleider")
@doc("Volledig model voor een begeleider inclusief de begeleide studenten.")
@example(#{
  identifier: "123456",
  roepnaam: "Jan",
  achternaam: "Jansen",
  actief: #{ nu: true },
  studenten: #[
    #{
      studenten: #{
        identifier: "AV12345",
        roepnaam: "Lisa",
        achternaam: "Peters",
      },
    }
  ],
})
model VolledigModelBegeleider extends HoofdModelBegeleider {
  @doc("De studenten die begeleid worden door de betreffende begeleider (medewerker)")
  studenten: BegeleideStudentWrapper[];
}

@summary("Inschrijving")
@doc("Begeleider representatie (hoofd- of basismodel).")
@oneOf
union Begeleider {
  hoofd: HoofdModelBegeleider,
  basis: BasisModelBegeleider,
}

@summary("Studentbegeleider schema's")
@doc("Alle mogelijke studentbegeleider modellen.")
@oneOf
union BegeleiderModellen {
  volledig: VolledigModelBegeleider,
  hoofd: HoofdModelBegeleider,
  basis: BasisModelBegeleider,
}
