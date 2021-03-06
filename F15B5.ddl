-- Generated by Oracle SQL Developer Data Modeler 4.1.1.888
--   at:        2015-11-21 17:45:23 CST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g




CREATE TABLE F15B5_RFE
  (
    rfe_id                 INTEGER NOT NULL ,
    explanation            VARCHAR2 (4000) NOT NULL ,
    alt_protect            VARCHAR2 (4000) NOT NULL ,
    approval_rev           DATE ,
    F15B5_status_status_id INTEGER NOT NULL ,
    F15B5_emp_emp_id       INTEGER NOT NULL
  ) ;
ALTER TABLE F15B5_RFE ADD CONSTRAINT F15B5_RFE_PK PRIMARY KEY ( rfe_id ) ;


CREATE TABLE F15B5_auth
  (
    auth_id INTEGER NOT NULL ,
    RIGHT   VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE F15B5_auth ADD CONSTRAINT F15B5_auth_PK PRIMARY KEY ( auth_id ) ;


CREATE TABLE F15B5_comm
  (
    comm_id          INTEGER NOT NULL ,
    entry_date       DATE NOT NULL ,
    comments         VARCHAR2 (4000) NOT NULL ,
    F15B5_emp_emp_id INTEGER NOT NULL ,
    F15B5_RFE_rfe_id INTEGER NOT NULL
  ) ;
ALTER TABLE F15B5_comm ADD CONSTRAINT F15B5_comm_PK PRIMARY KEY ( comm_id ) ;


CREATE TABLE F15B5_doc
  (
    doc_id           INTEGER NOT NULL ,
    filename         VARCHAR2 (4000) ,
    F15B5_RFE_rfe_id INTEGER NOT NULL ,
    mimetype         VARCHAR2 (512) ,
    charset          VARCHAR2 (512) ,
    file_blob BLOB ,
    file_com VARCHAR2 (4000) ,
    tags     VARCHAR2 (4000)
  ) ;
ALTER TABLE F15B5_doc ADD CONSTRAINT F15B5_doc_PK PRIMARY KEY ( doc_id ) ;


CREATE TABLE F15B5_emp
  (
    emp_id             INTEGER NOT NULL ,
    type               VARCHAR2 (20) NOT NULL ,
    ename              VARCHAR2 (30) NOT NULL ,
    emp_email          VARCHAR2 (100) NOT NULL ,
    emp_office         VARCHAR2 (12) ,
    emp_phone          VARCHAR2 (12) ,
    emp_status         VARCHAR2 (1) NOT NULL ,
    status_eff         DATE NOT NULL ,
    F15B5_lab_lab_id   INTEGER NOT NULL ,
    exec_dir_flag      VARCHAR2 (1) CHECK (exec_dir_flag='Y') UNIQUE ,
    lab_dir_flag       VARCHAR2 (1) ,
    admin_flag         VARCHAR2 (1) ,
    chair_flag         VARCHAR2 (1) CHECK (chair_flag='Y') UNIQUE ,
    F15B5_auth_auth_id INTEGER NOT NULL
  ) ;
ALTER TABLE F15B5_emp ADD CONSTRAINT F15B5_emp_PK PRIMARY KEY ( emp_id ) ;


CREATE TABLE F15B5_hist
  (
    hist_id          INTEGER NOT NULL ,
    F15B5_RFE_rfe_id INTEGER NOT NULL ,
    eff_date         DATE NOT NULL
  ) ;
ALTER TABLE F15B5_hist ADD CONSTRAINT F15B5_hist_PK PRIMARY KEY ( hist_id ) ;


CREATE TABLE F15B5_lab
  (
    lab_id   INTEGER NOT NULL ,
    lab_name VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE F15B5_lab ADD CONSTRAINT F15B5_lab_PK PRIMARY KEY ( lab_id ) ;


CREATE TABLE F15B5_status
  (
    status_id   INTEGER NOT NULL ,
    rfe_status  VARCHAR2 (30) NOT NULL ,
    description VARCHAR2 (500) NOT NULL
  ) ;
ALTER TABLE F15B5_status ADD CONSTRAINT F15B5_status_PK PRIMARY KEY ( status_id ) ;


CREATE TABLE F15B5_task
  (
    task_id   INTEGER NOT NULL ,
    eff_date  DATE NOT NULL ,
    task_abbr VARCHAR2 (15) NOT NULL ,
    task_desc VARCHAR2 (4000)
  ) ;
ALTER TABLE F15B5_task ADD CONSTRAINT F15B5_task_PK PRIMARY KEY ( task_id ) ;


CREATE TABLE approvers
  (
    F15B5_RFE_rfe_id INTEGER NOT NULL ,
    F15B5_emp_emp_id INTEGER NOT NULL
  ) ;


CREATE TABLE contacts
  (
    F15B5_RFE_rfe_id INTEGER NOT NULL ,
    F15B5_emp_emp_id INTEGER NOT NULL
  ) ;


CREATE TABLE rfe_task
  (
    F15B5_RFE_rfe_id   INTEGER NOT NULL ,
    F15B5_task_task_id INTEGER NOT NULL
  ) ;


ALTER TABLE F15B5_RFE ADD CONSTRAINT F15B5_RFE_F15B5_emp_FK FOREIGN KEY ( F15B5_emp_emp_id ) REFERENCES F15B5_emp ( emp_id ) ;

ALTER TABLE F15B5_RFE ADD CONSTRAINT F15B5_RFE_F15B5_status_FK FOREIGN KEY ( F15B5_status_status_id ) REFERENCES F15B5_status ( status_id ) ;

ALTER TABLE F15B5_comm ADD CONSTRAINT F15B5_comm_F15B5_RFE_FK FOREIGN KEY ( F15B5_RFE_rfe_id ) REFERENCES F15B5_RFE ( rfe_id ) ;

ALTER TABLE F15B5_comm ADD CONSTRAINT F15B5_comm_F15B5_emp_FK FOREIGN KEY ( F15B5_emp_emp_id ) REFERENCES F15B5_emp ( emp_id ) ;

ALTER TABLE F15B5_doc ADD CONSTRAINT F15B5_doc_F15B5_RFE_FK FOREIGN KEY ( F15B5_RFE_rfe_id ) REFERENCES F15B5_RFE ( rfe_id ) ;

ALTER TABLE F15B5_emp ADD CONSTRAINT F15B5_emp_F15B5_auth_FK FOREIGN KEY ( F15B5_auth_auth_id ) REFERENCES F15B5_auth ( auth_id ) ;

ALTER TABLE F15B5_emp ADD CONSTRAINT F15B5_emp_F15B5_lab_FK FOREIGN KEY ( F15B5_lab_lab_id ) REFERENCES F15B5_lab ( lab_id ) ;

ALTER TABLE F15B5_hist ADD CONSTRAINT F15B5_hist_F15B5_RFE_FK FOREIGN KEY ( F15B5_RFE_rfe_id ) REFERENCES F15B5_RFE ( rfe_id ) ;

ALTER TABLE approvers ADD CONSTRAINT approvers_F15B5_RFE_FK FOREIGN KEY ( F15B5_RFE_rfe_id ) REFERENCES F15B5_RFE ( rfe_id ) ;

ALTER TABLE approvers ADD CONSTRAINT approvers_F15B5_emp_FK FOREIGN KEY ( F15B5_emp_emp_id ) REFERENCES F15B5_emp ( emp_id ) ;

ALTER TABLE contacts ADD CONSTRAINT contacts_F15B5_RFE_FK FOREIGN KEY ( F15B5_RFE_rfe_id ) REFERENCES F15B5_RFE ( rfe_id ) ;

ALTER TABLE contacts ADD CONSTRAINT contacts_F15B5_emp_FK FOREIGN KEY ( F15B5_emp_emp_id ) REFERENCES F15B5_emp ( emp_id ) ;

ALTER TABLE rfe_task ADD CONSTRAINT rfe_task_F15B5_RFE_FK FOREIGN KEY ( F15B5_RFE_rfe_id ) REFERENCES F15B5_RFE ( rfe_id ) ;

ALTER TABLE rfe_task ADD CONSTRAINT rfe_task_F15B5_task_FK FOREIGN KEY ( F15B5_task_task_id ) REFERENCES F15B5_task ( task_id ) ;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             23
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
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0