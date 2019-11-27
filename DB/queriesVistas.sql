--queries para las vistas
--aseo
select p.nombre,p.apellido_paterno,p.apellido_materno,p.turno,a.fecha,am.nombre
from personal as p,aseo_personal as ap,aseo as a,ambiente as am 
where p.id_personal = ap.id_personal
	and a.id_aseo = ap.id_aseo
	and a.id_ambiente =  am.id_ambiente;


--habitaciones

SELECT a.id_ambiente, count(*) as total_articulos
	FROM ambiente as a, articulo as ar
	WHERE a.id_ambiente=ar.id_ambiente
	GROUP BY a.id_ambiente
	ORDER BY a.id_ambiente ASC;


SELECT a.id_ambiente, count(*) as total_muebles
	FROM ambiente as a, mueble as mu
	WHERE a.id_ambiente=mu.id_ambiente
	GROUP BY a.id_ambiente
	ORDER BY a.id_ambiente ASC;

SELECT a.id_ambiente, s.lugar as "lugar de sucursal",a.nombre as "nombre habitacion",
		a.disponible as estado,h.numero as "numero de habitacion",th.nombre as "tipo habitacion"
FROM ambiente as a, sucursal as s,habitacion as h,tipo_habitacion as th
WHERE  s.id_sucursal = a.id_sucursal and
		a.id_ambiente = h.id_ambiente and
		h.id_tipo_habitacion = th.id_tipo_habitacion;

SELECT * FROM articulo;


SELECT * FROM mueble;

--habitaciones especiales

SELECT a.id_ambiente, count(*) as total_articulos
	FROM ambiente as a, articulo as ar
	WHERE a.id_ambiente=ar.id_ambiente
	GROUP BY a.id_ambiente
	ORDER BY a.id_ambiente ASC;


SELECT a.id_ambiente, count(*) as total_muebles
	FROM ambiente as a, mueble as mu
	WHERE a.id_ambiente=mu.id_ambiente
	GROUP BY a.id_ambiente
	ORDER BY a.id_ambiente ASC;

SELECT a.id_ambiente, s.lugar as "lugar de sucursal", a.nombre as "nombre ambiente especial",
		a.disponible as estado, e.horario_atencion as "horario de habitacion", te.nombre as "tipo habitacion especial"
FROM ambiente as a, sucursal as s,especial as e,tipo_especial as te
where  s.id_sucursal = a.id_sucursal and
		a.id_ambiente = e.id_ambiente and
		e.id_tipo_especial = te.id_tipo_especial;

SELECT * FROM articulo;


SELECT * FROM mueble;