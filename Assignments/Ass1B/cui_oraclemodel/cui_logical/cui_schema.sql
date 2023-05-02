-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-05-02 22:59:16 MYT
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

--Group Name: T6_G58

--student id: 31110363
--student name: Wong En Xin

--student id: 31109373
--student name: Muhd Lai Razi Muhd Silmi

--student id: 31862616
--student name: Garret Yong Shern Ming

set echo on
SPOOL cui_schema_output.txt

DROP TABLE authority CASCADE CONSTRAINTS;

DROP TABLE bin CASCADE CONSTRAINTS;

DROP TABLE bin_type CASCADE CONSTRAINTS;

DROP TABLE collection_trip CASCADE CONSTRAINTS;

DROP TABLE contract CASCADE CONSTRAINTS;

DROP TABLE contract_bin CASCADE CONSTRAINTS;

DROP TABLE contract_waste_collection CASCADE CONSTRAINTS;

DROP TABLE driver CASCADE CONSTRAINTS;

DROP TABLE driver_truck CASCADE CONSTRAINTS;

DROP TABLE owner CASCADE CONSTRAINTS;

DROP TABLE prop_owner CASCADE CONSTRAINTS;

DROP TABLE property CASCADE CONSTRAINTS;

DROP TABLE street CASCADE CONSTRAINTS;

DROP TABLE truck CASCADE CONSTRAINTS;

DROP TABLE waste_collection_weight CASCADE CONSTRAINTS;

DROP TABLE waste_type CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE authority (
    auth_name          VARCHAR2(75) NOT NULL,
    auth_chief_givname VARCHAR2(100) NOT NULL,
    auth_chief_famname VARCHAR2(50) NOT NULL,
    auth_phone         CHAR(20) NOT NULL,
    auth_total_area    NUMBER(11, 3) NOT NULL,
    auth_type          CHAR(1) NOT NULL
);

ALTER TABLE authority
    ADD CONSTRAINT authority_type_chk CHECK ( auth_type IN ( 'B', 'C', 'D', 'S', 'T' )
    );

COMMENT ON COLUMN authority.auth_name IS
    'authority name';

COMMENT ON COLUMN authority.auth_chief_givname IS
    'authority chief''s given name';

COMMENT ON COLUMN authority.auth_chief_famname IS
    'authoroity chief''s familiy name';

COMMENT ON COLUMN authority.auth_phone IS
    'authority phone number';

COMMENT ON COLUMN authority.auth_total_area IS
    'authority total area governed';

COMMENT ON COLUMN authority.auth_type IS
    'authority type';

ALTER TABLE authority ADD CONSTRAINT authority_pk PRIMARY KEY ( auth_name );

CREATE TABLE bin (
    bin_rfid           NUMBER(16) NOT NULL,
    bin_supply_date    DATE NOT NULL,
    bin_replace_reason CHAR(2),
    prop_street_num    CHAR(3) NOT NULL,
    street_id          CHAR(3) NOT NULL,
    auth_name          VARCHAR2(75) NOT NULL,
    waste_type_id      CHAR(3) NOT NULL,
    bt_size            NUMBER(3) NOT NULL
);

ALTER TABLE bin
    ADD CONSTRAINT bin_replace_reason CHECK ( bin_replace_reason IN ( 'BF', 'DO', 'DP'
    , 'ST' ) );

COMMENT ON COLUMN bin.bin_rfid IS
    'bin rfid';

COMMENT ON COLUMN bin.bin_supply_date IS
    'Bin supply date';

COMMENT ON COLUMN bin.bin_replace_reason IS
    'Bin replace reason';

COMMENT ON COLUMN bin.prop_street_num IS
    'property street number ';

COMMENT ON COLUMN bin.street_id IS
    'street id';

COMMENT ON COLUMN bin.auth_name IS
    'authority name';

COMMENT ON COLUMN bin.waste_type_id IS
    'Waste type id';

