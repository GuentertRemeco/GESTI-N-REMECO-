// Intermediario del asistente de Remeco.
//
// El programa corre en el navegador, asi que la clave de Anthropic NO puede
// estar ahi: cualquiera que abra la pagina la podria sacar y gastar el saldo.
// Por eso la pregunta pasa por aca: esta funcion guarda la clave del lado del
// servidor, y Supabase solo deja entrar a usuarios con sesion iniciada.
//
// Secretos que necesita (Supabase > Edge Functions > Secrets):
//   ANTHROPIC_API_KEY   la clave de console.anthropic.com   (obligatorio)
//   ANTHROPIC_MODEL     que modelo usar                     (opcional)
//
// Modelos y precio por millon de tokens (entrada / salida):
//   claude-haiku-5-5   $0,10 / $0,50    el mas barato, alcanza de sobra
//   claude-sonnet-5-5  $2,00 / $10,00
//   claude-opus-5-5    $4,00 / $20,00   el mas capaz
// Si no se pone ANTHROPIC_MODEL, usa Haiku 5.5.

import Anthropic from "npm:@anthropic-ai/sdk";

const MODELO = Deno.env.get("ANTHROPIC_MODEL") ?? "claude-haiku-5-5";
const CLAVE = Deno.env.get("ANTHROPIC_API_KEY");

// Topes, para que una pregunta sola no pueda gastar de mas
const MAX_PREGUNTA = 600;      // letras
const MAX_CONTEXTO = 60_000;   // letras del resumen de datos
const MAX_SALIDA = 900;        // tokens de respuesta

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const INSTRUCCIONES = `Sos el asistente de Remeco Gestion, el programa de Metalurgica Remeco,
una fabrica de silos de Colonia Menonita, La Pampa, Argentina.

Contestas sobre los datos que te paso abajo: las ventas, los viajes (fletes) y
los pasos que se hicieron en el programa. Nada mas.

Como contestar:
- En castellano rioplatense, de vos, como habla un pampeano. Nada de "tu".
- Corto y al grano. El tipo esta en el taller o arriba de la camioneta.
- Los pesos con punto de miles: $1.250.000.
- Si el dato no esta en lo que te paso, decilo derecho: "eso no lo tengo".
  Nunca inventes un numero, un cliente, una fecha ni un viaje.
- Si te preguntan algo que no tiene que ver con el negocio, decile que de eso
  no sabes y ofrecele lo que si podes mirar.
- Podes sacar cuentas con los numeros que te paso (sumas, promedios,
  comparaciones), pero siempre a partir de esos datos.`;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });

  const responder = (obj: unknown, status = 200) =>
    new Response(JSON.stringify(obj), {
      status,
      headers: { ...CORS, "Content-Type": "application/json" },
    });

  if (!CLAVE) {
    return responder({ error: "Falta cargar ANTHROPIC_API_KEY en los secretos." }, 500);
  }

  try {
    const body = await req.json();
    const pregunta = String(body?.pregunta ?? "").slice(0, MAX_PREGUNTA).trim();
    const contexto = JSON.stringify(body?.contexto ?? {}).slice(0, MAX_CONTEXTO);
    if (!pregunta) return responder({ error: "No vino ninguna pregunta." }, 400);

    const client = new Anthropic({ apiKey: CLAVE });
    const r = await client.messages.create({
      model: MODELO,
      max_tokens: MAX_SALIDA,
      output_config: { effort: "low" },
      system: INSTRUCCIONES,
      messages: [{
        role: "user",
        content: `Estos son los datos de hoy:\n\n${contexto}\n\nLa pregunta es: ${pregunta}`,
      }],
    });

    if (r.stop_reason === "refusal") {
      return responder({ respuesta: "Esa no te la puedo contestar. Preguntame algo del negocio." });
    }

    const texto = r.content
      .filter((b) => b.type === "text")
      .map((b) => (b as { text: string }).text)
      .join("\n")
      .trim();

    return responder({
      respuesta: texto || "No se me ocurrio nada para contestarte.",
      uso: r.usage,
      modelo: MODELO,
    });
  } catch (e) {
    console.error("[asistente]", e);
    return responder({ error: String((e as Error)?.message ?? e) }, 500);
  }
});
