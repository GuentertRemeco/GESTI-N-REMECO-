-- ============================================================
-- Remeco · permisos para que el vendedor pueda cargar, editar y
-- borrar SUS ventas (y solo las suyas, dentro de su empresa).
-- Correr esto solo si al guardar una venta la app avisa que la base
-- rechazo el permiso. Se puede correr mas de una vez.
-- ============================================================

-- Cada venta queda atada a la empresa del que la carga
alter table ventas add column if not exists empresa_id bigint;
update ventas v set empresa_id = d.empresa_id
  from vendedores d where d.user_id = v.user_id and v.empresa_id is null;

alter table ventas enable row level security;

-- Cargar: solo a su nombre y en su empresa
drop policy if exists ventas_insertar on ventas;
create policy ventas_insertar on ventas for insert to authenticated
  with check (user_id = auth.uid() and empresa_id = mi_empresa());

-- Editar: lo suyo. El dueno tambien puede tocar lo de su empresa.
drop policy if exists ventas_editar on ventas;
create policy ventas_editar on ventas for update to authenticated
  using      (empresa_id = mi_empresa() and (user_id = auth.uid() or mi_rol() = 'admin'))
  with check (empresa_id = mi_empresa() and (user_id = auth.uid() or mi_rol() = 'admin'));

-- Borrar: lo suyo. El dueno tambien.
drop policy if exists ventas_borrar on ventas;
create policy ventas_borrar on ventas for delete to authenticated
  using (empresa_id = mi_empresa() and (user_id = auth.uid() or mi_rol() = 'admin'));


-- Leer: cada uno lo suyo. El dueno ve todas las ventas de SU empresa,
-- incluidas las que cargaron sus vendedores.
drop policy if exists ventas_leer_empresa on ventas;
create policy ventas_leer_empresa on ventas for select to authenticated
  using (empresa_id = mi_empresa() and (user_id = auth.uid() or mi_rol() = 'admin'));

-- Que quedo: una fila por politica
select polname as politica,
       case polcmd when 'r' then 'leer' when 'a' then 'cargar'
                   when 'w' then 'editar' when 'd' then 'borrar' else 'todo' end as para
from pg_policy where polrelid = 'ventas'::regclass order by polname;
