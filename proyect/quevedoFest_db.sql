CREATE TABLE depto_gestion
(
 id_depto      int NOT NULL,
 grupo         int NOT NULL,
 id_depto_1    int NOT NULL,
 id_estadist   int NOT NULL,
 id_asociacion int NOT NULL,
 CONSTRAINT gestion_pk PRIMARY KEY ( id_depto ),
 CONSTRAINT FK_544 FOREIGN KEY ( grupo, id_depto_1, id_estadist, id_asociacion ) REFERENCES grupos ( id_grupo, id_depto, id_estadist, id_asociacion )
);

CREATE INDEX fkIdx_545 ON depto_gestion
(
 grupo,
 id_depto_1,
 id_estadist,
 id_asociacion
);

CREATE TABLE grupos
(
 id_grupo        int NOT NULL,
 id_depto        int NOT NULL,
 id_estadist     int NOT NULL,
 id_asociacion   int NOT NULL,
 nombre_empleado varchar(20) NOT NULL,
 nombre          varchar(10) NOT NULL,
 CONSTRAINT grupo_pk PRIMARY KEY ( id_grupo, id_depto, id_estadist, id_asociacion ),
 CONSTRAINT FK_499 FOREIGN KEY ( id_depto ) REFERENCES depto_gestion ( id_depto ),
 CONSTRAINT FK_583 FOREIGN KEY ( id_depto, id_estadist, id_asociacion ) REFERENCES depto_marketing ( id_depto, id_estadist, id_asociacion )
);

CREATE INDEX fkIdx_500 ON grupos
(
 id_depto
);

CREATE INDEX fkIdx_584 ON grupos
(
 id_depto,
 id_estadist,
 id_asociacion
);


CREATE TABLE facturas
(
 num_factura       int NOT NULL,
 nombre_empresa    varchar(20) NOT NULL,
 nif               varchar(9) NOT NULL,
 direccion         varchar(50) NOT NULL,
 telefono          bigint NULL DEFAULT NULL,
 web               varchar(200) NULL DEFAULT NULL,
 email             varchar(20) NOT NULL,
 concepto          decimal(5, 2) NOT NULL,
 forma_pago        varchar(13) NOT NULL DEFAULT 'transferencia',
 fecha_vencimiento date NOT NULL,
 iban              varchar(20) NOT NULL,
 aviso             varchar(100) NULL,
 CONSTRAINT num_factura_pk PRIMARY KEY ( num_factura ),
 CONSTRAINT pago_ck CHECK ( forma_pago IN ('transferencia', 'cheque') )
);




CREATE TABLE asociacion_consumidores
(
 id_asociacion    int NOT NULL,
 id_distribuidora int NOT NULL,
 num_factura      int NOT NULL,
 id_proyecto      int NOT NULL,
 id_empresa       int NOT NULL,
 id_grupo         int NOT NULL,
 id_depto         int NOT NULL,
 id_estadist      int NOT NULL,
 id_asociacion_1  int NOT NULL,
 CONSTRAINT asociacion_pk PRIMARY KEY ( id_asociacion, id_distribuidora, num_factura, id_proyecto, id_empresa ),
 CONSTRAINT FK_559 FOREIGN KEY ( id_grupo, id_depto, id_estadist, id_asociacion_1, id_distribuidora, num_factura, id_proyecto, id_empresa ) REFERENCES grupos ( id_grupo, id_depto, id_estadist, id_asociacion, id_distribuidora, num_factura, id_proyecto, id_empresa ),
 CONSTRAINT FK_687 FOREIGN KEY ( id_distribuidora, num_factura, id_proyecto, id_empresa ) REFERENCES medios ( id_distribuidora, num_factura, id_proyecto, id_empresa )
);

CREATE INDEX fkIdx_560 ON asociacion_consumidores
(
 id_grupo,
 id_depto,
 id_estadist,
 id_asociacion_1,
 id_distribuidora,
 num_factura,
 id_proyecto,
 id_empresa
);

CREATE INDEX fkIdx_688 ON asociacion_consumidores
(
 id_distribuidora,
 num_factura,
 id_proyecto,
 id_empresa
);