COMMENT ON COLUMN bin.bt_size IS
    'Bin type size';

ALTER TABLE bin ADD CONSTRAINT bin_pk PRIMARY KEY ( bin_rfid );

CREATE TABLE bin_type (
    bt_size        NUMBER(3) NOT NULL,
    waste_type_id  CHAR(3) NOT NULL,
    bt_supply_cost NUMBER(7, 2) NOT NULL
);

COMMENT ON COLUMN bin_type.bt_size IS
    'Bin type size';

COMMENT ON COLUMN bin_type.waste_type_id IS
    'Waste type id';

COMMENT ON COLUMN bin_type.bt_supply_cost IS
    'Bin Type supply cost';

ALTER TABLE bin_type ADD CONSTRAINT bin_type_pk PRIMARY KEY ( bt_size,
                                                              waste_type_id );

CREATE TABLE collection_trip (
    ct_collect_date DATE NOT NULL,
    cont_no         CHAR(5) NOT NULL,
    waste_type_id   CHAR(3) NOT NULL,
    driver_no       CHAR(6) NOT NULL,
    truck_vin       CHAR(17) NOT NULL
);

COMMENT ON COLUMN collection_trip.ct_collect_date IS
    'Date that the waste was collected (waste collection date)';

COMMENT ON COLUMN collection_trip.cont_no IS
    'contract number';

COMMENT ON COLUMN collection_trip.waste_type_id IS
    'Waste type id';

COMMENT ON COLUMN collection_trip.driver_no IS
    'driver number ';

COMMENT ON COLUMN collection_trip.truck_vin IS
    'truck vin';

ALTER TABLE collection_trip
    ADD CONSTRAINT collection_trip_pk PRIMARY KEY ( ct_collect_date,
                                                    cont_no,
                                                    waste_type_id );

CREATE TABLE contract (
    cont_no         CHAR(5) NOT NULL,
    cont_start_date DATE NOT NULL,
    cont_end_date   DATE NOT NULL,
    auth_name       VARCHAR2(75) NOT NULL
);

COMMENT ON COLUMN contract.cont_no IS
    'contract number';

COMMENT ON COLUMN contract.cont_start_date IS
    'contract start date';

COMMENT ON COLUMN contract.cont_end_date IS
    'contract end date';

COMMENT ON COLUMN contract.auth_name IS
    'authority name';

ALTER TABLE contract ADD CONSTRAINT contract_pk PRIMARY KEY ( cont_no );

CREATE TABLE contract_bin (
    cont_no             CHAR(5) NOT NULL,
    bt_size             NUMBER(3) NOT NULL,
    waste_type_id       CHAR(3) NOT NULL,
    cb_type_supply_cost NUMBER(7, 2) NOT NULL,
    bin_rfid            NUMBER(16) NOT NULL
);

COMMENT ON COLUMN contract_bin.cont_no IS
    'contract number';

COMMENT ON COLUMN contract_bin.bt_size IS
    'Bin type size';

COMMENT ON COLUMN contract_bin.waste_type_id IS
    'Waste type id';

COMMENT ON COLUMN contract_bin.cb_type_supply_cost IS
    'Contract bin type supply cost';

COMMENT ON COLUMN contract_bin.bin_rfid IS
    'bin rfid';

CREATE UNIQUE INDEX contract_bin__idx ON
    contract_bin (
        cont_no
    ASC );

ALTER TABLE contract_bin
    ADD CONSTRAINT contract_bin_pk PRIMARY KEY ( bt_size,
                                                 waste_type_id,
                                                 cont_no );

CREATE TABLE contract_waste_collection (
    cont_no       CHAR(5) NOT NULL,
    waste_type_id CHAR(3) NOT NULL,
    cwc_cost      NUMBER(3) NOT NULL,
    cwc_frequency CHAR(1) NOT NULL
);

