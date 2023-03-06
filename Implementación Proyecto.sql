-- create database Restaurante
-- drop database Restaurante

create table Producto(
código varchar(6) not null,
nombre varchar(30),
precio float,
constraint pk_producto primary key (código)
);

create table Cliente(
cédula varchar(10) not null,
nombre varchar(30),
apellido varchar(30),
dirección varchar(30),
teléfono varchar(10),
constraint pk_cliente primary key (cédula)
);

create table Ingrediente(
código varchar(6) not null,
descripción varchar(30),
constraint pk_ingrediente primary key (código)
);

create table Proveedor(
ci_ruc varchar(10) not null,
nombre varchar(30),
apellido varchar(30),
teléfono varchar(10),
constraint pk_proveedor primary key (ci_ruc)
);

create table CompraIngrediente(
códigoIngrediente varchar(6) not null,
ci_rucProveedor varchar(10) not null,
precio float,
cantidad int,
fechaAdquisición date not null,
constraint pk_compraIngrediente primary key (códigoIngrediente, ci_rucProveedor, fechaAdquisición),
constraint fk_ingredienteCompra foreign key (códigoIngrediente) references Ingrediente(código),
constraint fk_proveedorCompra foreign key (ci_rucProveedor) references Proveedor(ci_ruc)
);

create table Factura(
número varchar(15) not null,
cédulaCliente varchar(10) not null,
fecha date,
constraint pk_factura primary key (número),
constraint fk_facturaCliente foreign key (cédulaCliente) references Cliente(cédula)
);

create table Empleado(
cédula varchar(10) not null,
nombre varchar(30),
apellido varchar(30),
teléfono varchar(10),
cargo varchar(20),
constraint pk_empleado primary key (cédula)
);

create table PagoEmpleado(
cédulaEmpleado varchar(10) not null,
fecha date not null,
monto float,
constraint pk_pagoEmpleado primary key (cédulaEmpleado, fecha),
constraint fk_cédulaEmpleado foreign key (cédulaEmpleado) references Empleado(cédula)
);

create table Combo(
código varchar(6) not null,
descripción varchar(30),
precio float,
constraint pk_combo primary key (código)
);

create table Equipo(
código varchar(6) not null,
descripción varchar(30),
precio float,
fechaAdquisición date,
constraint pk_equipo primary key (código)
);

create table DetalleFactura(
códigoFactura varchar(15) not null,
códigoProducto varchar(6) not null,
cantidadProducto int,
códigoCombo varchar(6) not null,
cantidadCombo int,
constraint pk_detalleFactura primary key (códigoFactura, códigoProducto, códigoCombo),
constraint fk_facturaDetalle foreign key (códigoFactura) references Factura(número),
constraint fk_productoDetalle foreign key (códigoProducto) references Producto(código),
constraint fk_comboDetalle foreign key (códigoCombo) references Combo(código)
);

create table IngredienteProducto(
códigoProducto varchar(6) not null,
códigoIngrediente varchar(6) not null,
fechaAdquisiciónIngrediente date not null,
cantidadIngrediente float,
constraint pk_ingredienteProducto primary key (códigoProducto, códigoIngrediente),
constraint fk_productoIP foreign key (códigoProducto) references Producto(código),
constraint fk_ingredienteIP foreign key (códigoIngrediente) references Ingrediente(código)
);

create table ProductoCombo(
códigoCombo varchar(6) not null,
códigoProducto varchar(6) not null,
cantidadProducto int,
constraint pk_productoCombo primary key (códigoProducto, códigoCombo),
constraint fk_productoPC foreign key (códigoProducto) references Producto(código),
constraint fk_comboPC foreign key (códigoCombo) references Combo(código)
);