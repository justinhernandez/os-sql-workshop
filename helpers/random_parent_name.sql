

DROP FUNCTION IF EXISTS lnl_parent_name();

CREATE OR REPLACE FUNCTION public.lnl_parent_name()
                   RETURNS text
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT (SELECT name
                                     FROM lnl_parent_first_names
                                   OFFSET (SELECT lnl_random_integer(1, ((SELECT count(*)::integer
                                                                           FROM lnl_parent_first_names) - 1)))
                                     LIMIT 1)
                                  || ' ' ||
                                  (SELECT name
                                     FROM lnl_parent_last_names
                                   OFFSET (SELECT lnl_random_integer(1, ((SELECT count(*)::integer
                                                                            FROM lnl_parent_last_names) - 1)))
                                     LIMIT 1);
                $FUNCTION$;


SELECT lnl_parent_name();

  