ALTER TABLE contract_waste_collection
    ADD CONSTRAINT wate_collection_intervals_chk CHECK ( cwc_frequency IN ( 'F', 'M',
    'W' ) );

COMMENT ON COLUMN contract_waste_collection.cont_no IS
    'contract number';

COMMENT ON COLUMN contract_waste_collection.waste_type_id IS
    'Waste type id';

COMMENT ON COLUMN contract_waste_collection.cwc_cost IS
    'contarct waste collection cost';

COMMENT ON COLUMN contract_waste_collection.cwc_frequency IS
    'Contract waste collection frequency';

ALTER TABLE contract_waste_collection ADD CONSTRAINT contract_waste_collection_pk PRIMARY
KEY ( cont_no,
                                                                                  waste_type_id
                                                                                  );

CREATE TABLE driver (
    driver_no         CHAR(6) NOT NULL,
    driver_lisence    CHAR(20) NOT NULL,
    driver_name       VARCHAR2(150) NOT NULL,
    driver_birth_date DATE NOT NULL,
    driver_taxfile_no CHAR(20) NOT NULL,
    driver_contact_no NUMBER(20) NOT NULL
);

COMMENT ON COLUMN driver.driver_no IS
    'driver number ';

COMMENT ON COLUMN driver.driver_lisence IS
    'driver lisence number';

COMMENT ON COLUMN driver.driver_name IS
    'Driver name';

COMMENT ON COLUMN driver.driver_birth_date IS
    'Driver''s birth date';

COMMENT ON COLUMN driver.driver_taxfile_no IS
    'Driver''s taxfile number';

COMMENT ON COLUMN driver.driver_contact_no IS
    'Driver''s contact number';

ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY ( driver_no );

CREATE TABLE driver_truck (
    driver_no       CHAR(6) NOT NULL,
    truck_vin       CHAR(17) NOT NULL,
    dt_approve_date DATE NOT NULL
);

COMMENT ON COLUMN driver_truck.driver_no IS
    'driver number ';

COMMENT ON COLUMN driver_truck.truck_vin IS
    'truck vin';

COMMENT ON COLUMN driver_truck.dt_approve_date IS
    'Driver''s assigned truck approved date';

ALTER TABLE driver_truck ADD CONSTRAINT driver_truck_pk PRIMARY KEY ( driver_no,
                                                                      truck_vin );

CREATE TABLE owner (
    owner_id    CHAR(20) NOT NULL,
    owner_name  VARCHAR2(150) NOT NULL,
    owner_email CHAR(100) NOT NULL,
    owner_phone CHAR(20) NOT NULL
);

COMMENT ON COLUMN owner.owner_id IS
    'owner id';

COMMENT ON COLUMN owner.owner_name IS
    'owner name';

COMMENT ON COLUMN owner.owner_email IS
    'owner email';

COMMENT ON COLUMN owner.owner_phone IS
    'owner phone ';

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_id );

CREATE TABLE prop_owner (
    prop_owner_id   NUMBER(7) NOT NULL,
    prop_street_num CHAR(3) NOT NULL,
    street_id       CHAR(3) NOT NULL,
    auth_name       VARCHAR2(75) NOT NULL,
    owner_id        CHAR(20) NOT NULL
);

COMMENT ON COLUMN prop_owner.prop_owner_id IS
    'property owner id(deed id)';

COMMENT ON COLUMN prop_owner.prop_street_num IS
    'property street number ';

COMMENT ON COLUMN prop_owner.street_id IS
    'street id';

COMMENT ON COLUMN prop_owner.auth_name IS
    'authority name';

COMMENT ON COLUMN prop_owner.owner_id IS
    'owner id';

ALTER TABLE prop_owner ADD CONSTRAINT deed_pk PRIMARY KEY ( prop_owner_id );

CREATE TABLE property (
    prop_street_num CHAR(3) NOT NULL,
    street_id       CHAR(3) NOT NULL,
    auth_name       VARCHAR2(75) NOT NULL
);

