/*Gets the league with lowest overall_rating*/
SELECT Player.player_id, Player.player_name, League.league_name, player_attributes.overall_rating
FROM Player
INNER JOIN Player_attributes ON Player.player_id= player_attributes.player_id 
INNER JOIN League ON League.league_id = Player.league_id WHERE overall_rating = (SELECT MIN(overall_rating) FROM Player_attributes);


/* Gets the leagues with lowest average_potential*/
SELECT Player.player_id, Player.player_name, League.league_name, player_attributes.potential
FROM Player
INNER JOIN Player_attributes ON Player.player_id= player_attributes.player_id 
INNER JOIN League ON League.league_id = Player.league_id WHERE potential = (SELECT MIN(potential) FROM Player_attributes);


/*Gets the leagues with highest overall_rating*/
SELECT Player.player_id, Player.player_name, League.league_name, player_attributes.overall_rating
FROM Player
INNER JOIN Player_attributes ON Player.player_id= player_attributes.player_id 
INNER JOIN League ON League.league_id = Player.league_id WHERE overall_rating = (SELECT MAX(overall_rating) FROM Player_attributes);

/*Gets the Leagues with highest average_potential*/
SELECT Player.player_id, Player.player_name, League.league_name, player_attributes.potential
FROM Player
INNER JOIN Player_attributes ON Player.player_id= player_attributes.player_id 
INNER JOIN League ON League.league_id = Player.league_id WHERE potential = (SELECT MAX(potential) FROM Player_attributes);

/*France Ligue 1: 4769, England Premier League: 1729, Germany 1 Bundesliga: 7809
	Spain LIGA BBVA: 21518, Italy Serie A: 10257, Netherlands Eredivisie: 13274*/
SELECT * FROM League;

/*Number of all matches played in France Ligue 1*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 4769;

/*All decisive matches in France Ligue 1*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 4769 AND home_team_goal <> away_team_goal;

/*Number of all matches played in England Premier League*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 1729;

/*All decisive matches in England Premier League*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 1729 AND home_team_goal <> away_team_goal;

/*Number of all matches played in Germany 1 Bundesliga*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 7809;

/*All decisive matches in Germany 1 Bundesliga*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 7809 AND home_team_goal <> away_team_goal;


/*Number of all matches played in Spain LIGA BBVA: The result is 355*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 21518;

/*All decisive matches in Spain LIGA BBVA: The result is 289*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 21518 AND home_team_goal <> away_team_goal;

/*Number of all matches played in Spain LIGA BBVA*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 21518;

/*All decisive matches in Spain LIGA BBVA*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 21518 AND home_team_goal <> away_team_goal;

/*Number of all matches played in Italy Serie A: The result is 351*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 10257;

/*All decisive matches in Italy Serie A: The result is 259*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 10257 AND home_team_goal <> away_team_goal;

/*Number of all matches played in Netherlands Eredivisie: The result is 196*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 13274;

/*All decisive matches in Netherlands Eredivisie: The result is 158*/
SELECT COUNT(*) FROM Matchstats WHERE league_id = 13274 AND home_team_goal <> away_team_goal;

/*Create a view that keeps the team IDs of Winners in Every Match*/
CREATE VIEW Winners AS
SELECT 
CASE 
	WHEN home_team_goal > away_team_goal THEN home_team_id
	WHEN home_team_goal < away_team_goal THEN away_team_id
END AS Winner_id
FROM matchstats;

/*Create a view for the top ten in terms of wins from the Winners View Created, 
*/
CREATE VIEW top_ten_succesful AS
SELECT Winner_id,
    COUNT(Winner_id) AS Total_wins 
    FROM    Winners
    GROUP BY Winner_id
    ORDER BY Total_wins DESC
    LIMIT    10;

/*The 10 ten teams with most wins are Team IDs:  */
SELECT * FROM top_ten_succesful;

/*Join the teams table and the top_ten_succesful view to see the names of the top 
successful teams across all European Leagues. The results are:
FC Barcelona, Real Madrid CF, Juventus, Chelsea, FC Bayern Munich, 
Paris Saint-Germain, Manchester City, Atletico Madrid, Sevilla FC, Valencia CF*/
SELECT team.team_long_name, team.team_id, top_ten_succesful.Total_wins
FROM team
INNER JOIN top_ten_succesful ON top_ten_succesful.winner_id = team.team_id;

/*Creating a View for the France Ligue 1 goals*/
CREATE VIEW goal_info AS
SELECT id, unnest(goals_info) AS unnested_goals_info FROM Matchstats WHERE league_id = 4769;
DROP VIEW Winners;

/*Number of penalties scored in France Ligue 1: 102*/
SELECT COUNT(*) FROM goal_info WHERE unnested_goals_info LIKE 'p%';

DROP VIEW goal_info;
/*******************************/

/*Creating a View for the England Premier League goals*/
CREATE VIEW goal_info AS
SELECT id, unnest(goals_info) AS unnested_goals_info FROM Matchstats WHERE league_id = 1729;
/*Number of penalties scored in England Premier League goals: 63*/
SELECT COUNT(*) FROM goal_info WHERE unnested_goals_info LIKE 'p%';

DROP VIEW goal_info;
/******************************/

/*Creating a View for the Germany 1 Bundesliga goals*/
CREATE VIEW goal_info AS
SELECT id, unnest(goals_info) AS unnested_goals_info FROM Matchstats WHERE league_id = 7809;
/*Number of penalties scored in Germany 1 Bundesliga: 58*/
SELECT COUNT(*) FROM goal_info WHERE unnested_goals_info LIKE 'p%';

DROP VIEW goal_info;

/*******************************/

