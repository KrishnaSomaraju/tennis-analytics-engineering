{{ config(materialized='table') }}

with matches as (

    select * from {{ ref('fct_matches') }}

),

winners as (

    select
        match_key,
        match_date,
        tourney_name,
        tourney_level,
        surface,
        round,
        best_of,
        score,
        winner_id     as player_id,
        winner_name   as player_name,
        winner_rank   as player_rank,
        loser_id      as opponent_id,
        loser_name    as opponent_name,
        loser_rank    as opponent_rank,
        true          as won
    from matches

),

losers as (

    select
        match_key,
        match_date,
        tourney_name,
        tourney_level,
        surface,
        round,
        best_of,
        score,
        loser_id      as player_id,
        loser_name    as player_name,
        loser_rank    as player_rank,
        winner_id     as opponent_id,
        winner_name   as opponent_name,
        winner_rank   as opponent_rank,
        false         as won
    from matches

)

select * from winners
union all
select * from losers