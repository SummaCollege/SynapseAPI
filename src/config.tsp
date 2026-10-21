namespace Synapse.Config;

internal union EnvironmentNames {
    Prd: "Productie",
    Acc: "Acceptatie",
    Tst: "Test",
    Local: "Lokale ontwikkeling",
}

internal union EnvironmentServers {
    Prd: "https://api.summacollege.nl",
    Acc: "https://api-acc.summacollege.nl",
    Tst: "https://api-tst.summacollege.nl",
    Local: "https://synapse.local",
}
