import "@typespec/http";
using Http;

namespace Synapse.Models;

model MedewerkerIdentifier extends Record<string> {
    /**
     * De identifier van de medewerker
     */
    @path
    @pattern("SN[0-9]+")
    medewerker: string;
}
