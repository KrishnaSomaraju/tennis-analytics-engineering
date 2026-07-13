{{ config(
    materialized='incremental',
    unique_key='match_key',
    partition_by={
        'field': 'match_date',
        'data_type': 'date'
    },
    cluster_by=['surface']
) }}

with matches as (

    select * from {{ ref('stg_matches') }}

)

select
    {{ dbt_utils.generate_surrogate_key(['tourney_name', 'tourney_date', 'winner_id', 'loser_id']) }} as match_key,
    parse_date('%Y%m%d', cast(tourney_date as string)) as match_date,
    tourney_name,
    tourney_level,
    surface,
    round,
    best_of,
    winner_id,
    winner_name,
    winner_rank,
    loser_id,
    loser_name,
    loser_rank,
    score

from matches

{% if is_incremental() %}

    where parse_date('%Y%m%d', cast(tourney_date as string)) > (select max(match_date) from {{ this }})

{% endif %}