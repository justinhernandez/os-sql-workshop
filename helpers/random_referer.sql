

DROP TYPE IF EXISTS lnl_parent_referer CASCADE;

CREATE TYPE lnl_parent_referer AS ENUM (
  'none',
  'facebook',
  'google',
  'bing',
  'instagram'
);


DROP FUNCTION IF EXISTS lnl_parent_referer();

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


SELECT lnl_parent_referer();

  