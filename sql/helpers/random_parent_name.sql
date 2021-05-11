

DROP FUNCTION IF EXISTS random_parent_name();

CREATE OR REPLACE FUNCTION public.random_parent_name()
                   RETURNS text
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT (SELECT name
                                     FROM parent_first_names
                                   ORDER
                                       BY random()
                                     LIMIT 1)
                                  || ' ' ||
                                  (SELECT name
                                     FROM parent_last_names
                                   ORDER
                                       BY random()
                                     LIMIT 1);
                $FUNCTION$;


SELECT random_parent_name();

  