/*Creating a View for the Spain LIGA BBVA goals*/
CREATE VIEW goal_info AS
SELECT id, unnest(goals_info) AS unnested_goals_info FROM Matchstats WHERE league_id = 21518;
/*Number of penalties scored in Spain LIGA BBVA: 86*/
SELECT COUNT(*) FROM goal_info WHERE unnested_goals_info LIKE 'p%';

DROP VIEW goal_info;

/*******************************/

/*Creating a View for the Italy Serie A goals*/
CREATE VIEW goal_info AS
SELECT id, unnest(goals_info) AS unnested_goals_info FROM Matchstats WHERE league_id = 10257;
/*Number of penalties scored in Italy Serie A: 83*/
SELECT COUNT(*) FROM goal_info WHERE unnested_goals_info LIKE 'p%';

DROP VIEW goal_info;

/*******************************/

/*Creating a View for the Netherlands Eredivisie goals*/
CREATE VIEW goal_info AS
SELECT id, unnest(goals_info) AS unnested_goals_info FROM Matchstats WHERE league_id = 13274;
/*Number of penalties scored in Netherlands Eredivisie: 31*/
SELECT COUNT(*) FROM goal_info WHERE unnested_goals_info LIKE 'p%';

DROP VIEW goal_info;

/*******************************/

/************CARDS IN FRANCE LIGUE 1*******************/

/*Creating a View for the France Ligue 1 cards*/
CREATE VIEW crd_info AS
SELECT id, unnest(card_info) as unnested_crd_dtls FROM Matchstats WHERE league_id = 4769;

/*Number of yellow cards in France Ligue 1 is: 1244*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%y%';

/*Number of red cards in France Ligue 1 is: 49*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%r%';

DROP VIEW crd_info;
/**************NUMBER OF CARDS IN EPL**********************************/
/*Creating a View for the England Premier League cards*/
CREATE VIEW crd_info AS
SELECT id, unnest(card_info) as unnested_crd_dtls FROM Matchstats WHERE league_id = 1729;

/*Number of yellow cards in England Premier League is: 1350*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%y%';

/*Number of red cards in England Premier League is: 33*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%r%';

DROP VIEW crd_info;

/**********************CARDS IN BUNDESLIGA*******************************/

/*Creating a View for the Germany 1 Bundesliga cards*/
CREATE VIEW crd_info AS
SELECT id, unnest(card_info) as unnested_crd_dtls FROM Matchstats WHERE league_id = 7809;

/*Number of yellow cards in Germany 1 Bundesliga is: 1073*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%y%';

/*Number of red cards in Germany 1 Bundesliga is: 28*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%r%';

DROP VIEW crd_info;

/**********************LA LIGA****************************/
/*Creating a View for the LIGA BBVA cards*/
CREATE VIEW crd_info AS
SELECT id, unnest(card_info) as unnested_crd_dtls FROM Matchstats WHERE league_id = 21518;

/*Number of yellow cards in LIGA BBVA is: 2023*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%y%';

/*Number of red cards in LIGA BBVA is: 42*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%r%';

DROP VIEW crd_info;

/**********************ITALY SERIE A****************************/
/*Creating a View for the Italy Serie A cards*/
CREATE VIEW crd_info AS
SELECT id, unnest(card_info) as unnested_crd_dtls FROM Matchstats WHERE league_id = 10257;

/*Number of yellow cards in Italy Serie A is: 1839*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%y%';

/*Number of red cards in Italy Serie A is: 47*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%r%';

DROP VIEW crd_info;

/**********************Netherlands Eredivisie****************************/
/*Creating a View for the Netherlands Eredivisie cards*/
CREATE VIEW crd_info AS
SELECT id, unnest(card_info) as unnested_crd_dtls FROM Matchstats WHERE league_id = 13274;

/*Number of yellow cards in Netherlands Eredivisie is: 553*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%y%';

/*Number of red cards in Netherlands Eredivisie is: 20*/
SELECT COUNT(*) FROM crd_info WHERE unnested_crd_dtls LIKE '%r%';

DROP VIEW crd_info;


/*Function to convert 2d array to 1d array*/
CREATE OR REPLACE FUNCTION unnest_2d_1d(anyarray)
  RETURNS SETOF anyarray AS
$func$
SELECT array_agg($1[d1][d2])
FROM   generate_series(array_lower($1,1), array_upper($1,1)) d1
    ,  generate_series(array_lower($1,2), array_upper($1,2)) d2
GROUP  BY d1
ORDER  BY d1
$func$  LANGUAGE sql IMMUTABLE;

CREATE VIEW corners_info AS
SELECT id, unnest_2d_1d(corner_info::int[]) AS cnr_details FROM Matchstats;
CREATE VIEW corner_player_ids AS
SELECT id, cnr_details[2] AS player_id FROM corners_info;

CREATE VIEW corner_player_ids AS
SELECT COUNT(cnr_details[2]) AS player_id
    FROM corners_info
    GROUP BY cnr_details[2]
    ORDER BY player_id DESC
    LIMIT 5;

SELECT * FROM corner_player_ids;

CREATE VIEW top_corner_takers AS
SELECT player_id,
    COUNT(player_id) AS corners_taken 
    FROM corner_player_ids
    GROUP BY player_id
    ORDER BY corners_taken DESC
    LIMIT    5;

/*The top five players who took corners are Mirko Valdifiori, Cesc Fabregas, Hakan Calhanoglu
Zlatko Junuzovic, Dimitri Payet*/
SELECT player.player_name, top_corner_takers.corners_taken 
FROM  Player INNER JOIN top_corner_takers ON player.player_id = top_corner_takers.player_id;

DROP VIEW top_corner_takers;
DROP VIEW corner_player_ids;
DROP VIEW corners_info;


