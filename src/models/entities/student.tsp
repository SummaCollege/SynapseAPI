import "@typespec/openapi3";
import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Student, iemand die (onderwijs)aanbod afneemt
 */
@extension("x-tags", #["Studenten"])
@summary("Student")
model Student is Persoon {
    // groepen?: Groep[];

    @oneOf
    inschrijvingen?: ResourceRef[] | Inschrijving[];
}
