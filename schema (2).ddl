drop schema if exists projectschema cascade;
create schema projectschema;
set search_path to projectschema;

--A tuple in this relation represents a country. 
--The name is the country and the country_id is a numerical identifier.
create table Country (
    country_id integer not null,
    name text not null,
    primary key (country_id)
);
--A tuple in this relation represents a professional football league with a 
--league_id numerical identifier, country_id representing which nation the 
--league is based in, and name is merely the official name of the league.

create table League (
    league_id integer not NULL,
    country_id integer references Country,
    name text not null,
    primary key (league_id)
);

--A tuple in this relation represents a professional football team with 
--the team_id being their numerical identifier, 
--name as the official name of the team, 
--league_id referring to which football league they play in, and 
--team_abbreviation being the team’s official name abbreviation.
create table Team (
    team_id int not null,
    team_name text not null,
    team_abbreviation text not null,
    primary key (team_id)
);

--A tuple in this relation describes the biographical data of a professional
--football player with player_id being their numerical identifier, 
--name being their legal name, birthday being their date of birth, 
--and height and weight referring to their measured height and weight.
create table Player (
    player_id integer not null,
    name text not null,
    birthday TIMESTAMP not null,
    height float not null,
    weight int not null,
    primary key (player_id)

);

--A tuple in this relation represents a completed football match with a 
--match_id numerical identifier, country_id referring to where the match 
--was played, league_id referring to the league that the teams played in,
--season is the specific league year of the match, date is the exact date 
--of the match, home_team_id and away_team_id are the numerical identifiers
--of the teams involved in the match where the home team hosted the match,
--home_team_goal and away_team_goal tells us how many goals were scored by
--the respective teams, shot_on and shot_off refer to on/off target shots
--foul_commit details the number of fouls called by the referee, 
--card refers to the number of yellow or red cards shown by the ref, 
--crosses refers to the number of crosses delivered into the box, 
--corner refers to how many corners were awarded by the ref, 
--and possession lists what percentage of the match each team had the ball.
create table Match (
    match_id integer not null,
    country_id integer references Country,
    league_id integer references League,
    season varchar(10) not null,
    date TIMESTAMP not null,
    home_team_id int references Team(team_id),
    away_team_id int references Team(team_id),
    home_team_goal int not null,
    away_team_goal int not null,
    shot_on text,
    shot_off text,
    foul_commit text,
    card text,
    crosses text,
    corner text,
    possession text,
    primary key (match_id)
);

--A tuple in this relation represents a player’s footballing abilities with 
--player_id being their numerical identifier, date was when the analysis was conducted, 
--rating being their overall score as a footballer, 
--potential being how high their rating could hypothetically reach and a measure of their natural talent, 
--attacking_work_rate being a measure of effort they put when their team is on the attack, 
--and defensive_work_rate being a measure of effort they put when their team is on the defence.
create table PlayerAttributes(
    player_id int references Player,
    date TIMESTAMP not null,
    rating float not null check (rating >= 0 and rating <= 100),
    potential float not null check (potential >= 0 and potential <= 100),
    attacking_work_rate text,
    defensive_work_rate text,
    primary key (player_id, date)
);

--A tuple in this relation represents a team’s footballing abilities with 
--the team_id being their numerical identifier, 
--date being the date the analysis was conducted, 
--build_up_play_speed being the speed at which they play when they have possession, 
--build_up_play_dribbling is how often individual players make runs with the ball, 
--build_up_play_passing is how often the team passes the ball when in possession, 
--chance_creation_passing is how often the team creates a chance to score with their passing, 
--chance_creation_crossing is how often the team creates a chance to score with their crossing, 
--chance_creation_shooting is how often the team creates a chance to score with their shooting, 
--defence_pressure is how closely they defend when the opposition has possession, 
--defence_aggression is how aggressively they defend when the opposition has possession, and 
--defence_team_width is how spread out their defence is.
create table TeamAttributes (
    team_id int references Team,
    date TIMESTAMP not null,
    build_up_play_speed int check(build_up_play_speed >= 0 and build_up_play_speed <= 100),
    build_up_play_dribbling float check (build_up_play_dribbling >= 0 and build_up_play_dribbling <= 100),
    build_up_play_passing int check (build_up_play_passing >= 0 and build_up_play_passing <= 100),
    chance_creation_passing int check (chance_creation_passing >= 0 and chance_creation_passing <= 100),
    chance_creation_crossing int check (chance_creation_crossing >= 0 and chance_creation_crossing <= 100),
    chance_creation_shooting int check (chance_creation_shooting >= 0 and chance_creation_shooting <= 100),
    defence_pressure int check (defence_pressure >= 0 and defence_pressure <= 100),
    defence_aggression int check (defence_aggression >= 0 and defence_aggression <= 100),
    defence_team_width int check (defence_team_width >= 0 and defence_team_width <= 100),
    primary key (team_id, date)
);



