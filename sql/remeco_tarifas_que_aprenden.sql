-- ============================================================
-- Remeco · para que la tarifa de flete aprenda de las entregas.
-- Guarda los km de cada venta, que es lo que falta para medir
-- cuanto costo el flete por kilometro. Se puede correr mas de una vez.
-- ============================================================

-- Los km desde la fabrica hasta el cliente, por ruta
alter table ventas add column if not exists km numeric;

-- Las tarifas por km viven en config, asi se ajustan sin tocar el codigo.
-- Estas son las que esta usando hoy la app: la clave es cuantos silos de
-- ese tamano entran en un camion.
insert into config (clave,valor) values
  ('tarifa_km','{"1":3500,"2":2500,"3":1850,"5":1120,"6":930,"8":810,"20":800}')
on conflict (clave) do nothing;

select 'ventas con km cargado' as que, count(km)::text as cuantas from ventas
union all
select 'ventas entregadas con costo de flete', count(*)::text from ventas
  where estado='Entregado' and coalesce(costo_flete,0)>0;
