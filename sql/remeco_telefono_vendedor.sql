-- ============================================================
-- Remeco · el telefono de cada vendedor.
-- Es el que sale en el presupuesto que ese vendedor manda, para que
-- el cliente lo llame a el. Se puede correr mas de una vez.
-- ============================================================

alter table vendedores   add column if not exists telefono text;
alter table invitaciones add column if not exists telefono text;

-- El de la fabrica, para el dueno (cambialo si queres otro)
update vendedores set telefono = '2954201051'
  where rol = 'admin' and telefono is null;

select v.nombre, v.rol, coalesce(v.telefono,'SIN TELEFONO') as telefono, v.empresa_id
from vendedores v order by v.empresa_id, v.rol, v.nombre;
