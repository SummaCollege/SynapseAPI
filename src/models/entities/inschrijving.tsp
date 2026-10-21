import "@typespec/openapi3";
import "@typespec/openapi";
using OpenAPI;

namespace Synapse.Models;

/**
 * Type inschrijving
 */
enum InschrijvingType {
    /**
     * Opleiding
     */
    opleiding,

    /**
     * Arrangement
     */
    arrangement,

    /**
     * Cursus
     */
    cursus,

    /**
     * Leeractiviteit
     */
    leeractiviteit,
}

/**
 * Status van een inschrijving
 */
enum InschrijvingStatus {
    /**
     * Intake, mogelijk toekomstige student
     *
     * Van toepassing op inschrijving types:
     * - `opleiding`
     */
    intake, // EDUARTE: Alle statussen tot en met intake

    /**
     * Voorbereid, contract/inschrijving voorbereid
     *
     * Van toepassing op inschrijving types:
     * - `opleiding`
     */
    voorbereid, // EDUARTE: Alle statussen na intake tot en met voorlopig

    /**
     * Contract, contract is rond maar nog niet verwerkt bij de opleiding
     *
     * Van toepassing op inschrijving types:
     * - `opleiding`
     */
    contract, // EDUARTE: Alle statussen na voorlopig TOT definitief

    /**
     * Ingeschreven, inschrijving is verwerkt en actief gedurende de looptijd
     *
     * Van toepassing op inschrijving types:
     * - `opleiding`
     */
    #deprecated "Wordt vanaf API v1 `actief`"
    ingeschreven, // EDUARTE: Alle statussen vanaf definitief tot beeindigd

    /**
     * Actief, inschrijving is verwerkt en actief gedurende de looptijd
     *
     * Van toepassing op inschrijving types:
     * - `opleiding`
     * - `arrangement`
     * - `cursus`
     * - `leeractiviteit`
     */
    actief, // EDUARTE: Alle statussen vanaf definitief tot beeindigd

    /**
     * Beeindigd, inschrijving is beeindigd maar nog wel actief gedurende de looptijd
     *
     * Van toepassing op inschrijving types:
     * - `opleiding`
     * - `arrangement`
     * - `cursus`
     * - `leeractiviteit`
     */
    beeindigd, // EDUARTE: Beeindigd en andere statussen die einde opleiding betkekenen
}

/**
 * Inschrijving, een inschrijving is de (contractuele) relatie tussen een student en een (onderwijs)aanbod.
 */
@extension("x-tags", #["Inschrijvingen"])
@summary("Inschrijving")
model Inschrijving extends IdentifiableEntity {
    ...IsBeperktActief;

    /**
     * Type aanbod
     */
    type: InschrijvingType;

    /**
     * Huidige status
     */
    status: InschrijvingStatus;

    /**
     * De aan de inschrijving verbonden student
     */
    @oneOf
    student?: ResourceRef | Student;

    /**
     * Het aan de inschrijving verbonden (onderwijs)aanbod
     */
    @oneOf
    aanbod: ResourceRef | OpleidingAanbod; //| Opleiding; // Toekomstig: | Arrangement | Cursus | Leeractiviteit;
}
