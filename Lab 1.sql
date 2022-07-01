--*************************************************************************--
-- Title: Lab 1 - SQL Queries
-- Author: IMartinez
-- Desc: This file demonstrates SQL SELECT queries
-- 2021-01-11,IMartinez,Created File
--**************************************************************************--

USE moviedb

--1. What is the shortest movie?
SELECT TOP 10 movieID, movieOriginalTitle, movieRuntime
FROM tblMovie
WHERE movieRuntime IS NOT NULL
ORDER BY movieRuntime
go


--2. What is the movie with the most number of votes?
SELECT TOP 10 movieOriginalTitle, movieVoteCount
FROM tblMovie
WHERE movieVoteCount IS NOT NULL
ORDER BY movieVoteCount desc
go


--3. Which movie made the most net profit?
SELECT TOP 10 movieOriginalTitle, (movieRevenue - movieBudget) as netProfit
FROM tblMovie
ORDER BY netProfit desc
go


--4. Which movie lost the most money?
SELECT TOP 10 movieOriginalTitle, (movieRevenue - movieBudget) as netLost
FROM tblMovie
ORDER BY netLost
go

--5. How many movies were made in the 80’s?
SELECT COUNT(movieReleaseDate) as movieReleases
FROM tblMovie
WHERE movieReleaseDate BETWEEN '1980-01-01' AND '1989-12-31'
ORDER BY movieReleases
go


--6. What is the most popular movie released in the year 1980?
SELECT TOP 10 movieOriginalTitle, moviePopularity
FROM tblMovie
WHERE movieReleaseDate BETWEEN '1980-01-01' AND '1980-12-31'
ORDER BY moviePopularity desc
go


--7. How long was the longest movie made before 1900?
SELECT TOP 10 movieOriginalTitle, movieRuntime, movieReleaseDate
FROM tblMovie
WHERE movieReleaseDate < '1900-01-01'
ORDER BY movieRuntime desc
go


--8. Which language has the shortest movie?
SELECT l.languageName, MIN(m.movieRuntime) as movieRuntime
FROM tblMovie as m
 JOIN tblLanguage as l
  on m.languageID = l.languageID
GROUP BY l.languageName
ORDER BY movieRuntime
go


--9. Which collection has the highest total popularity?
SELECT c.collectionName, m.moviePopularity
FROM tblCollection as c
 JOIN tblMovie as m
  on c.collectionID = m.collectionID
ORDER BY m.moviePopularity desc
go


--10. Which language has the most movies in production or post-production?
SELECT TOP 10 l.languageName, COUNT(m.movieOriginalTitle) as numMovies
FROM tblStatus as s
 JOIN tblMovie as m
  on s.statusID = m.statusID
 JOIN tblLanguage as l
  on m.languageID = l.languageID
WHERE s.statusName = 'In Production' OR s.statusName = 'Post Production'
GROUP BY l.languageName
ORDER BY numMovies desc
go


--11. What was the most expensive movie that ended up getting canceled?
SELECT TOP 10 m.movieOriginalTitle, MAX(m.movieBudget) as budget, s.StatusName
FROM tblMovie as m
 JOIN tblStatus as s
  on m.statusID = s.statusID
WHERE s.statusName = 'Canceled'
GROUP BY m.movieOriginalTitle, s.statusName
ORDER BY budget desc
go


--12. How many collections have movies that are in production for the language
-- French (FR)
SELECT l.languageName, COUNT(s.statusID) as numInProduction
FROM tblLanguage as l
 JOIN tblMovie as m
  on m.languageID = l.languageID
 JOIN tblStatus as s
  on s.statusID = m.statusID
WHERE l.languageName = 'Français' AND s.statusName = 'In Production'
GROUP BY l.languageName
ORDER BY numInProduction
go


--13. List the top ten rated movies that have received more than 5000 votes
SELECT TOP 10 movieID, movieOriginalTitle, movieVoteAverage, movieVoteCount
FROM tblMovie
WHERE movieVoteCount > 5000
ORDER BY movieVoteAverage desc
go


--14. Which collection has the most movies associated with it?
SELECT c.collectionID, c.collectionName, COUNT(m.movieOriginalTitle) as numMovies
FROM tblCollection as c
 JOIN tblMovie as m
  on c.collectionID = m.collectionID
GROUP BY c.collectionID, c.collectionName
ORDER BY numMovies desc
go


--15. What is the collection with the longest total duration?
SELECT TOP 10 c.collectionName, SUM(m.movieRuntime) as totalRuntime
FROM tblCollection as c
 JOIN tblMovie as m
  on c.collectionID = m.collectionID
GROUP BY c.collectionName
ORDER BY totalRuntime desc
go


--16. Which collection has made the most net profit?
SELECT TOP 10 c.collectionName, SUM(m.movieRevenue - m.movieBudget) as netProfit
FROM tblCollection as c
 JOIN tblMovie as m
  on c.collectionID = m.collectionID
GROUP BY c.collectionName
ORDER BY netProfit desc
go


--17. List the top 100 movies by their duration from longest to shortest
SELECT TOP 100 movieOriginalTitle, movieRuntime
FROM tblMovie
ORDER BY movieRuntime desc
go


--18. Which languages have more than 25,000 movies associated with them?
SELECT l.languageName, COUNT(m.languageID) as movies
FROM tblLanguage as l
 JOIN tblMovie as m
  on l.languageID = m.languageID
GROUP BY l.languageName
ORDER BY movies desc
go


--19. Which collections had all their movies made in the 80’s?
SELECT c.collectionName
FROM tblCollection as c
 JOIN tblMovie as m
  on c.collectionID = m.collectionID
WHERE m.movieReleaseDate BETWEEN '1980-01-01' AND '1980-12-31'
go


--20. In the language that has the most number of movies in the database, how many
-- movies start with “The”? (You may not hard-code a language)
SELECT l.languageName, COUNT(m.languageID) as numMovies
FROM tblLanguage as l
 JOIN tblMovie as m
  on m.languageID = l.languageID
WHERE m.movieOriginalTitle like 'The%'
GROUP BY l.languageName
ORDER BY numMovies desc
go

