-- ============================================================
-- Remeco · sugerencias de la gente que prueba el programa.
--
-- Cualquiera que use el programa toca el botoncito de la estrella y
-- deja una idea, algo que no anda o algo que se ve mal. Le llega al
-- dueño en Configuracion > Sugerencias.
--
-- Quien la escribe solo puede dejarla y verla. El dueño de la empresa
-- ve todas las de su empresa, las marca como hechas y las borra.
--
-- Mientras esta tabla no exista, lo que la gente escribe queda
-- guardado en su celular y se manda solo cuando exista.
-- ============================================================
create table if not exists public.sugerencias (
  id          bigint generated always as identity primary key,
  empresa_id  bigint,
  user_id     uuid,
  nombre      text,
  tipo        text,
  texto       text,
  pantalla    text,
  version     text,
  dispositivo text,
  estado      text not null default 'nueva',
  created_at  timestamptz not null default now()
);

create index if not exists sugerencias_empresa_idx
  on public.sugerencias (empresa_id, created_at desc);

alter table public.sugerencias enable row level security;

-- Cada uno deja la suya, con su usuario y su empresa.
drop policy if exists sugerencias_insertar on public.sugerencias;
create policy sugerencias_insertar on public.sugerencias
  for insert to authenticated
  with check (user_id = auth.uid() and empresa_id = mi_empresa());

-- El dueño ve todas las de su empresa; cada uno ve las suyas.
drop policy if exists sugerencias_leer on public.sugerencias;
create policy sugerencias_leer on public.sugerencias
  for select to authenticated
  using (empresa_id = mi_empresa() and (mi_rol() = 'admin' or user_id = auth.uid()));

-- Solo el dueño las marca como hechas o las borra.
drop policy if exists sugerencias_editar on public.sugerencias;
create policy sugerencias_editar on public.sugerencias
  for update to authenticated
  using (empresa_id = mi_empresa() and mi_rol() = 'admin')
  with check (empresa_id = mi_empresa() and mi_rol() = 'admin');

drop policy if exists sugerencias_borrar on public.sugerencias;
create policy sugerencias_borrar on public.sugerencias
  for delete to authenticated
  using (empresa_id = mi_empresa() and mi_rol() = 'admin');
