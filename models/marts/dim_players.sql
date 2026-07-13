{{ config(materialized='table') }}

with players as (

    select * from {{ ref('stg_players') }}

),

active_player_ids as (

    select winner_id as player_id from {{ ref('stg_matches') }}
    union distinct
    select loser_id as player_id from {{ ref('stg_matches') }}

)

select
    players.player_id,
    players.player_name,
    players.country_code,
    players.dominant_hand,
    players.height,
    players.weight,
    players.turned_pro_year

from players
inner join active_player_ids
    on players.player_id = active_player_ids.player_id