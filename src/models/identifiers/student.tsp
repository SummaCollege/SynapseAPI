import "@typespec/http";
using Http;

namespace Synapse.Models;

model StudentIdentifier extends Record<string> {
    /**
     * De identifier van de student
     */
    @path
    @pattern("PS[0-9]+|AV[0-9]+|STU[0-9]+")
    student: string;
}
