import psycopg2
from sqlalchemy import create_engine
import pandas as pd

# Create engine
my_conn = create_engine("sqlite:////Users/admin/Documents/CSC343/Phase 2/database.sqlite")

# Creating df 
df_player_attr = pd.read_sql("SELECT * FROM Player_Attributes", my_conn)
df_player = pd.read_sql("SELECT * FROM Player", my_conn)
df_match = pd.read_sql("SELECT * FROM Match", my_conn)
df_league = pd.read_sql("SELECT * FROM League", my_conn)
df_country = pd.read_sql("SELECT * FROM Country", my_conn)
df_team = pd.read_sql("SELECT * FROM Team", my_conn)
df_team_attr = pd.read_sql("SELECT * FROM Team_Attributes", my_conn)


# Kill my_conn connection
my_conn.dispose()


# Dropping unrequired cols from each df
df_player_attr = df_player_attr[['player_api_id','date','overall_rating',
                                 'potential','attacking_work_rate',
                                 'defensive_work_rate']]

df_match = df_match[['id','country_id','league_id','season','date',
                     'home_team_api_id','away_team_api_id','home_team_goal',
                     'away_team_goal','shoton','shotoff','foulcommit','card',
                     'cross','corner','possession']]

df_team_attr = df_team_attr[['team_api_id','date','buildUpPlaySpeed',
                             'buildUpPlayDribbling','buildUpPlayPassing','chanceCreationPassing',
                             'chanceCreationCrossing','chanceCreationShooting',
                             'defencePressure','defenceAggression',
                             'defenceTeamWidth']]
                        
df_player = df_player[['player_api_id', 'player_name', 'birthday', 'height', 'weight']]

df_team = df_team[['team_api_id','team_long_name', 'team_short_name']]


# Cleaning up column names (into snake_case), and specifying table id names.
df_player_attr = df_player_attr.rename(columns = {'player_api_id':'player_id'})

df_player = df_player.rename(columns = {'player_api_id':'player_id', 'player_name':'name'})

df_match = df_match.rename(columns = {'id':'match_id', 'home_team_api_id': 'home_team_id', 
                                      'away_team_api_id': 'away_team_id', 'shoton':'shot_on',
                                      'shotoff':'shot_off','foulcommit':'foul_commit',
                                      'cross':'crosses'})

df_league = df_league.rename(columns = {'id':'league_id'})

df_country = df_country.rename(columns = {'id':'country_id'})

df_team = df_team.rename(columns = {'team_api_id':'team_id', 'team_long_name':'team_name', 'team_short_name':'team_abbreviation'})

df_team_attr = df_team_attr.rename(columns = {'team_api_id':'team_id',
                                              'buildUpPlaySpeed':'build_up_play_speed',
                                              'buildUpPlayDribbling':'build_up_play_dribbling',
                                              'buildUpPlayPassing':'build_up_play_passing',
                                            'chanceCreationPassing':'chance_creation_passing',
                                            'chanceCreationCrossing':'chance_creation_crossing',
                                            'chanceCreationShooting':'chance_creation_shooting',
                                            'defencePressure':'defence_pressure',
                                            'defenceAggression':'defence_aggression',
                                            'defenceTeamWidth':'defence_team_width'})

# Data wrangling/cleaning complete

DATABASE_URI = 'postgres+psycopg2://postgres:postgres@localhost:5432/phase2'
engine = create_engine(DATABASE_URI)

df_player_attr.to_sql("PlayerAttributes", con=engine)
df_player.to_sql("Player", con=engine)
df_match.to_sql("Match", con=engine)
df_league.to_sql("League", con=engine)
df_country.to_sql("Country", con=engine)
df_team.to_sql("Team", con=engine)
df_team_attr.to_sql("TeamAttributes", con=engine)


#engine = psycopg2.connect(
#    host = "localhost",
#    database = "phase2",
#    user = "postgres",
#    password = "postgres")
#
#cur = engine.cursor()
#
#cur.execute("select * from testtbl")
#
#rows = cur.fetchall()
#
#for r in rows:
#    print(f"id {r[0]}")
#
#cur.close()