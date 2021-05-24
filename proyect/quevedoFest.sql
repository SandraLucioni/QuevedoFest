

CREATE TABLE facturas (
  num_factura int NOT NULL,
  nombre_empresa varchar(20) NOT NULL,
  nif varchar(9) NOT NULL,
  direccion varchar(50) NOT NULL,
  telefono bigint DEFAULT NULL,
  web varchar(200) DEFAULT NULL,
  email varchar(20) NOT NULL,
  concepto decimal(5, 2) NOT NULL,
  forma_pago varchar(13) NOT NULL DEFAULT 'transferencia',
  fecha_vencimiento date NOT NULL,
  iban varchar(20) NOT NULL,
  aviso varchar(100),

  CONSTRAINT num_factura_pk PRIMARY KEY (num_factura),
  CONSTRAINT pago_ck CHECK (forma_pago IN ('transferencia', 'cheque'))
);


CREATE TABLE depto_publicidad (
  id_depto int NOT NULL,
  documentacion int NOT NULL,

  CONSTRAINT publicidad_pk PRIMARY KEY (id_depto),
);

CREATE TABLE proyecto (
  id_proyecto int NOT NULL,
  depto int NOT NULL,
  empresa int NOT NULL,
  distribuidora int NOT NULL,
  fechai date NOT NULL,
  fechaf date DEFAULT NULL,
  nombre varchar(10) NOT NULL,

  CONSTRAINT proyecto_pk PRIMARY KEY (id_proyecto),
  CONSTRAINT depto_fk FOREIGN KEY (depto) 
    REFERENCES depto_publicidad (id_depto)
);

CREATE INDEX proytDept_idx ON proyecto(
 depto
);


CREATE TABLE empresas_publicitarias(
  id_empresa int NOT NULL,
  factura int NOT NULL,
  proyect int NOT NULL,
  nombre varchar(20) NOT NULL,
  tipo varchar(14) NOT NULL DEFAULT 'agencia',
  web varchar(200) NOT NULL,
  direccion varchar(50) NOT NULL,
  telefono bigint DEFAULT NULL,
  socios varchar(2) NOT NULL DEFAULT 'no',
  aviso varchar(15) NOT NULL DEFAULT 'libre',

  CONSTRAINT empresa_pk PRIMARY KEY (id_empresa),
  CONSTRAINT factura_fk FOREIGN KEY (factura) 
    REFERENCES facturas (num_factura),
  CONSTRAINT proyecto_fk FOREIGN KEY (proyect) 
    REFERENCES proyecto (id_proyecto),
  CONSTRAINT tipo_ck CHECK (tipo IN ('representacion', 'agencia', 'produccion')),
  CONSTRAINT socio_ck CHECK (socios IN ('si', 'no')),
  CONSTRAINT aviso_ck CHECK (aviso IN ('libre', 'con competencia', 'cerrado', 'no disponible'))
);

CREATE INDEX empFact_idx ON empresas_publicitarias
(
 factura
);

CREATE INDEX empProy_idx ON empresas_publicitarias
(
 proyect
);

CREATE TABLE relaciones_publicas (
  id_influ int NOT NULL,
  empresa int NOT NULL,
  nombre varchar(10) NOT NULL,
  rrss varchar(9) NOT NULL DEFAULT 'instagram',
  num_seguidores varchar(5) NOT NULL,
  tematica varchar(17) NOT NULL DEFAULT 'personaje publico',
  num_publicaciones int NOT NULL DEFAULT '00',

  CONSTRAINT realaciones_pk PRIMARY KEY (id_influ),
  CONSTRAINT empresa_fk FOREIGN KEY (empresa) REFERENCES empresas_publicitarias (id_empresa),
  CONSTRAINT rrss_ck CHECK (rrss IN ('instagram', 'twitter', 'tiktok')),
  CONSTRAINT tematica_ck CHECK (tematica IN ('beauty', 'vlog', 'videogame', 'modelo', 'actor', 'viajes'))
);

CREATE INDEX relac_idx ON relaciones_publicas(
    empresa
);

CREATE TABLE producciones (
  id_producciones int NOT NULL,
  empresa int NOT NULL,
  experiencia int NOT NULL,

  CONSTRAINT producciones_pk PRIMARY KEY (id_producciones),
  CONSTRAINT empresa_fk FOREIGN KEY (empresa) REFERENCES empresas_publicitarias (id_empresa)
);

CREATE INDEX prod_idx ON producciones(
    empresa
);


