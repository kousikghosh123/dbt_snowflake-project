
{{
  config(
    materialized = 'table'
    )
}}


select * from airbnb.staging.listings
where listing_id = 1