namespace Synapse.Models;

@summary("ActiefComponent")
model ActiefComponent {
    /**
     * Item is actief vanaf deze datum (inclusief)
     */
    vanaf: plainDate;

    /**
     * Item is actief tot deze datum (exclusief)
     */
    tot: plainDate;

    /**
     * Item is actief op het moment van de request
     * **LET OP:**
     * Dit is een helper waarde met beperkte betrouwbaarheid.
     * - Dit wordt bepaald op moment van ophalen bij het bronsysteem
     * - In **sommige** gevallen wordt de tijd mee in overweging genomen,
     *   wil je puur op datum weten of een item actief is bepaal dit dan
     *   op basis van de van/tot datums.
     * - We passen caching toe waardoor deze waarde enkele minuten achter
     *   kan lopen, ook rond middernacht.
     */
    nu: boolean;
}

model IsBeperktActief {
    /**
     * Status van het item op basis van de geldigheidsdatum.
     */
    actief: ActiefComponent;
}
