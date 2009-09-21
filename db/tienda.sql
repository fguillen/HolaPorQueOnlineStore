drop table if exists camisetas;
CREATE TABLE `camisetas` (
  `id` int(11) NOT NULL auto_increment,
  `clave` varchar(255) NOT NULL,	
  `nombre` varchar(255) default 'sin nombre',
  `texto` text,
  `modelos` text,
  `fotos` text,
  `categorias` text,

  PRIMARY KEY  (`id`)
);


drop table if exists pedidos;
CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL auto_increment,
  `usuarioNombre` varchar (255) default 'sin nombre',
  `usuarioDireccion` varchar (255) default 'sin dirección',
  `usuarioTelefono` varchar (255) default 'sin telefono',
  `usuarioEmail` varchar (255) default 'sin email',
  `usuarioComentario` text default NULL,

  `fecha` datetime default NULL,
  `estado` varchar (50) default 'sin estado',
  `lineasPedido` text,

  `gastosEnvio` int(11) default 0,
  `total` int(11) default 0,

  PRIMARY KEY  (`id`)
);
