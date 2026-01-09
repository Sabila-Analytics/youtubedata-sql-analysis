USE global_youtube;

SELECT DATABASE();

-- Purpose: Create a structured table to store cleaned YouTube statistics for analysis

CREATE TABLE `youtube_statistics2` (
  `rank` int DEFAULT NULL,
  `Youtuber` text,
  `subscribers` int DEFAULT NULL,
  `video views` double DEFAULT NULL,
  `category` text,
  `Title` text,
  `uploads` int DEFAULT NULL,
  `Country` text,
  `Abbreviation` text,
  `channel_type` text,
  `video_views_rank` int DEFAULT NULL,
  `country_rank` int DEFAULT NULL,
  `channel_type_rank` int DEFAULT NULL,
  `video_views_for_the_last_30_days` bigint DEFAULT NULL,
  `lowest_monthly_earnings` int DEFAULT NULL,
  `highest_monthly_earnings` double DEFAULT NULL,
  `lowest_yearly_earnings` double DEFAULT NULL,
  `highest_yearly_earnings` double DEFAULT NULL,
  `subscribers_for_last_30_days` text,
  `created_year` int DEFAULT NULL,
  `created_month` text,
  `created_date` int DEFAULT NULL,
  `Gross tertiary education enrollment (%)` double DEFAULT NULL,
  `Population` int DEFAULT NULL,
  `Unemployment rate` double DEFAULT NULL,
  `Urban_population` int DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Purpose:  Rename new table for futher cleaning

RENAME TABLE youtube_statistics2 TO youtube_data2;

-- Purpose: Load raw YouTube data into a structured table for further cleaning

INSERT youtube_statistics2
SELECT *
FROM global_youtube.youtube_statistics;

-- Purpose: Rename column for easier use in further cleaning

ALTER TABLE youtube_data2
RENAME COLUMN `video views` TO video_views;

-- Purpose: Identify records with unreadable or corrupted text in video titles

SELECT title
FROM youtube_data2
WHERE title LIKE 'ï¿½ï¿%';

-- Purpose: Validate text cleaning logic by comparing original and cleaned Youtuber names

SELECT
  Youtuber AS original,
  TRIM(REGEXP_REPLACE(Youtuber, '^[^A-Za-z0-9]+|[^A-Za-z0-9]+$', '')) AS cleaned
FROM youtube_data2;

-- Purpose: Clean unreadable and corrupted characters from Youtuber names

UPDATE youtube_data2
SET Youtuber = TRIM(
  REGEXP_REPLACE(Youtuber, '^[^A-Za-z0-9]+|[^A-Za-z0-9]+$', '')
);

-- Purpose: Clean unreadable and corrupted characters from video titles

UPDATE youtube_data2
SET title = TRIM(
  REGEXP_REPLACE(title, '^[^A-Za-z0-9]+|[^A-Za-z0-9]+$', '')
);

-- Purpose: Identify records with invalid subscriber growth values

SELECT Youtuber, subscribers, subscribers_for_last_30_days
FROM youtube_data2
WHERE subscribers_for_last_30_days LIKE 'nan';

-- Purpose: Identify the top 3 YouTubers in each country based on subscriber count

WITH country_rank AS (
  SELECT 
    youtuber,
    subscribers,
    country,
    DENSE_RANK() OVER (PARTITION BY country ORDER BY subscribers DESC) AS ranking
  FROM youtube_data2
)
SELECT *
FROM country_rank
WHERE ranking <= 3;

-- Purpose: Find the most watched video within each content category

SELECT category, title, youtuber, video_views
FROM (
  SELECT 
    category,
    title,
    youtuber,
    video_views,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY video_views DESC) AS rn
  FROM youtube_data2
) ranked
WHERE rn = 1;

-- Purpose: Identify the most viewed video for each year

SELECT created_year, title, youtuber, video_views
FROM (
  SELECT 
    created_year,
    title,
    youtuber,
    video_views,
    ROW_NUMBER() OVER (PARTITION BY created_year ORDER BY video_views DESC) AS rn
  FROM youtube_data2
) ranked
WHERE rn = 1;
