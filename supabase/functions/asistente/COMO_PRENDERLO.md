# Cómo prender la IA del asistente

Son cuatro pasos. Hacelos una vez y queda andando.

## 1. Sacar la clave

Entrá a **console.anthropic.com**, creá una cuenta y andá a **API Keys →
Create Key**. Copiá la clave que te muestra (empieza con `sk-ant-`): la muestra
una sola vez.

En **Billing** cargale saldo. Con **5 dólares** te alcanza para muchísimas
preguntas (ver el cálculo abajo).

**La clave no se la pases a nadie, ni a mí.** Va solamente en el paso 3, dentro
de tu Supabase.

## 2. Subir la función

En **Supabase → Edge Functions → Deploy a new function**, poné de nombre
`asistente` y pegá adentro todo el contenido de `index.ts` (el archivo que está
al lado de este). Dale Deploy.

## 3. Cargar la clave como secreto

En **Supabase → Edge Functions → Secrets**, agregá:

| Nombre | Valor |
|---|---|
| `ANTHROPIC_API_KEY` | la clave del paso 1 |
| `ANTHROPIC_MODEL` | `claude-haiku-5-5` (opcional, es el valor por defecto) |

## 4. Probar

Abrí el programa, andá al Asistente y preguntale cualquier cosa rara, de esas
que antes no entendía. Si contesta, ya está.

Si no está prendido, el asistente sigue funcionando como siempre — contesta lo
que sabe de memoria y no se rompe nada.

---

## Qué te sale

Se paga por lo que se usa, no por mes.

Con **Haiku 5.5** (el que viene puesto): $0,10 cada millón de tokens de entrada
y $0,50 cada millón de salida. Cada pregunta manda tus datos de resumen —
digamos unos 4.000 tokens — y la respuesta son unos 300.

- Una pregunta ≈ **$0,0005** (medio milésimo de dólar).
- 100 preguntas por mes ≈ **$0,05** por mes.
- 1.000 preguntas por mes ≈ **$0,50** por mes.

Con esos cinco dólares de saldo tenés para años al ritmo normal de uso.

Si querés que piense mejor, cambiá `ANTHROPIC_MODEL` a `claude-sonnet-5-5`
(20 veces más caro: ~$1 cada 100 preguntas) o `claude-opus-5-5` (40 veces más).
Para preguntar sobre tus ventas, Haiku alcanza de sobra.

## Importante

Las preguntas que el asistente ya sabe contestar solo — *"¿qué tengo
pendiente?"*, *"¿qué fabrico primero?"*, el nombre de un cliente o de un viaje,
el flete de un modelo — **no pasan por la IA y no cuestan nada**. Solo va a la
IA lo que el programa no entiende por sí mismo. Es a propósito: lo que ya
contesta bien y gratis, se queda gratis.
