# Create a  view to handle NULLs 
CREATE OR REPLACE VIEW view_statcast_clean AS
SELECT
    # Unified Date Format 
    CAST(game_date AS DATE) as game_date_clean,
    
    # Split Dates 
    EXTRACT(YEAR FROM CAST(game_date AS DATE)) as game_year,
    EXTRACT(MONTH FROM CAST(game_date AS DATE)) as game_month,
    EXTRACT(DAY FROM CAST(game_date AS DATE)) as game_day,
    
    # Handle Nulls for categorical data 
    COALESCE(events, 'Play in Progress') as event_clean,
    COALESCE(description, 'Unknown') as description_clean,
    
    # Handle Nulls for numerical data (fill with 0 or average if required, here using 0 for safety)
    COALESCE(release_speed, 0.0) as release_speed_clean,
    COALESCE(launch_speed, 0.0) as launch_speed_clean,
    
    player_name,
    home_team,
    away_team
FROM staging_statcast;