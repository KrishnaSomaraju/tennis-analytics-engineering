-- Tournament dates must fall within 2020 to 2024.
-- Passes when it returns zero rows.

select
    tourney_name,
    tourney_date,
    winner_name,
    loser_name
from {{ ref('stg_matches') }}
where tourney_date < 20200101
   or tourney_date > 20241231