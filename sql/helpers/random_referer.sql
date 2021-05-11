

DROP TYPE IF EXISTS lnl_parent_referer CASCADE;

CREATE TYPE lnl_parent_referer AS ENUM (
  'facebook',
  'google',
  'bing',
  'instagram'
);


DROP FUNCTION IF EXISTS lnl_random_parent_referer();

CREATE OR REPLACE FUNCTION public.random_parent_referer()
                   RETURNS lnl_parent_referer
                  LANGUAGE sql
                  VOLATILE
                        AS
                $FUNCTION$
                           WITH targets AS (

                             SELECT unnest(enum_range(NULL::lnl_parent_referer)) as referer 

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


SELECT lnl_random_parent_referer();

  