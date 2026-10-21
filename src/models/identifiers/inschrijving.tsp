import "@typespec/http";
using Http;

namespace Synapse.Models;

model InschrijvingIdentifier extends Record<string> {
    /**
     * De identifier van de inschrijving
     */
    @path
    @pattern("INS[0-9]+")
    inschrijving: string;
}
