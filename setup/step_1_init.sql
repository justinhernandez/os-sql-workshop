

-- database setup

-- DROP DATABASE IF EXISTS lnl_sql_demo;

-- CREATE DATABASE lnl_sql_demo;

-- USE DATABASE lnl_sql_demo;


-- table setup

DROP TABLE IF EXISTS lnl_parent_first_names;

CREATE TABLE lnl_parent_first_names (

  id               SERIAL PRIMARY KEY,
  name             TEXT NOT NULL

);

DROP TABLE IF EXISTS lnl_parent_last_names;

CREATE TABLE lnl_parent_last_names (

  id               SERIAL PRIMARY KEY,
  name             TEXT NOT NULL

);

DROP TABLE IF EXISTS lnl_learner_first_names;

CREATE TABLE lnl_learner_first_names (

  id               SERIAL PRIMARY KEY,
  name             TEXT NOT NULL

);

DROP TABLE IF EXISTS lnl_parents;

CREATE TABLE lnl_parents (

  uid              UUID DEFAULT uuid_generate_v4(),
  name             TEXT NOT NULL,
  created_at       TIMESTAMP WITH TIME ZONE NOT NULL,
  last_login       TIMESTAMP WITH TIME ZONE NOT NULL,
  referer          TEXT

);

DROP TABLE IF EXISTS lnl_learners;

CREATE TABLE lnl_learners (

  uid              UUID DEFAULT uuid_generate_v4(),
  parent_uid       UUID NOT NULL,
  name             TEXT NOT NULL,
  age              INTEGER NOT NULL

);

DROP TABLE IF EXISTS lnl_enrollments;

CREATE TABLE lnl_enrollments (

  uid              UUID DEFAULT uuid_generate_v4(),
  learner_uid      UUID NOT NULL,
  topic            TEXT NOT NULL,
  enrolled_at      TIMESTAMP WITH TIME ZONE NOT NULL

);

  