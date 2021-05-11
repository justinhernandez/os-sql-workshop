

DROP TYPE IF EXISTS parent_referer CASCADE;

CREATE TYPE parent_referer AS ENUM (
  'facebook',
  'google',
  'bing',
  'instagram'
);


DROP FUNCTION IF EXISTS random_parent_referer();

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


SELECT random_parent_referer();

  