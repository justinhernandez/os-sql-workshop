

-- settings init

DROP TABLE IF EXISTS _populate_settings;

CREATE TEMP TABLE _populate_settings AS 

  SELECT 250000 AS parents_to_generate,
         3 AS child_age_minimum,
         -- x amount of parents
         3 AS child_limit,
         -- x amount of children
         1 AS enrollment_min,
         20 AS enrollment_max;


-- parents

TRUNCATE lnl_parents;

WITH base_rows AS (

  SELECT lnl_random_parent_name() AS name,
         lnl_random_timestamptz('2021-01-01 12:0:01', now()) AS created_at,
         lnl_random_parent_referer() AS parent_referer
    FROM generate_series(1, (SELECT parents_to_generate
                               FROM _populate_settings))

)
INSERT INTO lnl_parents(name, 
                    created_at,
                    last_login,
                    referer)
  SELECT name,
         created_at,
         -- create last_login here to ensure that last_login > created_at
         lnl_random_timestamptz(created_at, now()) AS last_login,
         parent_referer
    FROM base_rows
 ORDER
     BY random();




-- learners

TRUNCATE lnl_learners;

WITH base_rows AS (

  -- select each parent to create learners...this will give 1 ~ 3x learners
  SELECT uid AS parent_uid,
         lnl_random_integer(1, (SELECT child_limit
                              FROM _populate_settings)) AS child_count
    FROM lnl_parents

), base_rows2 AS (

  SELECT parent_uid,
         -- generate here so each value is unique
         lnl_random_learner_name() AS name,
         lnl_random_integer((SELECT child_age_minimum
                           FROM _populate_settings), 18) AS age
    FROM base_rows b
         -- if we put lnl_random_learner_name into the left join lateral it will cache the results
         -- so we return run and set the generate series to the appropriate number of children
         LEFT JOIN LATERAL (SELECT 1
                              -- generate a random number of children per parent
                              FROM generate_series(1, b.child_count)) AS child
                                                                      ON true

)
INSERT INTO lnl_learners(parent_uid,
                     name,
                     age)
  SELECT parent_uid,
         name,
         age
    FROM base_rows2
  ORDER
      BY random();




-- enrollments

TRUNCATE lnl_enrollments;

WITH base_rows AS (

  SELECT l.uid AS learner_uid,
         p.created_at AS parent_created_at,
         lnl_random_integer((SELECT enrollment_min
                              FROM _populate_settings), 
                        (SELECT enrollment_max
                              FROM _populate_settings)) AS enrollment_count
    FROM lnl_learners l,
         lnl_parents p
   WHERE l.parent_uid = p.uid

), base_rows2 AS (

  SELECT learner_uid,
         -- generate here so each value is unique
         lnl_random_topic() AS topic,
         lnl_random_timestamptz(parent_created_at, now()) AS enrolled_at
    FROM base_rows b
         -- same generator pattern as learners
         LEFT JOIN LATERAL (SELECT 1
                              FROM generate_series(1, b.enrollment_count)) AS enrollment
                                                                           ON true

)
INSERT INTO lnl_enrollments(learner_uid,
                        topic,
                        enrolled_at)
  SELECT learner_uid,
         topic,
         enrolled_at
    FROM base_rows2
  ORDER
      BY random();
  