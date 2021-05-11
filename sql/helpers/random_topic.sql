

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


DROP FUNCTION IF EXISTS lnl_random_topic();

CREATE OR REPLACE FUNCTION public.lnl_random_topic()
                   RETURNS topic
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


SELECT lnl_random_topic();

  