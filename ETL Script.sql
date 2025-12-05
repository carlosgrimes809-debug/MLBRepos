
# Populate Dim_Date (Distinct dates only)
INSERT INTO Dim_Date (Full_Date, Year, Month, Day, Quarter)
SELECT DISTINCT 
    game_date_clean, 
    game_year, 
    game_month, 
    game_day,
    EXTRACT(QTR FROM game_date_clean)
FROM view_statcast_clean;

# Populate Dim_Team (Union home and away to get all unique teams)
INSERT INTO Dim_Team (Team_Code)
SELECT DISTINCT home_team FROM view_statcast_clean
UNION
SELECT DISTINCT away_team FROM view_statcast_clean;

# Populate Dim_Player
INSERT INTO Dim_Player (Player_Name)
SELECT DISTINCT player_name FROM view_statcast_clean;

# Populate Fact_Pitching (Joining clean data with dimensions to get Surrogate Keys)
INSERT INTO Fact_Pitching (Date_SK, Team_SK, Player_SK, Release_Speed, Launch_Speed, Event_Result, Pitch_Description)
SELECT 
    d.Date_SK,
    t.Team_SK,
    p.Player_SK,
    v.release_speed_clean,
    v.launch_speed_clean,
    v.event_clean,
    v.description_clean
FROM view_statcast_clean v
JOIN Dim_Date d ON v.game_date_clean = d.Full_Date
JOIN Dim_Team t ON v.home_team = t.Team_Code 
JOIN Dim_Player p ON v.player_name = p.Player_Name;