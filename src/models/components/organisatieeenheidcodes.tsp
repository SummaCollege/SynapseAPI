namespace Synapse.Models;

@summary("OrganisatieEenheidCodesComponent")
model OrganisatieEenheidCodesComponent {
    /**
     * Identifier (code) van het team waaraan deze entiteit gekoppeld is
     */
    @pattern("[0-9]+")
    team?: string;

    /**
     * Identifier (code) van de propositie waaraan deze entiteit gekoppeld is
     */
    @pattern("[0-9]+")
    propositie?: string;
}
