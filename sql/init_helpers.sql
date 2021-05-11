

CREATE OR REPLACE FUNCTION public.random_timestamptz(start_date timestamptz,
                                                     end_date timestamptz)
                   RETURNS timestamptz
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT (start_date + random() * (end_date - start_date))::timestamptz;
                $FUNCTION$;


CREATE OR REPLACE FUNCTION public.random_integer(low integer,
                                                 high integer)
                   RETURNS integer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT floor(random() * (high - low + 1) + low)::integer;
                $FUNCTION$;


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


CREATE OR REPLACE FUNCTION public.random_parent_referer()
                   RETURNS parent_referer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           WITH targets AS (

                             SELECT unnest(enum_range(NULL::parent_referer)) as referer 

                           )
                           SELECT referer 
                             FROM targets t 
                           ORDER 
                               BY referer 
                            LIMIT 1
                            -- use offset to allow for null values
                            OFFSET (SELECT random_integer(0, ((SELECT count(*)
                                                                 FROM targets) + 1)::integer));
                $FUNCTION$;


CREATE OR REPLACE FUNCTION public.random_topic()
                   RETURNS topic
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT topic 
                             FROM (SELECT unnest(enum_range(NULL::topic)) as topic) sub 
                           ORDER 
                               BY random() 
                            LIMIT 1;
                $FUNCTION$;