COMMENT ON COLUMN property.prop_street_num IS
    'property street number ';

ALTER TABLE property
    ADD CONSTRAINT property_pk PRIMARY KEY ( prop_street_num,
                                             street_id,
                                             auth_name );

CREATE TABLE street (
    street_id        CHAR(3) NOT NULL,
    auth_name        VARCHAR2(75) NOT NULL,
    street_name      VARCHAR2(100) NOT NULL,
    street_length    NUMBER(6, 3) NOT NULL,
    street_road_type CHAR(1) NOT NULL,
    street_num_lanes NUMBER(3) NOT NULL
);

ALTER TABLE street
    ADD CONSTRAINT street_road_type_chk CHECK ( street_road_type IN ( 'A', 'C', 'U' )
    );

COMMENT ON COLUMN street.street_id IS
    'street id';

COMMENT ON COLUMN street.auth_name IS
    'authority name';

COMMENT ON COLUMN street.street_name IS
    'street name';

COMMENT ON COLUMN street.street_length IS
    'street length ';

COMMENT ON COLUMN street.street_road_type IS
    'street road type';

COMMENT ON COLUMN street.street_num_lanes IS
    'street number of lanes';

ALTER TABLE street ADD CONSTRAINT street_pk PRIMARY KEY ( street_id,
                                                          auth_name );

CREATE TABLE truck (
    truck_vin     CHAR(17) NOT NULL,
    truck_rego_no CHAR(10) NOT NULL,
    truck_make    VARCHAR2(75) NOT NULL,
    truck_model   VARCHAR2(100) NOT NULL,
    truck_year    NUMBER(4) NOT NULL
);

COMMENT ON COLUMN truck.truck_vin IS
    'truck vin';

COMMENT ON COLUMN truck.truck_rego_no IS
    'truck rego number';

COMMENT ON COLUMN truck.truck_make IS
    'truck make';

COMMENT ON COLUMN truck.truck_model IS
    'truck model';

COMMENT ON COLUMN truck.truck_year IS
    'truck year manufactored';

ALTER TABLE truck ADD CONSTRAINT truck_pk PRIMARY KEY ( truck_vin );

CREATE TABLE waste_collection_weight (
    bin_rfid        NUMBER(16) NOT NULL,
    ct_collect_date DATE NOT NULL,
    wcw_weight      NUMBER(3) NOT NULL,
    wcw_overweight  CHAR(2) NOT NULL,
    cont_no         CHAR(5) NOT NULL,
    waste_type_id   CHAR(3) NOT NULL
);

COMMENT ON COLUMN waste_collection_weight.bin_rfid IS
    'bin frid';

COMMENT ON COLUMN waste_collection_weight.ct_collect_date IS
    'Date that the waste was collected (waste collection date)';

COMMENT ON COLUMN waste_collection_weight.wcw_weight IS
    'waste collection weight';

COMMENT ON COLUMN waste_collection_weight.wcw_overweight IS
    'Waste overweight condition (Y/N)';

COMMENT ON COLUMN waste_collection_weight.cont_no IS
    'contract number';

COMMENT ON COLUMN waste_collection_weight.waste_type_id IS
    'Waste type id';

ALTER TABLE waste_collection_weight ADD CONSTRAINT waste_collection_weight_pk PRIMARY
KEY ( bin_rfid,
                                                                                      ct_collect_date
                                                                                      )
                                                                                      ;

CREATE TABLE waste_type (
    waste_type_id          CHAR(3) NOT NULL,
    waste_type_description CHAR(50) NOT NULL
);

ALTER TABLE waste_type
    ADD CONSTRAINT waste_type_id CHECK ( waste_type_id IN ( 'G', 'GW', 'LF', 'SR' ) )
    ;

COMMENT ON COLUMN waste_type.waste_type_id IS
    'Waste type id';

COMMENT ON COLUMN waste_type.waste_type_description IS
    'Waste type description';

