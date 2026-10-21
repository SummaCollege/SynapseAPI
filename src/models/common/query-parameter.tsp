import "@typespec/http";
import "@typespec/openapi";

using Http;
using OpenAPI;

namespace Synapse.Models;

/**
 * Datum filter parameters
 */
model QueryParameter {
    /**
     * Met de `q`-parameter filter je zoekresultaten op basis van **FIQL (Feed Item Query Language)**. Welke velden precies ondersteund worden, herken je in de documentatie aan de <span style="background-color: #e0f2fe; color: #0369a1; padding: 2px 6px; border-radius: 4px; font-weight: 600; font-size: 0.85em;">FIQL</span>-badge bij het betreffende attribuut.
     *
     * #### Operators
     * - `veld==waarde` / `veld!=waarde` – Gelijk aan / Niet gelijk aan
     * - `veld==null` / `veld!=null` – Is `null` / Is niet `null`
     * - `veld=gt=waarde` / `veld=ge=waarde` – Groter dan / Groter dan of gelijk *(alleen getallen/datums)*
     * - `veld=lt=waarde` / `veld=le=waarde` – Kleiner dan / Kleiner dan of gelijk *(alleen getallen/datums)*
     * - `veld=sw=waarde` – Begint met *(alleen tekst waarden)*
     * - `veld=in=(a,b)` / `veld=out=(a,b)` – In lijst / Niet in lijst
     *
     * #### Logica & Groepering
     * - `;` (AND-combinatie)
     * - `,` (OR-combinatie)
     * - `()` (Groepering, AND heeft standaard voorrang)
     *
     * #### Regels voor waarden
     * - **Quotes**: Gebruik `'` of `"` bij spaties of gereserveerde tekens (`' " ( ) [ ] ; , = ! ~ < >`). Escape gecombineerde quotes of backslashes met `\`.
     * - **Datums**: Gebruik ISO 8601-formaat (bijv. `yyyy-MM-ddTHH:mm:ssZ` of met offset `+01:00`).
     */
    @extension(
        "x-badges",
        #[#{ name: "FIQL", position: "after", color: "persian-green" }]
    )
    @query
    q?: string;
}
