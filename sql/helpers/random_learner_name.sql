

DROP FUNCTION IF EXISTS lnl_random_learner_name();

CREATE OR REPLACE FUNCTION public.lnl_random_learner_name()
                   RETURNS text
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT name
                             FROM learner_first_names
                           ORDER
                               BY random()
                             LIMIT 1;
                $FUNCTION$;


SELECT lnl_random_learner_name();

  