namespace Synapse.Models;

/**
 * Het basiscontract voor entiteiten met een unieke sleutel.
 */
model IdentifiableEntity {
    /**
     * Het unieke ID van de entiteit.
     */
    identifier: string;
}
