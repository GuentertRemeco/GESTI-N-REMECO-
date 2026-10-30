-- Registro de pasos: que se hizo en el programa, quien y cuando.
--
-- El asistente lee esta tabla para contestar "¿que paso hoy?" o
-- "¿que hizo Juan esta semana?".
--
-- Mientras esta tabla no exista el programa anda igual: los pasos quedan
-- guardados en el telefono (los ultimos 300). Corriendo esto, se comparten
-- entre tus dispositivos y ves tambien lo que hacen los vendedores.

create table if not exists public.actividad (
  id         bigint generated always as identity primary key,
  empresa_id uuid,
  user_id    uuid,
  fecha      timestamptz not null default now(),
  tipo       text,
  titulo     text,
  detalle    text,
  ref_id     text
);

create index if not exists actividad_empresa_fecha_idx
  on public.actividad (empresa_id, fecha desc);

alter table public.actividad enable row level security;

-- Cada uno anota con su propio usuario.
drop policy if exists actividad_insert on public.actividad;
create policy actividad_insert on public.actividad
  for insert to authenticated
  with check (user_id = auth.uid() and empresa_id = mi_empresa());

-- Y ve lo que se hizo en su empresa.
drop policy if exists actividad_select on public.actividad;
create policy actividad_select on public.actividad
  for select to authenticated
  using (empresa_id = mi_empresa());
