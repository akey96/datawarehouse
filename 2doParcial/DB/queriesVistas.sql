-- 1ra pregunta

-- 2da pregunta 

select pt.nombre as nombre, count(*) as cantidad2019 ,(select count(*) 
													    from hospedaje h2, paquete_turistico pt2,reserva r2
                                                        where h2.id_paquete_turistico = pt2.id_paquete_turistico AND
                                                        h2.id_reserva = r2.id_reserva and
                                                        pt2.nombre =  pt.nombre and
                                                        r2.fecha >= '2018-01-01' and r2.fecha < '2019-01-01'
                                                        group by pt2.nombre) as cantidad2018, (select count(*) 
                                                                                                from hospedaje h3, paquete_turistico pt3,reserva r3
                                                                                                where h3.id_paquete_turistico = pt3.id_paquete_turistico AND
                                                                                                h3.id_reserva = r3.id_reserva and
                                                                                                pt3.nombre =  pt.nombre and
                                                                                                r3.fecha >= '2017-01-01' and r3.fecha < '2018-01-01'
                                                                                                group by pt3.nombre) as cantidad2017
from hospedaje h, paquete_turistico pt,reserva r
where h.id_paquete_turistico = pt.id_paquete_turistico AND
h.id_reserva = r.id_reserva and
r.fecha >= '2019-01-01' and r.fecha < '2020-01-01'
group by pt.nombre

-- 3ra pregunta 
select s.lugar,sum(p.monto) from sucursal s, ambiente a, reserva r, pago p
where  
p.fecha >= '2017-01-01' and p.fecha < '2019-01-01' and
s.id_sucursal = a.id_ambiente and
a.id_ambiente = r.id_ambiente and
r.id_reserva = p.id_reserva
group by s.lugar



