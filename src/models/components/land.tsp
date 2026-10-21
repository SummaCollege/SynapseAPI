namespace Synapse.Models;

@summary("LandComponent")
model LandComponent {
    /**
     * ISO 3166-1 alpha-3 landcode
     */
    @minLength(3)
    @maxLength(3)
    @pattern("[A-Z]")
    code: string;

    /**
     * Nederlandse landnaam
     */
    naam: string;

    /**
     * Engelse landnaam
     */
    engelseNaam: string;
}
