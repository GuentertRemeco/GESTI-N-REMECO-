-- ============================================================
-- Remeco · quien es quien. Muestra cada usuario con su empresa y su
-- rol, para ver si a alguno le falta la empresa (sin empresa no puede
-- cargar ventas). Solo lee, no cambia nada.
-- ============================================================
select u.email,
       v.nombre,
       coalesce(v.rol,'SIN ROL')                    as rol,
       coalesce(v.empresa_id::text,'SIN EMPRESA')   as empresa,
       e.nombre                                     as empresa_nombre
from auth.users u
left join vendedores v on v.user_id = u.id
left join empresas   e on e.id = v.empresa_id
order by v.empresa_id nulls first, u.email;

-- ------------------------------------------------------------
-- Si alguno aparece SIN EMPRESA o SIN ROL, arreglalo con esto:
-- (cambiá el mail y, si hace falta, el numero de empresa y el rol)
-- ------------------------------------------------------------
-- insert into vendedores (user_id, nombre, empresa_id, rol)
-- select id, coalesce(raw_user_meta_data->>'nombre', email), 1, 'vendedor'
-- from auth.users where email = 'elmail@delvendedor.com'
-- on conflict (user_id) do update
--   set empresa_id = excluded.empresa_id,
--       rol        = coalesce(vendedores.rol, excluded.rol);
