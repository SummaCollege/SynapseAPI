import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace SummaSynapse;

@doc("Type adres")
enum AdresType {
  @doc("Woonadres")
  woon: "woon",

  @doc("Factuuradres")
  factuur: "factuur",

  @doc("Postadres")
  post: "post",
}

@doc("Landinformatie volgens ISO 3166-1")
model Land {
  @doc("ISO 3166-1 alpha-3 landcode")
  code: string;

  @doc("Nederlandse landnaam")
  naam: string;

  @doc("Engelse landnaam")
  engelseNaam: string;
}

@doc("Losse onderdelen huisnummer (indien beschikbaar)")
model HuisnummerOnderdelen {
  @doc("Basis huisnummer")
  basis: string;

  @doc("Voorvoegsel huisnummer (indien gescheiden beschikbaar uit bron)")
  prefix?: string;

  @doc("Achtervoegsel huisnummer (indien gescheiden beschikbaar uit bron)")
  suffix?: string;
}

@summary("Actief component")
@doc("Component dat de tijdsgebonden geldigheid aangeeft.")
@example(#{
  nu: true,
  vanaf: plainDate.fromISO("2024-01-01"),
  tot: plainDate.fromISO("2025-01-01"),
})
model ComponentActief {
  @doc("""
    Geeft aan of de huidige datum (/tijd) binnen het datumbereik valt.
    
    Vanaf == vandaag of in het verleden
    Tot == in de toekomst
    
    Beide leeg dan false
    """)
  nu: boolean;

  @summary("Tot")
  @doc("Tot datum (exclusief)")
  tot?: plainDate;

  @summary("Vanaf")
  @doc("Vanaf datum (inclusief)")
  vanaf?: plainDate;
}

@summary("Adres component")
@doc("Adresgegevens van een persoon of organisatie.")
@example(#{
  land: #{ code: "NLD", naam: "Nederland", engelseNaam: "Netherlands" },
  type: AdresType.woon,
  actief: #{ nu: true, vanaf: plainDate.fromISO("2023-08-01") },
  plaats: "Eindhoven",
  straat: "Sterrenlaan",
  postcode: "5631 KA",
  huisnummer: "10",
  huisnummerOnderdelen: #{ basis: "10" },
})
model ComponentAdres {
  @doc("Land")
  land: Land;

  @summary("Type")
  @doc("Type adres")
  type: AdresType;

  @doc("Geldigheidsperiode van het adres")
  actief: ComponentActief;

  @doc("Plaatsnaam")
  plaats: string;

  @summary("Waarde")
  @doc("Straatnaam")
  straat: string;

  @doc("Postcode")
  postcode: string;

  @doc("Huisnummer samengevoegd")
  huisnummer: string;

  @doc("Indien beschikbaar/aangeleverd adresregels")
  adresregels?: string[];

  @doc("Losse onderdelen huisnummer (indien beschikbaar)")
  huisnummerOnderdelen: HuisnummerOnderdelen;
}

@doc("Type contactgegeven")
enum ContactgegevenType {
  @doc("E-mailadres")
  email: "email",

  @doc("Telefoonnummer vast")
  telefoon: "telefoon",

  @doc("Mobiel telefoonnummer")
  mobiel: "mobiel",
}

@doc("Gebruik van het contactgegeven")
enum ContactgegevenGebruik {
  @doc("Privé contactgegeven")
  eigen: "eigen",

  @doc("Organisatie contactgegeven")
  organisatie: "organisatie",

  @doc("Intern contactgegeven")
  intern: "intern",

  @doc("Facturatie contactgegeven")
  factuur: "factuur",
}

@summary("Contactgegeven component")
@doc("Contactgegevens zoals e-mailadres of telefoonnummer.")
@example(#{
  type: ContactgegevenType.email,
  waarde: "l.peters@edu.summacollege.nl",
  gebruik: ContactgegevenGebruik.organisatie,
})
model ComponentContactgegeven {
  @summary("Type")
  @doc("Type contactgegeven")
  type: ContactgegevenType;

  @summary("Waarde")
  @doc("Waarde van het contactgegeven (e-mailadres of telefoonnummer)")
  waarde: string;

  @summary("Gebruik")
  @doc("Toepassingsgebied / context van het contactgegeven")
  gebruik: ContactgegevenGebruik;
}

@summary("Identifier component")
@doc("Algemeen component voor externe identifiers.")
@example(#{ naam: "id", waarde: "12345", systeem: "Eduarte" })
model ComponentIdentifier {
  @summary("Naam")
  @doc("De naam van de identifier (in het externe systeem, of afgeleid hiervan)")
  naam: string;

  @summary("Waarde")
  @doc("De identifier waarde (afhankelijk van systeem, altijd getoond als string)")
  waarde: string;

  @summary("Systeem")
  @doc("Het systeem waarin deze entiteit met deze identifier bekend is")
  systeem: string;
}

@summary("Identifier component (Eduarte debiteurnummer)")
@doc("Eduarte debiteurnummer identifier component.")
@example(#{ naam: "debiteurnummer", waarde: "DEB-98765", systeem: "Eduarte" })
model ComponentIdentifierEduarteDebiteurnummer {
  @doc("De naam van de identifier (in het externe systeem, of afgeleid hiervan)")
  naam: "debiteurnummer" = "debiteurnummer";

  @doc("De identifier waarde (afhankelijk van systeem, altijd getoond als string)")
  waarde: string;

  @doc("Het systeem waarin deze entiteit met deze identifier bekend is")
  systeem: "Eduarte" = "Eduarte";
}

@summary("Entiteit component")
@doc("Referentie naar een andere entiteit binnen het API-platform.")
@example(#{ entiteit: "Student", identifier: "AV12345" })
model ComponentReferentie {
  @summary("Entiteit")
  @doc("De entiteit van de referentie")
  entiteit: string;

  @doc("De identifier van de gerefereerde entiteit")
  identifier:
    | IdentifierGroep
    | IdentifierCursus
    | IdentifierStudent
    | IdentifierGebruiker
    | IdentifierMedewerker
    | IdentifierAanstelling
    | IdentifierInschrijving
    | IdentifierInschrijvingCursus
    | IdentifierOrganisatieeenheid
    | IdentifierInschrijvingOpleiding
    | IdentifierInschrijvingArrangement
    | IdentifierOrganisatie;
}

@summary("Basis model, foutmelding")
@doc("Basis foutmeldingsmodel.")
@example(#{
  code: "FOUT_404",
  melding: "De opgevraagde resource is niet gevonden.",
})
model BasisModelFoutMelding {
  @summary("Code")
  @doc("Foutcode")
  code: string;

  @summary("Melding")
  @doc("Foutmelding omschrijving")
  melding: string;
}

@doc("Standaard foutrespons body.")
@example(#{ error: "Resource niet gevonden" })
model Foutrespons {
  @doc("Foutomschrijving")
  error?: string;
}
