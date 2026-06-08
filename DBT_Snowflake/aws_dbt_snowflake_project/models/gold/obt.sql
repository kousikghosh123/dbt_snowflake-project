{% set congigs = [
    {
        "table": "AIRBNB.SILVER.SILVERBOOKING",
        "columns": "silverbooking.booking_id,
                    silverbooking.listing_id,
                    silverbooking.booking_date,
                    silverbooking.total_amount,
                    silverbooking.cleaning_fee,
                    silverbooking.service_fee,
                    silverbooking.booking_status,
                    silverbooking.created_at",
        "alias": "silverbooking"
    },
    {
        "table": "AIRBNB.SILVER.SILVERLISTING",
        "columns": "silverlisting.listing_id as listing_dim_id,
                    silverlisting.host_id,
                    silverlisting.property_type,
                    silverlisting.room_type,
                    silverlisting.city,
                    silverlisting.country,
                    silverlisting.accommodates,
                    silverlisting.bedrooms,
                    silverlisting.bathrooms,
                    silverlisting.price_per_night,
                    silverlisting.price_per_night_tag,
                    silverlisting.created_at as listing_created",
        "alias": "silverlisting",
        "join_condition": "silverbooking.listing_id = silverlisting.listing_id"
    },
    {
        "table": "AIRBNB.SILVER.SILVERHOST",
        "columns": "silverhost.host_name,
                    silverhost.host_since,
                    silverhost.is_superhost,
                    silverhost.response_rate,
                    silverhost.response_rate_quality,
                    silverhost.created_at as host_created_at",
        "alias": "silverhost",
        "join_condition": "silverlisting.host_id = silverhost.host_id"
    }
] %}

SELECT
{% for config in congigs %}
    {{ config.columns }}{% if not loop.last %},{% endif %}
{% endfor %}

FROM {{ congigs[0].table }} AS {{ congigs[0].alias }}

{% for config in congigs[1:] %}
LEFT JOIN {{ config.table }} AS {{ config.alias }}
    ON {{ config.join_condition }}
{% endfor %}

