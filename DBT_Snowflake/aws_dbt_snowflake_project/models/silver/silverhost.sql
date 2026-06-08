{{
  config(
    materialized = 'incremental', unique_key = 'Host_id'
    )
}}

select 
  host_id ,
  replace(host_name,' ',' ') as host_name,
  host_since as host_since,
  is_superhost as is_superhost,
  response_rate as response_rate,
  case 
  when response_rate > 95 then 'very_good'
  when response_rate > 80 then 'good'
  when response_rate > 60 then 'fair'
  else 'poor'
  end as response_rate_quality,
  created_at as created_at

  from {{ ref('bronzehost') }}


  created_at