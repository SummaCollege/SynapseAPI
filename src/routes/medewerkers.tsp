import "@typespec/http";
import "@typespec/openapi";
import "../models";

using Http;
using OpenAPI;
using Synapse.Models;

namespace Synapse.Routes;

@route("/medewerkers")
@tag("Medewerkers")
interface Medewerkers {
    /**
     * Alle medewerkers ophalen
     */
    @get
    @summary("/medewerkers")
    list(...SelectParameters, ...ActiefFilterParameters, ...QueryParameter): {
        ...OkResponse;
        ...Body<Medewerker[]>;
    };

    /**
     * De opgegeven medewerker ophalen
     */
    @get
    @summary("/medewerkers/{medewerker}")
    get(
        ...MedewerkerIdentifier,
        ...SelectParameters,
        ...ActiefFilterParameters,
    ): {
        ...OkResponse;
        ...Body<Medewerker>;
    };
}