CREATE TABLE depto_publicidad
(
 id_depto         int NOT NULL,
 id_documentacion int NOT NULL,
 id_depto_1       int NOT NULL,
 id_proyecto      int NOT NULL,
 id_empresa       int NOT NULL,
 id_estadist      int NOT NULL,
 id_asociacion    int NOT NULL,
 num_factura      int NOT NULL,
 id_grupo         int NOT NULL,
 id_depto_1_1     int NOT NULL,
 CONSTRAINT publicidad_pk PRIMARY KEY ( id_depto, id_documentacion, id_depto_1, id_proyecto, id_empresa, id_estadist, id_asociacion, num_factura ),
 CONSTRAINT FK_547 FOREIGN KEY ( id_grupo, id_depto_1_1, id_estadist, id_asociacion ) REFERENCES grupos ( id_grupo, id_depto, id_estadist, id_asociacion ),
 CONSTRAINT FK_574 FOREIGN KEY ( id_documentacion, id_depto_1, id_estadist, id_asociacion ) REFERENCES documentacion ( id_documentacion, id_depto, id_estadist, id_asociacion ),
 CONSTRAINT FK_599 FOREIGN KEY ( id_proyecto, id_empresa, num_factura ) REFERENCES proyecto ( id_proyecto, id_empresa, num_factura )
);

CREATE INDEX fkIdx_548 ON depto_publicidad
(
 id_grupo,
 id_depto_1_1,
 id_estadist,
 id_asociacion
);

CREATE INDEX fkIdx_575 ON depto_publicidad
(
 id_documentacion,
 id_depto_1,
 id_estadist,
 id_asociacion
);

CREATE INDEX fkIdx_600 ON depto_publicidad
(
 id_proyecto,
 id_empresa,
 num_factura
);


CREATE TABLE proyecto
(
 id_proyecto      int NOT NULL,
 id_empresa       int NOT NULL,
 num_factura      int NOT NULL,
 id_distribuidora int NOT NULL,
 id_depto         int NOT NULL,
 id_documentacion int NOT NULL,
 id_depto_1       int NOT NULL,
 distribuidora    varchar(20) NOT NULL,
 empresa          varchar(20) NOT NULL,
 fechai           date NOT NULL,
 fechaf           date NULL DEFAULT NULL,
 nombre           varchar(10) NOT NULL,
 id_proyecto_1    int NOT NULL,
 id_proyecto_1_1  int NOT NULL,
 id_estadist      int NOT NULL,
 id_asociacion    int NOT NULL,
 CONSTRAINT proyecto_pk PRIMARY KEY ( id_proyecto, id_empresa, num_factura ),
 CONSTRAINT FK_588 FOREIGN KEY ( id_depto, id_documentacion, id_depto_1, id_proyecto_1, id_empresa, id_estadist, id_asociacion, num_factura ) REFERENCES depto_publicidad ( id_depto, id_documentacion, id_depto_1, id_proyecto, id_empresa, id_estadist, id_asociacion, num_factura ),
 CONSTRAINT FK_631 FOREIGN KEY ( id_distribuidora, num_factura, id_proyecto_1_1, id_empresa ) REFERENCES distribuidora ( id_distribuidora, num_factura, id_proyecto, id_empresa ),
 CONSTRAINT FK_684 FOREIGN KEY ( id_empresa, num_factura ) REFERENCES empresas_publicitarias ( id_empresa, num_factura )
);

CREATE INDEX fkIdx_589 ON proyecto
(
 id_depto,
 id_documentacion,
 id_depto_1,
 id_proyecto_1,
 id_empresa,
 num_factura,
 id_estadist,
 id_asociacion
);

CREATE INDEX fkIdx_632 ON proyecto
(
 id_empresa,
 num_factura,
 id_distribuidora,
 id_proyecto_1_1
);

CREATE INDEX fkIdx_685 ON proyecto
(
 id_empresa,
 num_factura
);


