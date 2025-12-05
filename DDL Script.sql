

# Dimension: Date
CREATE TABLE Dim_Date (
    Date_SK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    Full_Date DATE,
    Year INT,
    Month INT,
    Day INT,
    Quarter INT
);

# Dimension: Team
CREATE TABLE Dim_Team (
    Team_SK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    Team_Code VARCHAR(10) UNIQUE
);

# Dimension: Player
CREATE TABLE Dim_Player (
    Player_SK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    Player_Name VARCHAR(255)
);

# Fact Table: Pitching
CREATE TABLE Fact_Pitching (
    Fact_ID INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key [cite: 46]
    Date_SK INT REFERENCES Dim_Date(Date_SK),
    Team_SK INT REFERENCES Dim_Team(Team_SK),
    Player_SK INT REFERENCES Dim_Player(Player_SK),
    
# Metrics (Facts)
    Release_Speed DECIMAL(5,2),
    Launch_Speed DECIMAL(5,2),
    Event_Result VARCHAR(50),
    Pitch_Description VARCHAR(100)
);