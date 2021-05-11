

-- enrollments
-- ~ 3m 15s @ 250k parents

TRUNCATE lnl_enrollments;

INSERT INTO lnl_enrollments(learner_uid,
                            topic,
                            enrolled_at)

  -- select each learner to create X enrollments
  SELECT l.uid AS learner_uid,
         enrollment.topic,
         enrollment.enrolled_at
    FROM lnl_learners l,
         lnl_parents p
         LEFT JOIN LATERAL(SELECT lnl_topic() AS topic,
                                  lnl_random_timestamptz(p.created_at, now()) AS enrolled_at
                             FROM generate_series(1, lnl_random_integer((SELECT enrollment_min
                                                                           FROM lnl_populate_settings
                                                                          WHERE l.uid = l.uid), 
                                                                        (SELECT enrollment_max
                                                                           FROM lnl_populate_settings
                                                                          WHERE l.uid = l.uid))) series
                            WHERE l.uid = l.uid) AS enrollment
                                                 ON true
   WHERE l.parent_uid = p.uid
  ORDER
      BY random();

  