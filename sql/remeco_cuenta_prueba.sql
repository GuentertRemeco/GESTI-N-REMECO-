-- ============================================================
-- Remeco · pasar la cuenta de prueba a Juan.
-- Correr los pasos de a uno y mirar el resultado de cada uno.
-- El mail es metalurgicaremeco4@gmail.com
-- ============================================================

-- PASO 1 · Que tiene cargado esa cuenta hoy (solo mira, no cambia nada)
select 'ventas' as que, count(*)::text as cuantas from ventas
  where user_id = (select id from auth.users where email='metalurgicaremeco4@gmail.com')
union all
select 'viajes', count(*)::text from viajes
  where user_id = (select id from auth.users where email='metalurgicaremeco4@gmail.com');

-- PASO 2 · Borrar las ventas y los viajes de prueba.
-- Si el PASO 1 dio 0 y 0, saltealo.
delete from ventas
  where user_id = (select id from auth.users where email='metalurgicaremeco4@gmail.com');
delete from viajes
  where user_id = (select id from auth.users where email='metalurgicaremeco4@gmail.com');

-- PASO 3 · La cuenta pasa a ser de Juan
update vendedores set nombre = 'Juan'
  where user_id = (select id from auth.users where email='metalurgicaremeco4@gmail.com');

-- PASO 4 · Sacar la invitacion que quedo colgada
delete from invitaciones where email = 'metalurgicaremeco4@gmail.com' and usada_el is null;

-- PASO 5 · Como quedo
select u.email, v.nombre, v.rol, v.empresa_id
from auth.users u join vendedores v on v.user_id = u.id
order by v.empresa_id, v.rol, v.nombre;

-- ============================================================
-- Si en vez de renombrarla preferis borrarla del todo:
-- corre los PASOS 1, 2 y 4, despues esto, y por ultimo borra el
-- usuario en Authentication -> Users desde el panel de Supabase.
-- Recien ahi Juan se puede registrar de cero con ese mail.
-- ============================================================
-- delete from vendedores
--   where user_id = (select id from auth.users where email='metalurgicaremeco4@gmail.com');
