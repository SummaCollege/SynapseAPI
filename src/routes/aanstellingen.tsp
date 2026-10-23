import "@typespec/http";
import "@typespec/openapi";
import "../models";

using Http;
using OpenAPI;
using Synapse.Models;

namespace Synapse.Routes;

@route("/aanstellingen")
@tag("Medewerkers")
@tag("Aanstellingen")
interface Aanstellingen {
    /**
     * De aanstellingen van de opgegeven medewerker ophalen
     */
    @get
    @summary("/medewerkers/{medewerker}/aanstellingen")
    get(
        ...MedewerkerIdentifier,
        ...SelectParameters,
        ...ActiefFilterParameters,
    ): {
        ...OkResponse;
        ...Body<AanstellingComponent[]>;
    };
}
