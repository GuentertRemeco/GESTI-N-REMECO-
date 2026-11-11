-- ============================================================
-- Remeco · como estan los permisos hoy. SOLO LEE, no cambia nada.
--
-- Sirve para preparar la cuenta de dueño de tu hermano: quien esta en
-- que empresa, con que rol, y que deja ver la base de los viajes, la
-- configuracion y la lista de precios.
--
-- Corre todo junto y sale una sola tabla. Mandame la foto completa.
-- ============================================================
select '1 usuarios' as seccion,
       u.email::text                                  as a,
       coalesce(v.nombre,'—')                         as b,
       coalesce(v.rol,'SIN ROL')                      as c,
       coalesce(v.empresa_id::text,'SIN EMPRESA')||' · '||coalesce(e.nombre,'—') as d
from auth.users u
left join vendedores v on v.user_id = u.id
left join empresas   e on e.id = v.empresa_id

union all
select '2 seguridad', c.relname::text,
       case when c.relrowsecurity then 'RLS prendida' else 'RLS APAGADA' end, '', ''
from pg_class c
where c.relnamespace = 'public'::regnamespace
  and c.relname in ('viajes','ventas','config','precios','vendedores','empresas','invitaciones','actividad')

union all
select '3 politicas', p.tablename::text, p.policyname::text, p.cmd::text,
       coalesce(p.qual,'')||case when p.with_check is not null then '  | CHECK: '||p.with_check else '' end
from pg_policies p
where p.schemaname = 'public'
  and p.tablename in ('viajes','config','precios','empresas','vendedores')

union all
select '4 columnas de viajes', column_name::text, data_type::text, '', ''
from information_schema.columns
where table_schema = 'public' and table_name = 'viajes'

order by 1, 2, 3;
