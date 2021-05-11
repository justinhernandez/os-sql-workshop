

CREATE OR REPLACE FUNCTION public.random_integer(low integer,
                                                 high integer)
                   RETURNS integer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT floor(random() * (high - low + 1) + low)::integer;
                $FUNCTION$;

  