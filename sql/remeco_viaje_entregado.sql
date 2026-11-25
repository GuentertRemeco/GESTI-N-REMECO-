-- Marcar un viaje como entregado.
--
-- Antes el viaje se iba solo al historial dos dias despues de su fecha. Si uno
-- se atrasaba, desaparecia de "Viajes programados" sin haberlo entregado.
-- Ahora sale de la lista solo cuando lo marcas vos, y esta columna es la que
-- guarda esa marca.
--
-- Mientras esta columna no exista, el programa igual funciona: la marca queda
-- guardada en el telefono. Corriendo esto, la marca se comparte entre todos
-- tus dispositivos y con los vendedores.

alter table public.viajes
  add column if not exists entregado boolean not null default false;

-- Los viajes de hace mas de 30 dias quedan marcados como entregados;
-- los mas recientes los marcas vos, para no dar por entregado uno que se atraso.
update public.viajes
   set entregado = true
 where entregado = false
   and fecha is not null
   and fecha < current_date - interval '30 days';
