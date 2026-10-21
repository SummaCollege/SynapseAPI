namespace Synapse.Models;

@summary("IdentifierComponent")
model IdentifierComponent<TEntiteit = Entiteit> {
    /**
     * Het systeem waarin deze entiteit met deze identifier bekend is
     */
    systeem: ExternSysteem;

    /**
     * De entiteit waarbij deze identifier hoort
     */
    entiteit?: TEntiteit;

    /**
     * De naam van de identifier (in het externe systeem, of afgeleid hiervan)
     */
    naam: string;

    /**
     * De identifier waarde (afhankelijk van systeem, altijd getoond als string)
     */
    waarde: string;
}

model HeeftIdentifiers {
    /**
     * De bij ons bekende identifiers in externe systemen
     */
    identifiers?: IdentifierComponent<never>[];
}
