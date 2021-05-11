

-- random_timestamptz
​
CREATE OR REPLACE FUNCTION public.random_timestamptz(start_date timestamptz,
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
SELECT random_timestamptz('2021-04-01 12:0:01'::timestamptz, now()::timestamptz);




