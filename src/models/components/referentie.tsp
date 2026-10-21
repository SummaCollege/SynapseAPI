namespace Synapse.Models;

@summary("ReferentieComponent")
model ReferentieComponent {
    /**
     * De entiteit van de referentie
     */
    entiteit: Entiteit;

    /**
     * De identifier van de gerefereerde entiteit
     */
    identifier: string;
}

model HeeftReferenties {
    /**
     * Referenties naar andere entiteiten
     */
    refenties: ReferentieComponent;
}
