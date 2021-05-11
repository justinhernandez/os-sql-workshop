

-- question

How many Science and Painting enrollments were created via facebook referered parents?


-- things to consider / hints

What tables do we want to pull data from?

What fields are valuable to us?

What values do we want to return?


-- query

EXPLAIN

WITH fb_ig_parents AS (

  SELECT uid
    FROM lnl_parents
   WHERE referer IN ('facebook')

), fb_ig_learners AS (

  SELECT uid,
         name
    FROM lnl_learners l
   WHERE EXISTS (SELECT 1
                   FROM fb_ig_parents p
                  WHERE p.uid = l.parent_uid)

)
SELECT l.name,
       e.topic,
       count(*) AS enrollments
  FROM fb_ig_learners l,
       lnl_enrollments e
 WHERE l.uid = e.learner_uid
   AND e.topic IN ('Science', 'Painting')
GROUP
    BY l.name,
       e.topic
ORDER
    BY l.name,
       e.topic;

------

EXPLAIN ANALYZE

WITH fb_ig_parents AS (

  SELECT uid
    FROM lnl_parents
   WHERE referer IN ('facebook')

), fb_ig_learners AS (

  SELECT uid,
         name
    FROM lnl_learners l
   WHERE EXISTS (SELECT 1
                   FROM fb_ig_parents p
                  WHERE p.uid = l.parent_uid)

)
SELECT l.name,
       e.topic,
       count(*) AS enrollments
  FROM fb_ig_learners l,
       lnl_enrollments e
 WHERE l.uid = e.learner_uid
   AND e.topic IN ('Science', 'Painting')
GROUP
    BY l.name,
       e.topic
ORDER
    BY l.name,
       e.topic;

------

WITH fb_ig_parents AS (

  SELECT uid
    FROM lnl_parents
   WHERE referer IN ('facebook')

), fb_ig_learners AS (

  SELECT uid,
         name
    FROM lnl_learners l
   WHERE EXISTS (SELECT 1
                   FROM fb_ig_parents p
                  WHERE p.uid = l.parent_uid)

)
SELECT l.name,
       e.topic,
       count(*) AS enrollments
  FROM fb_ig_learners l,
       lnl_enrollments e
 WHERE l.uid = e.learner_uid
   AND e.topic IN ('Science', 'Painting')
GROUP
    BY l.name,
       e.topic
ORDER
    BY l.name,
       e.topic;


-- indices created

DROP INDEX IF EXISTS lnl_challenge_0_1_idx;
DROP INDEX IF EXISTS lnl_challenge_0_2_idx;
DROP INDEX IF EXISTS lnl_challenge_0_3_idx;

CREATE INDEX lnl_challenge_0_1_idx
    ON lnl_parents
 USING btree(uid)
 WHERE referer IN ('facebook');

CREATE INDEX lnl_challenge_0_2_idx
    ON lnl_learners
 USING btree(parent_uid);

CREATE INDEX lnl_challenge_0_3_idx
    ON lnl_enrollments
 USING btree(learner_uid, enrolled_at DESC)
 WHERE topic IN ('Science', 'Painting');




 -- explanation and reasonings
 -- why did these indices work?

    