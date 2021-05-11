

DROP FUNCTION IF EXISTS lnl_learner_name();

CREATE OR REPLACE FUNCTION public.lnl_learner_name()
                   RETURNS text
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT name
                             FROM lnl_learner_first_names
                             LIMIT 1
                             OFFSET (SELECT lnl_random_integer(1, (SELECT count(*)::integer
                                                                     FROM lnl_learner_first_names)));
                $FUNCTION$;


SELECT lnl_learner_name();

  