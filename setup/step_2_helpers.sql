

CREATE OR REPLACE FUNCTION public.lnl_random_timestamptz(start_date timestamptz,
                                                         end_date timestamptz)
                   RETURNS timestamptz
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT (start_date + random() * (end_date - start_date))::timestamptz;
                $FUNCTION$;


CREATE OR REPLACE FUNCTION public.lnl_random_integer(low integer,
                                                     high integer)
                   RETURNS integer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT floor(random() * (high - low + 1) + low)::integer;
                $FUNCTION$;


CREATE OR REPLACE FUNCTION public.lnl_parent_name()
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


CREATE OR REPLACE FUNCTION public.lnl_learner_name()
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


DROP TYPE IF EXISTS lnl_parent_referer CASCADE;

CREATE TYPE lnl_parent_referer AS ENUM (
  'none',
  'facebook',
  'google',
  'bing',
  'instagram'
);

CREATE OR REPLACE FUNCTION public.lnl_parent_referer()
                   RETURNS lnl_parent_referer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT parent_referer 
                             FROM (SELECT unnest(enum_range(NULL::lnl_parent_referer)) as parent_referer) sub 
                           ORDER 
                               BY random() 
                            LIMIT 1;
                $FUNCTION$;


DROP TYPE IF EXISTS lnl_topic CASCADE;

CREATE TYPE lnl_topic AS ENUM (
  'Animals',
  'Cooking & Baking',
  'Dance',
  'Drawing',
  'Emotions',
  'History',
  'Making Music',
  'Math',
  'Money Skills',
  'Painting',
  'Programming',
  'Puzzles',
  'Reading',
  'Science',
  'Singing',
  'Socializing',
  'Spanish',
  'Video Games',
  'Workouts',
  'Writing'
);

CREATE OR REPLACE FUNCTION public.lnl_topic()
                   RETURNS lnl_topic
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           SELECT topic 
                             FROM (SELECT unnest(enum_range(NULL::lnl_topic)) as topic) sub 
                           ORDER 
                               BY random() 
                            LIMIT 1;
                $FUNCTION$;

