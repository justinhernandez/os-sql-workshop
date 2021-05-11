

-- learners
-- ~ 2m 15s @ 250k parents

TRUNCATE lnl_learners;


INSERT INTO lnl_learners(parent_uid,
                         name,
                         age)

  -- select each parent to create X learners
  SELECT uid AS parent_uid,
         learner.name,
         learner.age
    FROM lnl_parents p
         LEFT JOIN LATERAL(SELECT lnl_learner_name() AS name,
                                  lnl_random_integer((SELECT child_age_minimum
                                                        FROM lnl_populate_settings), 18) AS age
                             FROM generate_series(1, lnl_random_integer(1, (SELECT child_limit
                                                                              FROM lnl_populate_settings))) series
                            WHERE p.uid = p.uid) AS learner
                                                 ON true
  ORDER
      BY random();

  