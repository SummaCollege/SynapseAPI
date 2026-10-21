namespace Synapse.Models;

enum AdresType {
    woon,
    factuur,
    post,
}

@summary("AdresComponent")
model AdresComponent {
    ...IsBeperktActief;

    /**
     * Type adres
     */
    type: AdresType;

    /**
     * Land
     */
    land: LandComponent;

    /**
     * Plaatsnaam
     */
    plaats?: string;

    /**
     * Straat
     */
    straat?: string;

    /**
     * Postcode
     */
    postcode?: string;

    /**
     * Huisnummer
     */
    @maxLength(20)
    huisnummer?: string;

    /**
     * Losse onderdelen huisnummer (indien beschikbaar)
     */
    huisnummerOnderdelen: HuisnummerOnderdelenComponent;

    /**
     * Indien beschikbaar/aangeleverd adresregels
     */
    adresregels: string[];
}
