-- A player cannot beat themselves.
-- Passes when it returns zero rows.

select
    winner_id,
    loser_id,
    tourney_name,
    tourney_date
from {{ ref('stg_matches') }}
where winner_id = loser_id