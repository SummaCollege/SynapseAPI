import "@typespec/http";
import "@typespec/openapi";
import "../models";

using Http;
using OpenAPI;
using Synapse.Models;

namespace Synapse.Routes;

@route("/inschrijvingen")
@tag("Inschrijvingen")
interface Inschrijvingen {
    /**
     * Een specifieke inschrijving ophalen op basis van de identifier
     */
    @extension("x-badges", #[#{ name: "DRAFT", color: "red" }])
    @get
    @summary("/inschrijvingen/{inschrijving}")
    get(...InschrijvingIdentifier): {
        ...OkResponse;
        ...Body<Inschrijving>;
    };
}

@route("/studenten/{student}/inschrijvingen")
@tag("Inschrijvingen")
@tag("Studenten")
interface StudentInschrijvingen {
    /**
     * Alle inschrijvingen voor de opgegeven student ophalen
     */
    @get
    @summary("/studenten/{student}/inschrijvingen")
    listInschrijvingen(
        ...StudentIdentifier,
        ...SelectParameters,
        ...ActiefFilterParameters,
    ): {
        ...OkResponse;
        ...Body<Inschrijving[]>;
    };

    /**
     * Een specifieke inschrijving voor de opgegeven student ophalen
     */
    @get
    @extension("x-badges", #[#{ name: "DRAFT", color: "red" }])
    @summary("/studenten/{student}/inschrijvingen/{inschrijving}")
    getInschrijving(
        ...StudentIdentifier,
        ...InschrijvingIdentifier,
        ...SelectParameters,
        ...ActiefFilterParameters,
    ): {
        ...OkResponse;
        ...Body<Inschrijving>;
    };
}
