-- ============================================================
-- Remeco · silos de 100 a 200 tn: medidas y precios del presupuesto.
--
-- Carga el diametro, la altura, las filas de chapa y el precio de los
-- silos de 100, 120, 140, 150, 175 y 200 tn, tomados del presupuesto
-- que paso Gerardo. NO toca ningun otro modelo, asi que se puede correr
-- sin pisar precios que hayas cambiado en Configuracion.
--
-- Precios: son los del presupuesto, a dolar $1.485 e IVA 10,5%
-- incluido. Se guardan en dolares (precio / 1485), por eso 120tn y 140tn
-- tienen decimales. Si cambia el dolar, el precio en pesos se mueve solo.
--
-- Tambien arregla la descripcion del 100tn, que tenia pegado por error
-- el texto del 120tn.
--
-- Efecto en el flete: con el diametro cargado, 120 y 140 tn pasan al
-- grupo de 5,20 mts junto con 80 y 100, y 150, 175 y 200 tn forman el
-- grupo nuevo de 6,20 mts. Antes figuraban "sin medida".
-- ============================================================

insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','100tn',6572,13,'{"35": "Silo base aérea 100 tn, diámetro 5.20 mts, cono 35° altura 8 mts, 5 filas de chapas de alto y 5 chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-100tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=coalesce(excluded.imagen,precios.imagen), orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','120tn',7559.6,14,'{"35": "Silo base aérea 120 tn, diámetro 5.20 mts, cono 35° altura 9 mts, 6 filas de chapas de alto y 5 chapas de 11 pies la vuelta"}'::jsonb,'img/silos/aereo-120tn.jpg')
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=coalesce(excluded.imagen,precios.imagen), orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','140tn',10149.5,15,'{"35": "Silo base aérea 140 tn, diámetro 5.20 mts, altura 10 mts, 7 filas de chapas de alto y 5 chapas de 11 pies la vuelta"}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=coalesce(excluded.imagen,precios.imagen), orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','150tn',12800,16,'{"35": "Silo base aérea 150 tn, diámetro 6.20 mts, altura 8.6 mts, 5 filas de chapas de alto y 6 chapas de 11 pies la vuelta"}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=coalesce(excluded.imagen,precios.imagen), orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','175tn',13600,17,'{"35": "Silo base aérea 175 tn, diámetro 6.20 mts, altura 9.6 mts, 6 filas de chapas de alto y 6 chapas de 11 pies la vuelta"}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=coalesce(excluded.imagen,precios.imagen), orden=excluded.orden;
insert into precios (tipo,modelo,usd,orden,descripciones,imagen) values ('aereo','200tn',15000,18,'{"35": "Silo base aérea 200 tn, diámetro 6.20 mts, altura 10.6 mts, 7 filas de chapas de alto y 6 chapas de 11 pies la vuelta"}'::jsonb,null)
on conflict (tipo,modelo) do update set usd=excluded.usd, descripciones=excluded.descripciones, imagen=coalesce(excluded.imagen,precios.imagen), orden=excluded.orden;
