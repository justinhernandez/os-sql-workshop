

-- drop types

DROP TYPE IF EXISTS lnl_parent_referer CASCADE;

DROP TYPE IF EXISTS lnl_topic CASCADE;


-- drop functions

DROP FUNCTION IF EXISTS lnl_random_timestamptz(start_date timestamptz,
                                               end_date timestamptz);

DROP FUNCTION IF EXISTS lnl_random_integer(low integer,
                                           high integer);

DROP FUNCTION IF EXISTS lnl_random_learner_name();

DROP FUNCTION IF EXISTS lnl_random_parent_name();

DROP TYPE IF EXISTS lnl_parent_referer CASCADE;

DROP TYPE IF EXISTS lnl_topic CASCADE;


-- drop tables

DROP TABLE IF EXISTS lnl_parent_first_names;

DROP TABLE IF EXISTS lnl_parent_last_names;

DROP TABLE IF EXISTS lnl_learner_first_names;

DROP TABLE IF EXISTS lnl_parents;

DROP TABLE IF EXISTS lnl_learners;

DROP TABLE IF EXISTS lnl_enrollments;

