

DROP FUNCTION IF EXISTS lnl_random_timestamptz(start_date timestamptz,
                                               end_date timestamptz);
​
CREATE OR REPLACE FUNCTION public.lnl_random_timestamptz(start_date timestamptz,
                                                         end_date timestamptz)
                   RETURNS timestamptz
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT (start_date + random() * (end_date - start_date))::timestamptz;
                $FUNCTION$;
​
​
​
SELECT lnl_random_timestamptz('2021-04-01 12:0:01'::timestamptz, now()::timestamptz);




