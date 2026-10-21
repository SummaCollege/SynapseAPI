import "@typespec/openapi";

namespace Synapse.Models;

using OpenAPI;

enum FunctieGroep {
    OnderwijsOndersteunendPersooneel: "oop", // OOP
    OnderwijsPersoneel: "op", // OP
    OndersteunendEnBeheersdPersoneel: "obp", // OBP
    Stagiair: "stag", // Stag
    Vrijwilliger: "vrijwillig", // Vrijwillig
    Management: "mgt", // Mgt
    Teamleider: "teamleider", // Teamleider
}

@summary("Functie")
model FunctieComponent {
    /**
     * Functie code, unieke afkorting voor één specifieke functie
     */
    code: string;

    /**
     * Functie naam, volledig uitgeschreven functie naam
     */
    naam: string;

    /**
     * Functie groep
     */
    @extension(
        "x-badges",
        #[#{ name: "FIQL", position: "after", color: "persian-green" }]
    )
    groep: FunctieGroep;
}
