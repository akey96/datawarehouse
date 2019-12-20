-- 1ra pregunta
-- 1ra pregunta
select reservas_2017.nombre,reservas_2017.lugar as lugar_hotel, reservas_2017.cantidad as reservas2017,
		reservas_2018.cantidad as reservas2018, reservas_2019.cantidad as reservas2019
from ( select s.nombre, count(*) as cantidad ,s.lugar 
		from reserva r,ambiente a, habitacion h, sucursal s
		where r.id_ambiente = a.id_ambiente and
			a.id_ambiente = h.id_ambiente and
			a.id_sucursal = s.id_sucursal and
			r.fecha >= '2017-01-01' and r.fecha < '2018-01-01'
		group by (s.nombre,s.lugar)) as reservas_2017,
		( select s.nombre, count(*) as cantidad ,s.lugar 
		from reserva r,ambiente a, habitacion h, sucursal s
		where r.id_ambiente = a.id_ambiente and
			a.id_ambiente = h.id_ambiente and
			a.id_sucursal = s.id_sucursal and
			r.fecha >= '2018-01-01' and r.fecha < '2019-01-01'
		group by (s.nombre, s.lugar)) as reservas_2018,
		( select s.nombre, count(*) as cantidad,s.lugar 
		from reserva r,ambiente a, habitacion h, sucursal s
		where r.id_ambiente = a.id_ambiente and
			a.id_ambiente = h.id_ambiente and
			a.id_sucursal = s.id_sucursal and
			r.fecha >= '2019-01-01' and r.fecha < '2020-01-01'
		group by (s.nombre, s.lugar)) as reservas_2019
		
where reservas_2017.nombre = reservas_2018.nombre and
		reservas_2018.nombre = reservas_2019.nombre
	

	


-- 2da pregunta 
select  datos_2017.nombre as paquete_turistico, datos_2017.cantidad as demanda_2017, datos_2018.cantidad as demanda_2018, datos_2019.cantidad as demanda_2019
from 
    (select pt.nombre, count(*) as cantidad
        from hospedaje h, paquete_turistico pt, reserva r
        where h.id_paquete_turistico = pt.id_paquete_turistico AND
            h.id_reserva = r.id_reserva and
            r.fecha >= '2017-01-01' and r.fecha < '2018-01-01'
        group by pt.nombre) as datos_2017,
    
    (select pt.nombre, count(*) as cantidad
        from hospedaje h, paquete_turistico pt, reserva r
        where h.id_paquete_turistico = pt.id_paquete_turistico AND
            h.id_reserva = r.id_reserva and
            r.fecha >= '2018-01-01' and r.fecha < '2019-01-01'
        group by pt.nombre) as datos_2018,

    (select pt.nombre, count(*) as cantidad
        from hospedaje h, paquete_turistico pt, reserva r
        where h.id_paquete_turistico = pt.id_paquete_turistico AND
            h.id_reserva = r.id_reserva and
            r.fecha >= '2019-01-01' and r.fecha < '2020-01-01'
        group by pt.nombre) as datos_2019

where datos_2017.nombre = datos_2018.nombre
    and datos_2018.nombre = datos_2019.nombre;

-- 3ra pregunta 
select p.id_pago, p.fecha as fecha_pago, p.monto as monto_pago, 
		r.fecha as fecha_reserva,
		c.nombre as nombre_cliente, c.apellido_paterno, c.apellido_materno,
		a.nombre as nombre_ambiente,
		s.lugar as lugar_hotel, s.nombre as nombre_hotel
from sucursal s, ambiente a, reserva r, pago p, cliente c
where  
p.fecha >= '2017-01-01' and p.fecha < '2019-01-01' and
s.id_sucursal = a.id_ambiente and
a.id_ambiente = r.id_ambiente and
r.id_reserva = p.id_reserva and
r.id_cliente = c.id_cliente