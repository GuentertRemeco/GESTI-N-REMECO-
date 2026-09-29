-- ============================================================
-- Remeco · lista de precios completa. Se puede correr mas de una vez.
-- 1) las tablas  2) los permisos  3) los parametros  4) los modelos
-- ============================================================

create table if not exists precios (
  id bigserial primary key,
  tipo text not null,
  modelo text not null,
  usd numeric not null default 0,
  descripciones jsonb,
  imagen text,
  orden int default 0,
  activo boolean default true
);
create table if not exists config (clave text primary key, valor text);
alter table precios add column if not exists descripciones jsonb;
alter table precios add column if not exists imagen text;
create unique index if not exists precios_unico on precios (tipo, modelo);

alter table precios enable row level security;
alter table config  enable row level security;
drop policy if exists precios_leer on precios;
create policy precios_leer on precios for select to authenticated using (true);
drop policy if exists precios_tocar on precios;
create policy precios_tocar on precios for all to authenticated
  using (mi_rol()='admin') with check (mi_rol()='admin');
drop policy if exists config_leer on config;
create policy config_leer on config for select to authenticated using (true);
drop policy if exists config_tocar on config;
create policy config_tocar on config for all to authenticated
  using (mi_rol()='admin') with check (mi_rol()='admin');

insert into config (clave,valor) values
  ('dolar','1485'),('iva','10.5'),('cono45','20'),('cono55','30'),
  ('base_fibra','1077'),('comision','0'),('entrega_dias','15')
on conflict (clave) do update set valor=excluded.valor;

-- ---------- Silos Base Aerea ----------
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','6tn',2042,1,'{"35": "Silo base aérea 6 tn, diámetro 2.10 mts, cono 35° altura 3.8 mts, 2 filas de chapas de alto y 2 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 6 tn, diámetro 2.10 mts, cono 45° altura 4.15 mts, 2 filas de chapas de alto y 2 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 6 tn, diámetro 2.10 mts, cono 55° altura 4.30 mts, 2 filas de chapas de alto y 2 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-6tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','10tn',2151,2,'{"35": "Silo base aérea 10 tn, diámetro 2.10 mts, cono 35° altura 4.8 mts, 3 filas de chapas de alto y 2 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 10 tn, diámetro 2.10 mts, cono 45° altura 5.10 mts, 3 filas de chapas de alto y 2 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 10 tn, diámetro 2.10 mts, cono 55° altura 5.30 mts, 3 filas de chapas de alto y 2 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-10tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','16tn',2696,3,'{"35": "Silo base aérea 16 tn, diámetro 3.15 mts, cono 35° altura 3.8 mts, 2 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 16 tn, diámetro 3.15 mts, cono 45° altura 4.60 mts, 2 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 16 tn, diámetro 3.15 mts, cono 55° altura 5.20 mts, 2 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-16tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','22tn',2858,4,'{"35": "Silo base aérea 22 tn, diámetro 3.15 mts, cono 35° altura 4.8 mts, 3 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 22 tn, diámetro 3.15 mts, cono 45° altura 5.60 mts, 3 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 22 tn, diámetro 3.15 mts, cono 55° altura 6.20 mts, 3 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-22tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','28tn',3394,5,'{"35": "Silo base aérea 28 tn, diámetro 3.15 mts, cono 35° altura 6 mts, 4 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 28 tn, diámetro 3.15 mts, cono 45° altura 6.60 mts, 4 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 28 tn, diámetro 3.15 mts, cono 55° altura 7.20 mts, 4 filas de chapas de alto y 3 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-28tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','30tn',3743,6,'{"35": "Silo base aérea 30 tn, diámetro 4.15 mts, cono 35° altura 4,30 mts, 2 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 30 tn, diámetro 4.15 mts, cono 45° altura 5.20 mts,30 mts, 2 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 30 tn, diámetro 4.15 mts, cono 55° altura 6.00 mts,30 mts, 2 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-30tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','40tn',4027,7,'{"35": "Silo base aérea 40 tn, diámetro 4.15 mts, cono 35° altura 5,30 mts, 3 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 40 tn, diámetro 4.15 mts, cono 45° altura 6.20 mts,30 mts, 3 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 40 tn, diámetro 4.15 mts, cono 55° altura 7.00 mts,30 mts, 3 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-40tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','50tn',4349,8,'{"35": "Silo base aérea 50 tn, diámetro 4.15 mts, cono 35° altura 6,30 mts, 4 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 50 tn, diámetro 4.15 mts, cono 45° altura 7.20 mts,30 mts, 4 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 50 tn, diámetro 4.15 mts, cono 55° altura 8.00 mts,30 mts, 4 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-50tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','60tn',4519,9,'{"35": "Silo base aérea 60 tn, diámetro 4.15 mts, cono 35° altura 7,30 mts, 5 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "45": "Silo base aérea 60 tn, diámetro 4.15 mts, cono 45° altura 8.20 mts,30 mts, 5 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta", "55": "Silo base aérea 60 tn, diámetro 4.15 mts, cono 55° altura 9.00 mts,30 mts, 5 filas de chapas de alto y 4 filas de chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-60tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','62tn',6000,10,'{"35": "Silo base aérea 62 tn, diámetro 4.60 mts, cono 35° altura 6.60 mts, 4 filas de chapa de alto y 4 filas de chapa de 12 pies la vuelta"}'::jsonb,'img/silos/aereo-62tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','72tn',6500,11,'{"35": "Silo base aérea 72 tn, diámetro 4.60 mts, cono 35° altura 7.6 mts, 5 filas de chapa de alto y 4 filas de chapa de 12 pies la vuelta"}'::jsonb,'img/silos/aereo-72tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','80tn',6100,12,'{"35": "Silo base aérea 80 tn, diámetro 5.20 mts, cono 35° altura 7 mts, 4 filas de chapas de alto y 5 chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-80tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','100tn',6572,13,'{"35": "Silo base aérea 100 tn, diámetro 5.20 mts, cono 35° altura 8 mts, 5 filas de chapas de alto y 5 chapas de 11 pies la vuelta Silo base aérea 120 tn, diámetro 5.20 mts, cono 35° altura 9 mts, 6 filas de chapas de alto y 5 chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-100tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','120tn',0,14,'{}'::jsonb,'img/silos/aereo-120tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','140tn',0,15,'{}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','150tn',0,16,'{}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','175tn',0,17,'{}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','200tn',0,18,'{}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=excluded.imagen, orden=excluded.orden;

-- ---------- Comederos / Autoconsumo (faltan descripciones y fotos) ----------
insert into precios (tipo,modelo,usd,orden) values ('comedero','2tn 12 bocas',1787,1)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','2tn 18 bocas',1798,2)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','4tn',2090,3)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','7tn',3013,4)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','7tn con Alero al medio',3242,5)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','12tn',3710,6)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','12tn con Alero al medio',4007,7)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden) values ('comedero','18tn con Alero al medio',4128,8)
on conflict (tipo,modelo) do update set usd=excluded.usd, orden=excluded.orden;

select tipo, count(*) as modelos, count(descripciones) as con_descripcion, count(imagen) as con_foto
from precios group by tipo;