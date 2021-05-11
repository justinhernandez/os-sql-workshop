

-- settings init

DROP TABLE IF EXISTS _populate_settings;

CREATE TEMP TABLE _populate_settings AS 
         -- tweak this number to generate more or less rows
  SELECT 250000 AS parents_to_generate,
         3 AS child_age_minimum,
         -- x amount of parents
         3 AS child_limit,
         -- x amount of children
         1 AS enrollment_min,
         20 AS enrollment_max;


-- parents
-- ~ 20s @ 250k parents

TRUNCATE lnl_parents;


INSERT INTO lnl_parents(name, 
                        created_at,
                        last_login,
                        referer)
  SELECT p1.name,
         p1.created_at,
         p2.last_login,
         p1.parent_referer
    FROM generate_series(1, (SELECT parents_to_generate
                               FROM _populate_settings)) series
         LEFT JOIN LATERAL (SELECT lnl_parent_name() AS name,
                                   lnl_random_timestamptz('2021-01-01 12:0:01', now()) AS created_at,
                                   lnl_parent_referer() AS parent_referer
                              FROM (SELECT 1) ph
                             -- trick the optimizer to regenerate another random value
                             WHERE series = series) AS p1
                                                    ON true
         LEFT JOIN LATERAL (SELECT lnl_random_timestamptz(p1.created_at, now()) AS last_login
                              FROM (SELECT 1) ph
                             -- trick the optimizer to regenerate another random value
                             WHERE series = series) AS p2
                                                    ON true
 ORDER
     BY random();

  