CREATE TABLE distribuidora (
  id_distribuidora int NOT NULL,
  proyecto int NOT NULL,
  factura int NOT NULL,
  nombre varchar(20) NOT NULL,
  medio varchar(11) NOT NULL DEFAULT 'audiovisual',
  direccion varchar(20) NOT NULL,
  telefono bigint DEFAULT NULL,
  email varchar(20) NOT NULL,
  web varchar(20) NOT NULL,

  CONSTRAINT distribuidora_pk PRIMARY KEY (id_distribuidora),
  CONSTRAINT proyecto_fk FOREIGN KEY (proyecto) 
    REFERENCES proyecto (id_proyecto),
  CONSTRAINT factura_fk FOREIGN KEY (factura) 
    REFERENCES facturas (num_factura),
  CONSTRAINT medio_ck CHECK (medio IN ('audiovisual', 'audio', 'fotografia'))
);

CREATE INDEX distrProy_idx ON distribuidora
(
 proyecto
);

CREATE INDEX distrDist_idx ON distribuidora
(
 factura
);


CREATE TABLE medios (
  distribuidora int NOT NULL,
  tipo varchar(18) NOT NULL DEFAULT 'television',

  CONSTRAINT distribuidoraM_pk PRIMARY KEY (distribuidora),
  CONSTRAINT distribuidoraM_fk FOREIGN KEY (distribuidora) 
    REFERENCES distribuidora (id_distribuidora),
  CONSTRAINT tipo_ck CHECK (tipo IN ('television', 'radio', 'rrss', 'vallas publicitarias', 'cine'))
);

CREATE INDEX medDist_idx ON medios
(
 distribuidora
);


CREATE TABLE asociacion_consumidores (
  id_asociacion int NOT NULL,
  distribuidora int NOT NULL,

  CONSTRAINT asociacion_pk PRIMARY KEY (id_asociacion),
  CONSTRAINT distribuidoraM_fk FOREIGN KEY (distribuidora) 
    REFERENCES medios (distribuidora)
);

CREATE INDEX asociDist_idx ON asociacion_consumidores(
    distribuidora
);


CREATE TABLE estadisticas (
  id_estadist int NOT NULL,
  asociacion int NOT NULL,
  fecha date NOT NULL,
  visualizaciones int DEFAULT NULL,
  genero varchar(10) NOT NULL DEFAULT 'no binario',
  alcance int DEFAULT NULL,
  interacciones int DEFAULT NULL,
  num_contenido int DEFAULT NULL,
  seguidores int NOT NULL,
  dejar_seguir int NOT NULL,
  lugares varchar(20) NOT NULL,
  edad int NOT NULL,
  dia_masActv varchar(9) NOT NULL,
  hora_masAct int NOT NULL,

  CONSTRAINT estadistica_pk PRIMARY KEY (id_estadist),
  CONSTRAINT asociacionE_fk FOREIGN KEY (asociacion) 
    REFERENCES asociacion_consumidores (id_asociacion),
  CONSTRAINT genero_ck CHECK (genero IN ('femenino', 'masculino', 'no binario'))
);

CREATE INDEX estad_idx ON estadisticas(
    asociacion
);


CREATE TABLE depto_marketing (
  id_depto int NOT NULL,
  nombre varchar(10) NOT NULL,
  estadist int NOT NULL,

  CONSTRAINT marketing_pk PRIMARY KEY (id_depto),
  CONSTRAINT estadist_fk FOREIGN KEY (estadist) 
    REFERENCES estadisticas (id_estadist)
);

CREATE INDEX markEs_idx ON depto_marketing(
    estadist
);

CREATE TABLE documentacion (
  id_documentacion int NOT NULL,
  depto int NOT NULL,
  fechai date NOT NULL,
  fechaf date,
  descripcion varchar(20) NOT NULL,

  CONSTRAINT documentacion_pk PRIMARY KEY (id_documentacion),
  CONSTRAINT deptoMk_fk FOREIGN KEY (depto) 
    REFERENCES depto_marketing (id_depto)
);

CREATE INDEX doc_idx ON documentacion(
    depto
);

----------------------

ALTER TABLE depto_publicidad
  ADD FOREIGN KEY (documentacion)
  REFERENCES documentacion ( id_documentacion );

CREATE INDEX publiDoc_idx ON depto_publicidad(
 documentacion
);


ALTER TABLE proyecto ADD FOREIGN KEY (empresa) 
  REFERENCES empresas_publicitarias (id_empresa);

CREATE INDEX proycEmp_idx ON proyecto(
 empresa
);

ALTER TABLE proyecto ADD FOREIGN KEY (empresa) 
  REFERENCES empresas_publicitarias (id_empresa);
CREATE INDEX markEs_idx ON depto_marketing(
    estadist
);


ALTER TABLE proyecto ADD FOREIGN KEY (distribuidora) 
    REFERENCES distribuidora (id_distribuidora);

CREATE INDEX proytDist_idx ON proyecto(
 distribuidora
);
CREATE INDEX proytEmp_idx ON proyecto(
 empresa
);








































