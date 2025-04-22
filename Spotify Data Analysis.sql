-- Table Creation 

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- Exploratory Data Analysis 

-- 1. How many rows in total? - 20594

SELECT COUNT(*)
FROM spotify;

-- 2. What are all the columns in the table? 

SELECT column_name
  FROM information_schema.columns
 WHERE table_name = 'spotify';

-- 3. How many distinct artists and albums? - 2074 

SELECT COUNT(DISTINCT(artist)) AS Artists, COUNT(DISTINCT(album)) AS Albums 
FROM spotify;

-- 4. DIfferent types of albums 

SELECT DISTINCT(album_type) 
FROM spotify;

-- 5. Find out the max,min,average duration in minutes. 

SELECT ROUND(MAX(duration_min)::numeric, 2) AS Longest, ROUND(MIN(duration_min)::numeric, 2) AS Shortest,
ROUND(AVG(duration_min)::numeric,2) AS Average
FROM spotify;

-- Deleting the data where duration minute is 0. 

DELETE FROM spotify 
WHERE duration_min = 0;


-- Business Problems 

-- 1. Get the songs that have more than 1 billion streams.
SELECT artist, track, album, stream 
FROM spotify 
WHERE stream > 1000000000
ORDER BY stream DESC;

-- 2. List all albums along with their respective artists.

SELECT DISTINCT artist, album
FROM spotify;

-- 3. Find the total number of comments for tracks where licensed = TRUE.

SELECT SUM(comments) AS Total_comments
FROM spotify 
WHERE licensed = TRUE;

-- 4. Find the number of tracks that belong to the album type single.

SELECT COUNT(*) As total_count
FROM spotify 
WHERE album_type LIKE '%single%';

-- 5. Count the total number of tracks by each artist.

SELECT artist, COUNT(track) AS Total_songs
FROM spotify 
GROUP BY 1 
ORDER BY 2 DESC;

-- 6. Calculate the average,min and max measures of tracks in each album.
    
CREATE VIEW Average_of_measures AS 
(
SELECT 'Average' AS Agg, 
       AVG(danceability) AS Danceability, 
       AVG(energy) AS Energy,
       AVG(loudness) AS Loudness, 
       AVG(speechiness) AS Speechiness, 
       AVG(acousticness) AS Acousticness,
       AVG(instrumentalness) AS Instrumentalness,
       AVG(liveness) AS Liveness,
       AVG(valence) AS Valence,
       AVG(tempo) AS Tempo
FROM spotify
);

CREATE VIEW Min_of_measures AS
(
SELECT 'Minimum' AS Agg,
       MIN(danceability) AS Danceability, 
       MIN(energy) AS Energy,
       MIN(loudness) AS Loudness, 
       MIN(speechiness) AS Speechiness, 
       MIN(acousticness) AS Acousticness,
       MIN(instrumentalness) AS Instrumentalness,
       MIN(liveness) AS Liveness,
       MIN(valence) AS Valence,
       MIN(tempo) AS Tempo
FROM spotify
);

CREATE VIEW Max_of_measures AS
(
SELECT 'Maximum' AS Agg,
       MAX(danceability) AS Danceability, 
       MAX(energy) AS Energy,
       MAX(loudness) AS Loudness, 
       MAX(speechiness) AS Speechiness, 
       MAX(acousticness) AS Acousticness,
       MAX(instrumentalness) AS Instrumentalness,
       MAX(liveness) AS Liveness,
       MAX(valence) AS Valence,
       MAX(tempo) AS Tempo
FROM spotify
);


SELECT * 
FROM average_of_measures
UNION ALL 
SELECT * 
FROM max_of_measures
UNION ALL 
SELECT * 
FROM min_of_measures;

-- 7. Find the Top 10 Tracks with the highest energy value 

SELECT track, energy, DENSE_RANK() OVER(ORDER BY energy DESC) AS ranking 
FROM spotify
ORDER BY 3
LIMIT 10;

-- 8. 
SELECT track, SUM(views) AS total_views, SUM(likes) AS total_likes
FROM spotify 
WHERE official_video = TRUE
GROUP BY 1
ORDER BY 2 DESC,3 DESC;

-- 9. For each album, calculate the total views of all associated tracks.

SELECT album, track, SUM(views) AS total_views
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC;


-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
/* Solving it by having */
SELECT track,
COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify,
COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube
FROM spotify 
GROUP BY 1
HAVING 
(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END) > 
SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END)) AND SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END) > 0; 

/*Solving it with CTE */
WITH streaming AS 
(
SELECT track,
COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify,
COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube
FROM spotify 
GROUP BY 1
)

SELECT * 
FROM streaming 
WHERE (streamed_on_spotify > streamed_on_youtube) AND (streamed_on_youtube != 0)
ORDER BY streamed_on_spotify DESC;

-- 11. Find the top 3 most-viewed tracks for each artist using window functions.

SELECT * 
FROM (
SELECT artist, track, SUM(views) OVER(PARTITION BY artist,track) AS Most_viewed_tracks, 
RANK() OVER(PARTITION BY artist ORDER BY views DESC) AS ranking 
FROM spotify)
WHERE ranking <= 3
ORDER BY artist, ranking;

-- 12. Find tracks where the liveness score is above average 

SELECT * 
FROM spotify 
WHERE liveness > (
SELECT AVG(liveness)
FROM spotify
);

-- 13. Get the difference between the highest and lowest energy values for tracks in each album 

SELECT *, Maximum - Minimum AS Difference
FROM (
SELECT DISTINCT (album), MAX(energy) OVER(PARTITION BY album) AS Maximum, MIN(energy) OVER(PARTITION BY album) AS Minimum
FROM spotify )
AS max_min_energy
ORDER BY Difference DESC;

