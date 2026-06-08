{{ 
   config(
      materialized = 'incremental', 
      unique_key = 'BOOKING_ID'
   )
}}

select 
   BOOKING_ID,
   LISTING_ID,
   BOOKING_DATE,

   {{ multiply('nights_booked', 'booking_amount', 2) }} as total_amount,
   cleaning_fee,
    service_fee ,
   BOOKING_STATUS,
   CREATED_AT

from 
{{ ref('bronzebooking') }}