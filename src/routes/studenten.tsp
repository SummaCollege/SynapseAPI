import "@typespec/http";
import "@typespec/openapi";
import "../models";

using Http;
using OpenAPI;
using Synapse.Models;

namespace Synapse.Routes;

@route("/studenten")
@tag("Studenten")
interface Studenten {
    /**
     * Alle studenten ophalen
     */
    @get
    @extension("x-badges", #[#{ name: "DRAFT", color: "red" }])
    @summary("/studenten")
    list(...SelectParameters, ...ActiefFilterParameters): {
        ...OkResponse;
        ...Body<Student[]>;
    };

    /**
     * De opgegeven student ophalen
     */
    @get
    @summary("/studenten/{student}")
    get(...StudentIdentifier, ...SelectParameters, ...ActiefFilterParameters): {
        ...OkResponse;
        ...Body<Student>;
    };
}
