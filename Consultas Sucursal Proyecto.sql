-- Consultas Sucursal

-- Primera Consulta
-- Descripci�n: Clientes atentidos desde mediados de Abril hasta mediados de Mayo
select distinct c.nombre+' '+c.apellido as [Clientes Abril-Mayo] from Cliente c 
join Factura f on c.c�dula=f.c�dulaCliente where f.fecha between '2020-04-15' and '2020-05-15'

-- Segunda Consulta
-- Descripci�n: Total por Empleado de pago de remuneraciones totales mayores a 2000
select e.nombre+' '+e.apellido as [Empleado], sum(p.monto) as [Total Pagos] 
from Empleado e join PagoEmpleado p on e.c�dula=p.c�dulaEmpleado 
group by e.nombre+' '+e.apellido having sum(p.monto)>2000 order by sum(p.monto) asc

-- Tercera Consulta
-- Descripci�n: Total de pagos en remuneraciones a los empleados
select sum(p.monto) as [Total Pagos] from Empleado e join 
PagoEmpleado p on e.c�dula=p.c�dulaEmpleado 

-- Cuarta Consulta
-- Descripci�n: Cantidad pagada por cada ingrediente en total en el ultimo mes trabajado de 2020
select i.descripci�n as [Ingrediente], sum(ci.precio*ci.cantidad) as 
[Total por Ingredientes / �ltimo mes] from CompraIngrediente ci join Ingrediente i 
on ci.c�digoIngrediente=i.c�digo where month(ci.fechaAdquisici�n)=5 
group by i.descripci�n order by sum(ci.precio*ci.cantidad) desc

-- Quinta Consulta
-- Descripci�n: La diferencia entre el costo de frabricaci�n y el precio de venta
select p.nombre as [Producto], p.precio-(ipr.cantidadIngrediente*ci.precio) 
as [Diferencia: Venta-Elaboraci�n] from ((Producto p join IngredienteProducto ipr 
on p.c�digo=ipr.c�digoProducto) join Ingrediente i on i.c�digo=ipr.c�digoIngrediente) 
join CompraIngrediente ci on ci.c�digoIngrediente=i.c�digo group by p.nombre, p.precio, ipr.cantidadIngrediente, ci.precio

-- Sexta Consulta
-- Descripci�n: Los tres mayores pagos totales por cada ingrediente
select top 3 i.descripci�n as [Ingrediente], sum(ci.precio*ci.cantidad) as [Total 1er Trimestre] 
from CompraIngrediente ci join Ingrediente i on ci.c�digoIngrediente=i.c�digo 
where month(ci.fechaAdquisici�n) in (1,2,3,4) group by i.descripci�n 
order by sum(ci.cantidad*ci.precio) desc

-- S�ptima Consulta
-- Descripci�n: Visualizar los combos por su precio y verificar su cantidad de productos
select top 4 c.descripci�n as [Nombre], sum(pc.cantidadProducto) 
as [Productos en Combo], precio as [Precio] 
from Combo c join ProductoCombo pc on c.c�digo=pc.c�digoCombo 
group by c.descripci�n, pc.cantidadProducto, c.precio order by c.precio desc

-- Octava Consulta
-- Descripci�n: Los clientes con el producto que m�s caro que han comprado seg�n la fecha, precio  ordenadode mayor a menor y fecha crocnol�gicamente
select c.nombre, p.nombre, p.precio, f.fecha 
from ((Cliente c join Factura f on c.c�dula=f.c�dulaCliente) join DetalleFactura d 
on d.c�digoFactura=f.n�mero) join Producto p on p.c�digo=d.c�digoProducto 
group by c.nombre, p.nombre, p.precio, f.fecha order by p.precio desc, f.fecha asc

-- EXTRA
-- Descripci�n: Visualizar el contenido de los combos
select c.descripci�n, p.nombre from ProductoCombo pc join Producto p
on pc.c�digoProducto=p.c�digo join Combo c on 
c.c�digo=pc.c�digoCombo group by c.descripci�n, p.nombre

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

-- D�cima Consulta
-- Descripci�n: Consultar cuales son los 5 combos m�s pedidos, ordenados seg�n sea su costo mayor
select top 5 c.descripci�n as [Nombre], sum(df.cantidadCombo*c.precio) as 
[Total] from DetalleFactura df join Combo c on df.c�digoCombo=c.c�digo 
group by c.descripci�n, c.precio