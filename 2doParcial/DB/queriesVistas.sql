-- 1ra pregunta

-- 2da pregunta 

-- 3ra pregunta 
select s.lugar,sum(p.monto) from sucursal s, ambiente a, reserva r, pago p
where  
p.fecha >= '2017-01-01' and p.fecha < '2019-01-01' and
s.id_sucursal = a.id_ambiente and
a.id_ambiente = r.id_ambiente and
r.id_reserva = p.id_reserva
group by s.lugar