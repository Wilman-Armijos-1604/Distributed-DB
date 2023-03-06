-- Consultas Matriz

-- Primera Consulta
-- Descripción: Clientes atentidos en Mayo
select c.nombre+' '+c.apellido as [Clientes Mayo] from Cliente c join Factura f 
on c.cédula=f.cédulaCliente where month(f.fecha)=5

-- Segunda Consulta
-- Descripción: Total por Empleado de pago de remuneraciones ordenados de menor a mayor
select e.nombre+' '+e.apellido as [Empleado], sum(p.monto) as [Total Pagos] from 
Empleado e join PagoEmpleado p on e.cédula=p.cédulaEmpleado  
group by e.nombre+' '+e.apellido order by sum(p.monto) asc

-- Tercera Consulta
-- Descripción: Total de pagos en remuneraciones a los empleados
select sum(p.monto) as [Total Pagos] from Empleado e 
join PagoEmpleado p on e.cédula=p.cédulaEmpleado 

-- Cuarta Consulta
-- Descripción: Cantidad pagada por ingredientes en el primer trimestre de 2020
select sum(ci.precio*ci.cantidad) as [Total 1er Trimestre] 
from CompraIngrediente ci join Ingrediente i on ci.códigoIngrediente=i.código 
where month(ci.fechaAdquisición) in (1,2,3,4)

-- Quinta Consulta
-- Descripción: La diferencia entre los gastos de este año y los del año pasado en equipos
select sum(e.precio)-sum(eq.precio) as [Diferencia Equipos] from Equipo e, 
Equipo eq where year(e.fechaAdquisición)=2019 and year(eq.fechaAdquisición)=2020

-- Sexta Consulta
-- Descripción: Los tres mayores pagos totales por cada ingrediente
select top 3 i.descripción as [Ingrediente], sum(ci.precio*ci.cantidad) 
AS [Total 1er Trimestre] from CompraIngrediente ci join Ingrediente i 
on ci.códigoIngrediente=i.código where month(ci.fechaAdquisición) in (1,2,3,4) 
group by i.descripción order by sum(ci.cantidad*ci.precio) desc

-- Séptima Consulta
-- Descripción: Visualizar los combos por su precio y verificar su cantidad de productos
select top 4 c.descripción as [Nombre], sum(pc.cantidadProducto) as [Productos en Combo],
precio as [Precio] from Combo c join ProductoCombo pc on c.código=pc.códigoCombo 
group by c.descripción, pc.cantidadProducto, c.precio order by c.precio desc

-- Octava Consulta
-- Descripción: Comparar el precio de los combos juntos y por separado
select c.descripción ,c.precio-sum(p.precio) as [Diferencia] from 
(Combo c join ProductoCombo pc on c.código=pc.códigoCombo) 
join Producto p on p.código=pc.códigoProducto group by c.descripción, c.precio

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

-- Décimaa Consulta
-- Descripción: Consultar cuales son los 5 productos más pedidos, ordenados según sea su costo mayor
select top 5 p.nombre as [Nombre Producto], sum(d.cantidadCombo*p.precio) as 
[Total] from DetalleFactura d join Producto p on d.códigoProducto=p.código 
group by p.nombre, p.precio order by p.precio desc