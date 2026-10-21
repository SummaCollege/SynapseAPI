import "@typespec/openapi";

namespace Synapse.Models;

enum AanstellingCategorie {
    onderwijs,
    bedrijfsvoering,
}

@summary("AanstellingComponent")
model AanstellingComponent {
    ...IsBeperktActief;
    ...IsGekoppeldAanOrganisatieEenheid;

    /**
     * Aanstelling categorie, gebaseerd op organisatieeenheid
     *
     * ### Logica (ongeveer)
     *
     */
    categorie: AanstellingCategorie;

    /**
     * Functie
     */
    functie: FunctieComponent;

    /**
     * Onvang van de aanstellen (formatieverdeling)
     */
    omvang: AanstellingOmvangComponent;
}

@summary("AanstellingOmvang")
model AanstellingOmvangComponent {
    /**
     * Werktijdfactor (WTF) op deze specifieke component/formatieplaats.
     * Dit is de netto-inzet (RoosterFTE * (Percentage / 100)).
     * Voorbeeld: 0.4000
     */
    wtf: decimal;

    /**
     * Totale contractuele betrekkingsomvang van het bovenliggende contract/dienstverband (RoosterFTE).
     * Voorbeeld: 0.8000
     */
    contractWtf: decimal;

    /**
     * Formatieverdelingspercentage van deze component t.o.v. het totale contract (0 - 100.0).
     * Voorbeeld: 50.0
     */
    @minValue(0)
    @maxValue(100)
    percentage: decimal;
}
