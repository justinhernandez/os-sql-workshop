

DROP FUNCTION IF EXISTS lnl_random_integer(low integer,
                                           high integer);

CREATE OR REPLACE FUNCTION public.lnl_random_integer(low integer,
                                                     high integer)
                   RETURNS integer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT floor(random() * (high - low + 1) + low)::integer;
                $FUNCTION$;

  