

-- database setup

DROP DATABASE IF EXISTS os_sql_demo;

CREATE DATABASE os_sql_demo;

USE DATABASE os_sql_demo;


-- table setup

DROP TABLE IF EXISTS parent_first_names;

CREATE TABLE parent_first_names (

  id               SERIAL PRIMARY KEY,
  name             TEXT

);

DROP TABLE IF EXISTS parent_last_names;

CREATE TABLE parent_last_names (

  id               SERIAL PRIMARY KEY,
  name             TEXT

);

DROP TABLE IF EXISTS learner_first_names;

CREATE TABLE learner_first_names (

  id               SERIAL PRIMARY KEY,
  name             TEXT

);

DROP TABLE IF EXISTS parents;

CREATE TABLE parents (

  uid              UUID DEFAULT uuid_generate_v4(),
  name             TEXT NOT NULL,
  created_at       TIMESTAMP WITH TIME ZONE NOT NULL,
  last_login       TIMESTAMP WITH TIME ZONE NOT NULL,
  referer          TEXT

);

DROP TABLE IF EXISTS learners;

CREATE TABLE learners (

  uid              UUID DEFAULT uuid_generate_v4(),
  parent_uid       UUID NOT NULL,
  name             TEXT NOT NULL,
  age              INTEGER NOT NULL

);

DROP TABLE IF EXISTS enrollments;

CREATE TABLE enrollments (

  uid              UUID DEFAULT uuid_generate_v4(),
  learner_uid      UUID NOT NULL,
  topic            TEXT,
  enrolled_at      TIMESTAMP WITH TIME ZONE NOT NULL

);

  