-- Consultas Matriz

-- Primera Consulta
-- Descripci�n: Clientes atentidos en Mayo
select c.nombre+' '+c.apellido as [Clientes Mayo] from Cliente c join Factura f 
on c.c�dula=f.c�dulaCliente where month(f.fecha)=5

-- Segunda Consulta
-- Descripci�n: Total por Empleado de pago de remuneraciones ordenados de menor a mayor
select e.nombre+' '+e.apellido as [Empleado], sum(p.monto) as [Total Pagos] from 
Empleado e join PagoEmpleado p on e.c�dula=p.c�dulaEmpleado  
group by e.nombre+' '+e.apellido order by sum(p.monto) asc

-- Tercera Consulta
-- Descripci�n: Total de pagos en remuneraciones a los empleados
select sum(p.monto) as [Total Pagos] from Empleado e 
join PagoEmpleado p on e.c�dula=p.c�dulaEmpleado 

-- Cuarta Consulta
-- Descripci�n: Cantidad pagada por ingredientes en el primer trimestre de 2020
select sum(ci.precio*ci.cantidad) as [Total 1er Trimestre] 
from CompraIngrediente ci join Ingrediente i on ci.c�digoIngrediente=i.c�digo 
where month(ci.fechaAdquisici�n) in (1,2,3,4)

-- Quinta Consulta
-- Descripci�n: La diferencia entre los gastos de este a�o y los del a�o pasado en equipos
select sum(e.precio)-sum(eq.precio) as [Diferencia Equipos] from Equipo e, 
Equipo eq where year(e.fechaAdquisici�n)=2019 and year(eq.fechaAdquisici�n)=2020

-- Sexta Consulta
-- Descripci�n: Los tres mayores pagos totales por cada ingrediente
select top 3 i.descripci�n as [Ingrediente], sum(ci.precio*ci.cantidad) 
AS [Total 1er Trimestre] from CompraIngrediente ci join Ingrediente i 
on ci.c�digoIngrediente=i.c�digo where month(ci.fechaAdquisici�n) in (1,2,3,4) 
group by i.descripci�n order by sum(ci.cantidad*ci.precio) desc

-- S�ptima Consulta
-- Descripci�n: Visualizar los combos por su precio y verificar su cantidad de productos
select top 4 c.descripci�n as [Nombre], sum(pc.cantidadProducto) as [Productos en Combo],
precio as [Precio] from Combo c join ProductoCombo pc on c.c�digo=pc.c�digoCombo 
group by c.descripci�n, pc.cantidadProducto, c.precio order by c.precio desc

-- Octava Consulta
-- Descripci�n: Comparar el precio de los combos juntos y por separado
select c.descripci�n ,c.precio-sum(p.precio) as [Diferencia] from 
(Combo c join ProductoCombo pc on c.c�digo=pc.c�digoCombo) 
join Producto p on p.c�digo=pc.c�digoProducto group by c.descripci�n, c.precio

-- Novena Consulta
-- Descripci�n: La diferencia entre todos los costos y las ganancias, es decir, la utilidad
select -((t1.Salarios)+(t2.Equipos)+(t3.Ingredientes)-(t4.[Venta Platos])-
(t5.[Venta Combos])) as [Utilidad]  from (
select sum(pe.monto) as [Salarios] from PagoEmpleado pe) as t1, (
select sum(eq.precio) as [Equipos] from Equipo eq) as t2, (
select sum(ci.precio*ci.cantidad) as [Ingredientes] from CompraIngrediente ci) as t3, (
select sum(d.c�digoProducto*p.precio) as [Venta Platos] from Producto p 
join DetalleFactura d on p.c�digo=d.c�digoProducto) as t4, (
select sum(d.c�digoProducto*c.precio) as [Venta Combos] from Combo c 
join DetalleFactura d on c.c�digo=d.c�digoCombo ) as t5

-- D�cimaa Consulta
-- Descripci�n: Consultar cuales son los 5 productos m�s pedidos, ordenados seg�n sea su costo mayor
select top 5 p.nombre as [Nombre Producto], sum(d.cantidadCombo*p.precio) as 
[Total] from DetalleFactura d join Producto p on d.c�digoProducto=p.c�digo 
group by p.nombre, p.precio order by p.precio desc