CREATE TABLE empresas_publicitarias
(
 id_empresa   int NOT NULL,
 num_factura  int NOT NULL,
 id_proyecto  int NOT NULL,
 id_empresa_1 int NOT NULL,
 nombre       varchar(20) NOT NULL,
 tipo         varchar(14) NOT NULL DEFAULT 'agencia',
 web          varchar(200) NOT NULL,
 direccion    varchar(50) NOT NULL,
 telefono     bigint NULL DEFAULT NULL,
 socios       varchar(2) NOT NULL DEFAULT 'no',
 aviso        varchar(15) NOT NULL DEFAULT 'libre',
 CONSTRAINT empresa_pk PRIMARY KEY ( id_empresa, num_factura ),
 CONSTRAINT FK_620 FOREIGN KEY ( num_factura ) REFERENCES facturas ( num_factura ),
 CONSTRAINT FK_676 FOREIGN KEY ( id_proyecto, id_empresa_1, num_factura ) REFERENCES proyecto ( id_proyecto, id_empresa, num_factura ),
 CONSTRAINT tipo_ck CHECK ( tipo IN ('representacion', 'agencia', 'produccion') ),
 CONSTRAINT socio_ck CHECK ( socios IN ('si', 'no') ),
 CONSTRAINT aviso_ck CHECK ( aviso IN ('libre', 'con competencia', 'cerrado', 'no disponible') )
);

CREATE INDEX fkIdx_621 ON empresas_publicitarias
(
 num_factura
);

CREATE INDEX fkIdx_677 ON empresas_publicitarias
(
 num_factura,
 id_proyecto,
 id_empresa_1
);


CREATE TABLE relaciones_publicas
(
 id_influ          int NOT NULL,
 id_empresa        int NOT NULL,
 num_factura       int NOT NULL,
 empresa           varchar(20) NOT NULL,
 nombre            varchar(10) NOT NULL,
 rrss              varchar(9) NOT NULL DEFAULT 'instagram',
 num_seguidores    varchar(5) NOT NULL,
 tematica          varchar(17) NOT NULL DEFAULT 'personaje publico',
 num_publicaciones int NOT NULL DEFAULT '00',
 CONSTRAINT realaciones_pk PRIMARY KEY ( id_influ, id_empresa, num_factura ),
 CONSTRAINT FK_614 FOREIGN KEY ( id_empresa, num_factura ) REFERENCES empresas_publicitarias ( id_empresa, num_factura ),
 CONSTRAINT rrss_ck CHECK ( rrss IN ('instagram', 'twitter', 'tiktok') ),
 CONSTRAINT tematica_ck CHECK ( tematica IN ('beauty', 'vlog', 'videogame', 'modelo', 'actor', 'viajes') )
);

CREATE INDEX fkIdx_615 ON relaciones_publicas
(
 id_empresa,
 num_factura
);


CREATE TABLE producciones
(
 id_producciones int NOT NULL,
 id_empresa      int NOT NULL,
 num_factura     int NOT NULL,
 empresa         varchar(20) NOT NULL,
 nombre          varchar(20) NOT NULL,
 experiencia     int NOT NULL,
 CONSTRAINT producciones_pk PRIMARY KEY ( id_producciones, id_empresa, num_factura ),
 CONSTRAINT FK_617 FOREIGN KEY ( id_empresa, num_factura ) REFERENCES empresas_publicitarias ( id_empresa, num_factura )
);

CREATE INDEX fkIdx_618 ON producciones
(
 id_empresa,
 num_factura
);


CREATE TABLE distribuidora
(
 id_distribuidora int NOT NULL,
 num_factura      int NOT NULL,
 id_proyecto      int NOT NULL,
 id_empresa       int NOT NULL,
 nombre           varchar(20) NOT NULL,
 medio            varchar(11) NOT NULL DEFAULT 'audiovisual',
 direccion        varchar(20) NOT NULL,
 telefono         bigint NULL DEFAULT NULL,
 email            varchar(20) NOT NULL,
 web              varchar(20) NOT NULL,
 CONSTRAINT distribuidora_pk PRIMARY KEY ( id_distribuidora, num_factura, id_proyecto, id_empresa ),
 CONSTRAINT FK_627 FOREIGN KEY ( num_factura ) REFERENCES facturas ( num_factura ),
 CONSTRAINT FK_636 FOREIGN KEY ( id_proyecto, id_empresa, num_factura ) REFERENCES proyecto ( id_proyecto, id_empresa, num_factura ),
 CONSTRAINT medio_ck CHECK ( medio IN ('audiovisual', 'audio', 'fotografia') )
);

