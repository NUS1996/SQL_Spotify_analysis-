# 🎵 Spotify Data Analysis Project

This project focuses on performing **Exploratory Data Analysis (EDA)** and solving **business queries** using SQL on a simulated Spotify dataset. The dataset combines both Spotify and YouTube streaming metrics, offering a fun and comprehensive view of track performance, artist reach, and musical features.

---

## 📁 Dataset Overview

The table `spotify` includes the following columns:

| Column Name          | Description                                     |
|-----------------------|-------------------------------------------------|
| artist                | Name of the artist                             |
| track                 | Name of the track                              |
| album                 | Name of the album                              |
| album_type            | Type of album (single, album, etc.)            |
| danceability          | Danceability score (0.0 - 1.0)                 |
| energy                | Energy score (0.0 - 1.0)                       |
| loudness              | Loudness level                                 |
| speechiness           | Speech content score                           |
| acousticness          | Acoustic quality score                         |
| instrumentalness      | Instrumental level score                       |
| liveness              | Live performance likelihood score              |
| valence               | Musical positiveness score                     |
| tempo                 | Track tempo (BPM)                              |
| duration_min          | Duration of the track (in minutes)             |
| title                 | YouTube video title                            |
| channel               | YouTube channel name                           |
| views                 | Number of YouTube views                        |
| likes                 | Number of YouTube likes                        |
| comments              | Number of YouTube comments                     |
| licensed              | Whether the track is licensed (TRUE/FALSE)     |
| official_video        | Is it the official video? (TRUE/FALSE)         |
| stream                | Total Spotify streams                          |
| energy_liveness       | Custom metric combining energy & liveness      |
| most_played_on        | Primary platform ("Spotify" / "Youtube")       |

---

## 💡 Project Goals

- Clean and prepare the dataset for analysis.
- Extract insights to help **business decisions** like artist partnerships, marketing strategies, and content recommendations.
- Practice **SQL queries** including aggregations, window functions, CTEs, and conditional logic.

---

## 🔍 Exploratory Data Analysis

Key steps and queries:
- Counting total rows, distinct artists and albums.
- Analyzing album types and track duration statistics.
- Removing anomalies (tracks with 0-minute duration).
- Listing tracks with more than **1 billion streams**.
- Calculating total comments for licensed tracks.
- Counting tracks by artist and album types.
- Aggregating musical features with `AVG()`, `MIN()`, `MAX()` into views.
- Finding high-energy tracks and YouTube performance patterns.
- Identifying platform preferences (Spotify vs YouTube) using `HAVING` and `CTEs`.
- Using **window functions** to rank top tracks per artist.
- Investigating above-average liveness tracks.
- Calculating energy range per album.

---

## ⚙️ Technologies Used

- SQL (PostgreSQL dialect preferred)
- Relational Database Management Systems (RDBMS)
- Window Functions, CTEs, and Views
- Git & GitHub for version control

---

## 📌 How to Use

1. Clone the repository.
2. Import the SQL file to your local PostgreSQL or any compatible RDBMS.
3. Execute queries step by step to explore and analyze.
4. Use the insights to design dashboards, reports, or build predictive models.

---

## 📈 Insights Highlights

- Identified top streamed tracks with over 1 billion plays.
- Measured musical properties across the entire catalog.
- Ranked top 3 most-viewed tracks for every artist.
- Discovered songs streamed more on Spotify than on YouTube.
- Calculated album-wise energy ranges to spot mood diversity.

---

## 💡 Future Enhancements

- Visualization of trends using Power BI or Tableau.
- Integrating artist metadata like genres and release dates.
- Creating a recommendation model based on features like energy, liveness, and valence.

---

## 🤝 Contributing

Pull requests are welcome! For significant changes, please open an issue first to discuss what you would like to change.

---
