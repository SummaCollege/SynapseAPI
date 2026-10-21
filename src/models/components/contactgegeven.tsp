namespace Synapse.Models;

enum ContactgegevenType {
    email,
    telefoon,
    mobiel,
}

enum ContactgegevenGebruik {
    eigen,
    organisatie,
    intern,
    factuur,
}

@summary("ContactgegevenComponent")
model ContactgegevenComponent {
    type: ContactgegevenType;
    gebruik: ContactgegevenGebruik;
    waarde: string;
}
