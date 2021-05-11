

DROP TYPE IF EXISTS topic CASCADE;

CREATE TYPE topic AS ENUM (
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


DROP FUNCTION IF EXISTS random_topic();

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


SELECT random_topic();

  