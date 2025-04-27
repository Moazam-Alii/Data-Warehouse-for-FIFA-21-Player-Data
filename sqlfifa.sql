
CREATE DATABASE IF NOT EXISTS fifa_star_schema;
USE fifa_star_schema;


DROP TABLE IF EXISTS fact_player_stats;


DROP TABLE IF EXISTS dim_player;
DROP TABLE IF EXISTS dim_club;
DROP TABLE IF EXISTS dim_country;
DROP TABLE IF EXISTS dim_position;


CREATE TABLE dim_player (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(100),
    age INT,
    height_cm VARCHAR(10),
    weight_kg VARCHAR(10)
);

CREATE TABLE dim_club (
    club_id INT AUTO_INCREMENT PRIMARY KEY,
    club_name VARCHAR(100)
);

CREATE TABLE dim_country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    nationality VARCHAR(100)
);

CREATE TABLE dim_position (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    player_position VARCHAR(50)
);



CREATE TABLE fact_player_stats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    club_id INT,
    country_id INT,
    position_id INT,
    overall_rating INT,
    potential INT,
    value_eur VARCHAR(20),
    wage_eur VARCHAR(20),
    release_clause_eur VARCHAR(20),
    FOREIGN KEY (player_id) REFERENCES dim_player(player_id),
    FOREIGN KEY (club_id) REFERENCES dim_club(club_id),
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (position_id) REFERENCES dim_position(position_id)
);

SELECT COUNT(*) AS player_count
FROM dim_country;

SELECT c.club_name, AVG(f.overall_rating) AS avg_overall_rating
FROM fact_player_stats f
JOIN dim_club c ON f.club_id = c.club_id
GROUP BY c.club_name;

SELECT co.nationality, p.player_position, SUM(f.wage_eur) AS total_wages
FROM fact_player_stats f
JOIN dim_country co ON f.country_id = co.country_id
JOIN dim_position p ON f.position_id = p.position_id
GROUP BY co.nationality, p.player_position;

SELECT c.club_name, (SUM(f.wage_eur) / AVG(f.overall_rating)) AS wage_to_rating_ratio
FROM fact_player_stats f
JOIN dim_club c ON f.club_id = c.club_id
WHERE f.overall_rating >= 85
GROUP BY c.club_name;

SELECT co.nationality, COUNT(f.player_id) AS youth_count
FROM fact_player_stats f
JOIN dim_country co ON f.country_id = co.country_id
WHERE f.age < 23
GROUP BY co.nationality
ORDER BY youth_count DESC
LIMIT 3;

SELECT AVG(overall_rating) AS avg_rating
FROM fact_player_stats;


SELECT c.club_name, COUNT(f.player_id) AS player_count
FROM fact_player_stats f
JOIN dim_club c ON f.club_id = c.club_id
GROUP BY c.club_name;




SELECT p.player_name, pos.player_position, f.potential
FROM fact_player_stats f
JOIN dim_player p ON f.player_id = p.player_id
JOIN dim_position pos ON f.position_id = pos.position_id
WHERE pos.player_position = 'Forward';



SELECT pos.player_position, AVG(f.overall_rating) AS avg_rating
FROM fact_player_stats f
JOIN dim_position pos ON f.position_id = pos.position_id
GROUP BY pos.player_position;


