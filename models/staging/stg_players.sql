with source as (

    select * from {{ source('raw', 'players') }}

)

select
    id as player_id,
    player as player_name,
    ioc as country_code,
    hand as dominant_hand,
    height as height,
    weight as weight,
    turnedpro as turned_pro_year
from source