ALTER TABLE waste_type ADD CONSTRAINT waste_type_pk PRIMARY KEY ( waste_type_id );

ALTER TABLE contract
    ADD CONSTRAINT authority_contract FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );

ALTER TABLE street
    ADD CONSTRAINT authority_street FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );

ALTER TABLE contract_bin
    ADD CONSTRAINT bin_contract_bin FOREIGN KEY ( bin_rfid )
        REFERENCES bin ( bin_rfid );

ALTER TABLE bin
    ADD CONSTRAINT bin_type_bin FOREIGN KEY ( bt_size,
                                              waste_type_id )
        REFERENCES bin_type ( bt_size,
                              waste_type_id );

ALTER TABLE contract_bin
    ADD CONSTRAINT bin_type_contract_bin FOREIGN KEY ( bt_size,
                                                       waste_type_id )
        REFERENCES bin_type ( bt_size,
                              waste_type_id );

ALTER TABLE waste_collection_weight
    ADD CONSTRAINT bin_waste_collection_weight FOREIGN KEY ( bin_rfid )
        REFERENCES bin ( bin_rfid );

ALTER TABLE contract_waste_collection
    ADD CONSTRAINT contract_cwc FOREIGN KEY ( cont_no )
        REFERENCES contract ( cont_no );

ALTER TABLE contract_bin
    ADD CONSTRAINT contrct_bin_contract FOREIGN KEY ( cont_no )
        REFERENCES contract ( cont_no );

ALTER TABLE waste_collection_weight
    ADD CONSTRAINT ct_wcw FOREIGN KEY ( ct_collect_date,
                                        cont_no,
                                        waste_type_id )
        REFERENCES collection_trip ( ct_collect_date,
                                     cont_no,
                                     waste_type_id );

ALTER TABLE collection_trip
    ADD CONSTRAINT cwc_collection_trip FOREIGN KEY ( cont_no,
                                                     waste_type_id )
        REFERENCES contract_waste_collection ( cont_no,
                                               waste_type_id );

ALTER TABLE driver_truck
    ADD CONSTRAINT driver_driver_truck FOREIGN KEY ( driver_no )
        REFERENCES driver ( driver_no );

ALTER TABLE collection_trip
    ADD CONSTRAINT driver_truck_collection_trip FOREIGN KEY ( driver_no,
                                                              truck_vin )
        REFERENCES driver_truck ( driver_no,
                                  truck_vin );

ALTER TABLE prop_owner
    ADD CONSTRAINT owner_deed FOREIGN KEY ( owner_id )
        REFERENCES owner ( owner_id );

ALTER TABLE bin
    ADD CONSTRAINT property_bin FOREIGN KEY ( prop_street_num,
                                              street_id,
                                              auth_name )
        REFERENCES property ( prop_street_num,
                              street_id,
                              auth_name );

ALTER TABLE prop_owner
    ADD CONSTRAINT property_deed FOREIGN KEY ( prop_street_num,
                                               street_id,
                                               auth_name )
        REFERENCES property ( prop_street_num,
                              street_id,
                              auth_name );

ALTER TABLE property
    ADD CONSTRAINT street_property FOREIGN KEY ( street_id,
                                                 auth_name )
        REFERENCES street ( street_id,
                            auth_name );

ALTER TABLE driver_truck
    ADD CONSTRAINT truck_driver_truck FOREIGN KEY ( truck_vin )
        REFERENCES truck ( truck_vin );

ALTER TABLE bin_type
    ADD CONSTRAINT waste_type_bin_type FOREIGN KEY ( waste_type_id )
        REFERENCES waste_type ( waste_type_id );

ALTER TABLE contract_waste_collection
    ADD CONSTRAINT waste_type_cwc FOREIGN KEY ( waste_type_id )
        REFERENCES waste_type ( waste_type_id );


SPOOL off
--set echo off
-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             1
-- ALTER TABLE                             40
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0 