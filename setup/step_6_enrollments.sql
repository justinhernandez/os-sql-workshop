

-- enrollments
-- ~ 18s @ 250k parents

TRUNCATE lnl_enrollments;

INSERT INTO lnl_enrollments(learner_uid,
                            topic,
                            enrolled_at)

  -- select each learner to create X enrollments
  SELECT l.uid AS learner_uid,
         p2.topic,
         p2.enrolled_at
    FROM lnl_learners l,
         lnl_parents p
         LEFT JOIN LATERAL (SELECT lnl_random_integer((SELECT enrollment_min
                                                         FROM _populate_settings), 
                                                   (SELECT enrollment_max
                                                      FROM _populate_settings)) AS enrollment_count
                              FROM (SELECT 1) ph
                             -- trick the optimizer to regenerate another random value
                             WHERE l.uid = l.uid) AS p1
                                                  ON true
         LEFT JOIN LATERAL (SELECT lnl_topic() AS topic,
                                   lnl_random_timestamptz(p.created_at, now()) AS enrolled_at
                              FROM generate_series(1, p1.enrollment_count) seq
                             -- trick the optimizer to regenerate another random value
                             WHERE l.uid = l.uid) AS p2
                                                  ON true
   WHERE l.parent_uid = p.uid
  ORDER
      BY random();

  