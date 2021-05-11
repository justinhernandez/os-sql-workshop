

DROP FUNCTION IF EXISTS random_learner_name();

CREATE OR REPLACE FUNCTION public.random_learner_name()
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


SELECT random_learner_name();

  