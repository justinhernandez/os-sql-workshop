

-- question

How many learners were created via facebook referered parents?


-- things to consider / hints

What tables do we want to pull data from?

What fields are valuable to us?

What values do we want to return?


-- query

EXPLAIN

SELECT e.topic,
       count(*) AS enrollments
  FROM lnl_parents p,
       lnl_learners l,
       lnl_enrollments e
 WHERE p.uid = l.parent_uid
   AND l.uid = e.learner_uid
   AND p.referer = 'facebook'
GROUP
    BY e.topic
ORDER
    BY count(*) DESC;


EXPLAIN ANALYZE

SELECT e.topic,
       count(*) AS enrollments
  FROM lnl_parents p,
       lnl_learners l,
       lnl_enrollments e
 WHERE p.uid = l.parent_uid
   AND l.uid = e.learner_uid
   AND p.referer = 'facebook'
GROUP
    BY e.topic
ORDER
    BY count(*) DESC;


-- indices created

  