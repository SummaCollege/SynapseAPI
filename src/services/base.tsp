import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "../models";
import "../config.tsp";

using Http;
using OpenAPI;

namespace Synapse.Routes {

}

/**
 * # Summa Synapse Microservice
 * For reference when developing
 */
@service(#{ title: "Summa Synapse Microservice" })
@info(#{
    contact: #{
        name: "Summa College - Integratie en ontwikkeling",
        email: "devops@summacollege.nl",
        url: "https://synapse.summacollege.nl",
    },
})
@server(EnvironmentServers.Local, EnvironmentNames.Local)
namespace Synapse {
    using Synapse.Config;
    using Synapse.Routes;
}