CREATE INDEX fkIdx_628 ON distribuidora
(
 num_factura
);

CREATE INDEX fkIdx_637 ON distribuidora
(
 num_factura,
 id_proyecto,
 id_empresa
);


CREATE TABLE medios
(
 id_distribuidora int NOT NULL,
 num_factura      int NOT NULL,
 id_proyecto      int NOT NULL,
 id_empresa       int NOT NULL,
 tipo             varchar(18) NOT NULL DEFAULT 'television',
 nombre           varchar(20) NOT NULL,
 CONSTRAINT distribuidora_pk PRIMARY KEY ( id_distribuidora, num_factura, id_proyecto, id_empresa ),
 CONSTRAINT FK_532 FOREIGN KEY ( id_distribuidora, num_factura, id_proyecto, id_empresa ) REFERENCES distribuidora ( id_distribuidora, num_factura, id_proyecto, id_empresa ),
 CONSTRAINT tipo_ck CHECK ( tipo IN ('television', 'radio', 'rrss', 'vallas publicitarias', 'cine') )
);

CREATE INDEX fkIdx_533 ON medios
(
 id_distribuidora,
 num_factura,
 id_proyecto,
 id_empresa
);



CREATE TABLE estadisticas
(
 id_estadist     int NOT NULL,
 id_asociacion   int NOT NULL,
 fecha           date NOT NULL,
 visualizaciones int NOT NULL,
 alcance         int NOT NULL,
 interacciones   int NOT NULL,
 num_contenido   int NOT NULL,
 seguidores      int NOT NULL,
 dejar_seguir    int NOT NULL,
 lugares         varchar(20) NOT NULL,
 edad            int NOT NULL,
 dia_masActv     int NOT NULL,
 hora_masActv    int NOT NULL,
 CONSTRAINT PK_table_174 PRIMARY KEY ( id_estadist, id_asociacion ),
 CONSTRAINT FK_648 FOREIGN KEY ( id_asociacion ) REFERENCES asociacion_consumidores ( id_asociacion )
);

CREATE INDEX fkIdx_649 ON estadisticas
(
 id_asociacion
);


CREATE TABLE depto_marketing
(
 id_depto      int NOT NULL,
 id_estadist   int NOT NULL,
 id_asociacion int NOT NULL,
 grupo_pub     int NOT NULL,
 nombre        varchar(10) NOT NULL,
 id_grupo      int NOT NULL,
 id_depto_1    int NOT NULL,
 CONSTRAINT marketing_pk PRIMARY KEY ( id_depto, id_estadist, id_asociacion ),
 CONSTRAINT FK_652 FOREIGN KEY ( id_estadist, id_asociacion ) REFERENCES estadisticas ( id_estadist, id_asociacion ),
 CONSTRAINT FK_668 FOREIGN KEY ( id_grupo, id_depto_1, id_estadist, id_asociacion ) REFERENCES grupos ( id_grupo, id_depto, id_estadist, id_asociacion )
);

CREATE INDEX fkIdx_653 ON depto_marketing
(
 id_estadist,
 id_asociacion
);

CREATE INDEX fkIdx_669 ON depto_marketing
(
 id_estadist,
 id_asociacion,
 id_grupo,
 id_depto_1
);



CREATE TABLE documentacion
(
 id_documentacion int NOT NULL,
 id_depto         int NOT NULL,
 id_estadist      int NOT NULL,
 id_asociacion    int NOT NULL,
 fechai           date NOT NULL,
 fechaf           date NULL,
 descripcion      varchar(20) NOT NULL,
 CONSTRAINT documentacion_pk PRIMARY KEY ( id_documentacion, id_depto, id_estadist, id_asociacion ),
 CONSTRAINT FK_578 FOREIGN KEY ( id_depto, id_estadist, id_asociacion ) REFERENCES depto_marketing ( id_depto, id_estadist, id_asociacion )
);

CREATE INDEX fkIdx_579 ON documentacion
(
 id_depto,
 id_estadist,
 id_asociacion
);



