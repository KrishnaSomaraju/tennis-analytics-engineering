with matches_2020 as (
    select * from {{ source('raw', 'matches_2020') }}
),

matches_2021 as (
    select * from {{ source('raw', 'matches_2021') }}
),

matches_2022 as (
    select * from {{ source('raw', 'matches_2022') }}
),

matches_2023 as (
    select * from {{ source('raw', 'matches_2023') }}
),

matches_2024 as (
    select * from {{ source('raw', 'matches_2024') }}
),

all_matches as (

    select * from matches_2020
    union all
    select * from matches_2021
    union all
    select * from matches_2022
    union all
    select * from matches_2023
    union all
    select * from matches_2024

)

select
    tourney_name,
    surface,
    tourney_date,
    tourney_level,
    round,
    best_of,
    winner_id,
    winner_name,
    winner_rank,
    loser_id,
    loser_name,
    loser_rank,
    score
from all_matches