namespace Synapse.Models;

@summary("HuisnummerOnderdelenComponent")
model HuisnummerOnderdelenComponent {
    /**
     * Basis huisnummer
     */
    basis: string;

    /**
     * Voorvoegsel huisnummer (indien gescheiden beschikbaar uit bron)
     */
    prefix: string;

    /**
     * Achtervoegsel huisnummer (indien gescheiden beschikbaar uit bron)
     */
    suffix: string;
}
