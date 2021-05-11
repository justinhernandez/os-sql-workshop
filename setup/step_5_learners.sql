

-- learners
-- ~ 2m 30s @ 250k parents

TRUNCATE lnl_learners;


INSERT INTO lnl_learners(parent_uid,
                         name,
                         age)

  -- select each parent to create X learners
  SELECT uid AS parent_uid,
         p2.name,
         p2.age
    FROM lnl_parents p
         LEFT JOIN LATERAL (SELECT lnl_random_integer(1, (SELECT child_limit
                                                            FROM _populate_settings)) AS child_count
                              FROM (SELECT 1) ph
                             -- trick the optimizer to regenerate another random value
                             WHERE p.uid = p.uid) AS p1
                                                  ON true
         LEFT JOIN LATERAL (SELECT lnl_learner_name() AS name,
                                   lnl_random_integer((SELECT child_age_minimum
                                                         FROM _populate_settings), 18) AS age
                              FROM generate_series(1, p1.child_count) seq
                             -- trick the optimizer to regenerate another random value
                             WHERE p.uid = p.uid) AS p2
                                                  ON true
  ORDER
      BY random();

  