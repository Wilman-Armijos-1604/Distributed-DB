-- Consultas Sucursal

-- Primera Consulta
-- Descripción: Clientes atentidos desde mediados de Abril hasta mediados de Mayo
select distinct c.nombre+' '+c.apellido as [Clientes Abril-Mayo] from Cliente c 
join Factura f on c.cédula=f.cédulaCliente where f.fecha between '2020-04-15' and '2020-05-15'

-- Segunda Consulta
-- Descripción: Total por Empleado de pago de remuneraciones totales mayores a 2000
select e.nombre+' '+e.apellido as [Empleado], sum(p.monto) as [Total Pagos] 
from Empleado e join PagoEmpleado p on e.cédula=p.cédulaEmpleado 
group by e.nombre+' '+e.apellido having sum(p.monto)>2000 order by sum(p.monto) asc

-- Tercera Consulta
-- Descripción: Total de pagos en remuneraciones a los empleados
select sum(p.monto) as [Total Pagos] from Empleado e join 
PagoEmpleado p on e.cédula=p.cédulaEmpleado 

-- Cuarta Consulta
-- Descripción: Cantidad pagada por cada ingrediente en total en el ultimo mes trabajado de 2020
select i.descripción as [Ingrediente], sum(ci.precio*ci.cantidad) as 
[Total por Ingredientes / Último mes] from CompraIngrediente ci join Ingrediente i 
on ci.códigoIngrediente=i.código where month(ci.fechaAdquisición)=5 
group by i.descripción order by sum(ci.precio*ci.cantidad) desc

-- Quinta Consulta
-- Descripción: La diferencia entre el costo de frabricación y el precio de venta
select p.nombre as [Producto], p.precio-(ipr.cantidadIngrediente*ci.precio) 
as [Diferencia: Venta-Elaboración] from ((Producto p join IngredienteProducto ipr 
on p.código=ipr.códigoProducto) join Ingrediente i on i.código=ipr.códigoIngrediente) 
join CompraIngrediente ci on ci.códigoIngrediente=i.código group by p.nombre, p.precio, ipr.cantidadIngrediente, ci.precio

-- Sexta Consulta
-- Descripción: Los tres mayores pagos totales por cada ingrediente
select top 3 i.descripción as [Ingrediente], sum(ci.precio*ci.cantidad) as [Total 1er Trimestre] 
from CompraIngrediente ci join Ingrediente i on ci.códigoIngrediente=i.código 
where month(ci.fechaAdquisición) in (1,2,3,4) group by i.descripción 
order by sum(ci.cantidad*ci.precio) desc

-- Séptima Consulta
-- Descripción: Visualizar los combos por su precio y verificar su cantidad de productos
select top 4 c.descripción as [Nombre], sum(pc.cantidadProducto) 
as [Productos en Combo], precio as [Precio] 
from Combo c join ProductoCombo pc on c.código=pc.códigoCombo 
group by c.descripción, pc.cantidadProducto, c.precio order by c.precio desc

-- Octava Consulta
-- Descripción: Los clientes con el producto que más caro que han comprado según la fecha, precio  ordenadode mayor a menor y fecha crocnológicamente
select c.nombre, p.nombre, p.precio, f.fecha 
from ((Cliente c join Factura f on c.cédula=f.cédulaCliente) join DetalleFactura d 
on d.códigoFactura=f.número) join Producto p on p.código=d.códigoProducto 
group by c.nombre, p.nombre, p.precio, f.fecha order by p.precio desc, f.fecha asc

-- EXTRA
-- Descripción: Visualizar el contenido de los combos
select c.descripción, p.nombre from ProductoCombo pc join Producto p
on pc.códigoProducto=p.código join Combo c on 
c.código=pc.códigoCombo group by c.descripción, p.nombre

-- Novena Consulta
-- Descripción: La diferencia entre todos los costos y las ganancias, es decir, la utilidad
select -((t1.Salarios)+(t2.Equipos)+(t3.Ingredientes)-(t4.[Venta Platos])-
(t5.[Venta Combos])) as [Utilidad]  from (
select sum(pe.monto) as [Salarios] from PagoEmpleado pe) as t1, (
select sum(eq.precio) as [Equipos] from Equipo eq) as t2, (
select sum(ci.precio*ci.cantidad) as [Ingredientes] from CompraIngrediente ci) as t3, (
select sum(d.códigoProducto*p.precio) as [Venta Platos] from Producto p 
join DetalleFactura d on p.código=d.códigoProducto) as t4, (
select sum(d.códigoProducto*c.precio) as [Venta Combos] from Combo c 
join DetalleFactura d on c.código=d.códigoCombo ) as t5

-- Décima Consulta
-- Descripción: Consultar cuales son los 5 combos más pedidos, ordenados según sea su costo mayor
select top 5 c.descripción as [Nombre], sum(df.cantidadCombo*c.precio) as 
[Total] from DetalleFactura df join Combo c on df.códigoCombo=c.código 
group by c.descripción, c.precio