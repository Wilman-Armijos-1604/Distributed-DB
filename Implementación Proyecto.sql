-- create database Restaurante
-- drop database Restaurante

create table Producto(
c�digo varchar(6) not null,
nombre varchar(30),
precio float,
constraint pk_producto primary key (c�digo)
);

create table Cliente(
c�dula varchar(10) not null,
nombre varchar(30),
apellido varchar(30),
direcci�n varchar(30),
tel�fono varchar(10),
constraint pk_cliente primary key (c�dula)
);

create table Ingrediente(
c�digo varchar(6) not null,
descripci�n varchar(30),
constraint pk_ingrediente primary key (c�digo)
);

create table Proveedor(
ci_ruc varchar(10) not null,
nombre varchar(30),
apellido varchar(30),
tel�fono varchar(10),
constraint pk_proveedor primary key (ci_ruc)
);

create table CompraIngrediente(
c�digoIngrediente varchar(6) not null,
ci_rucProveedor varchar(10) not null,
precio float,
cantidad int,
fechaAdquisici�n date not null,
constraint pk_compraIngrediente primary key (c�digoIngrediente, ci_rucProveedor, fechaAdquisici�n),
constraint fk_ingredienteCompra foreign key (c�digoIngrediente) references Ingrediente(c�digo),
constraint fk_proveedorCompra foreign key (ci_rucProveedor) references Proveedor(ci_ruc)
);

create table Factura(
n�mero varchar(15) not null,
c�dulaCliente varchar(10) not null,
fecha date,
constraint pk_factura primary key (n�mero),
constraint fk_facturaCliente foreign key (c�dulaCliente) references Cliente(c�dula)
);

create table Empleado(
c�dula varchar(10) not null,
nombre varchar(30),
apellido varchar(30),
tel�fono varchar(10),
cargo varchar(20),
constraint pk_empleado primary key (c�dula)
);

create table PagoEmpleado(
c�dulaEmpleado varchar(10) not null,
fecha date not null,
monto float,
constraint pk_pagoEmpleado primary key (c�dulaEmpleado, fecha),
constraint fk_c�dulaEmpleado foreign key (c�dulaEmpleado) references Empleado(c�dula)
);

create table Combo(
c�digo varchar(6) not null,
descripci�n varchar(30),
precio float,
constraint pk_combo primary key (c�digo)
);

create table Equipo(
c�digo varchar(6) not null,
descripci�n varchar(30),
precio float,
fechaAdquisici�n date,
constraint pk_equipo primary key (c�digo)
);

create table DetalleFactura(
c�digoFactura varchar(15) not null,
c�digoProducto varchar(6) not null,
cantidadProducto int,
c�digoCombo varchar(6) not null,
cantidadCombo int,
constraint pk_detalleFactura primary key (c�digoFactura, c�digoProducto, c�digoCombo),
constraint fk_facturaDetalle foreign key (c�digoFactura) references Factura(n�mero),
constraint fk_productoDetalle foreign key (c�digoProducto) references Producto(c�digo),
constraint fk_comboDetalle foreign key (c�digoCombo) references Combo(c�digo)
);

create table IngredienteProducto(
c�digoProducto varchar(6) not null,
c�digoIngrediente varchar(6) not null,
fechaAdquisici�nIngrediente date not null,
cantidadIngrediente float,
constraint pk_ingredienteProducto primary key (c�digoProducto, c�digoIngrediente),
constraint fk_productoIP foreign key (c�digoProducto) references Producto(c�digo),
constraint fk_ingredienteIP foreign key (c�digoIngrediente) references Ingrediente(c�digo)
);

create table ProductoCombo(
c�digoCombo varchar(6) not null,
c�digoProducto varchar(6) not null,
cantidadProducto int,
constraint pk_productoCombo primary key (c�digoProducto, c�digoCombo),
constraint fk_productoPC foreign key (c�digoProducto) references Producto(c�digo),
constraint fk_comboPC foreign key (c�digoCombo) references Combo(c�digo)
);