-- The dataset for this exercise has been derived from the 
-- `Indeed Data Scientist/Analyst/Engineer` 
-- [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer)
-- on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary 
-- and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using 
-- the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs
;
----- 1793 rows in the data_analyst_jobs table -----


-- 2.	Write a query to look at just the first 10 rows. What company is 
--      associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10
;
----- ExxonMobil is associated w/ the 10th row job posting-----


-- 3.	- a.How many postings are in Tennessee? 21 job postings
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN'
;
--      - b.How many are there in either Tennessee or Kentucky? 27 jobs posting
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location ='TN' OR location='KY'
;
----- 21 Job posting in Tennessee; and  27 job postings between Tennessee & Kentucky


-- 4.	How many postings in Tennessee have a star rating above 4?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location='TN'
      AND star_rating > 4.0
;
----- 3 Job Postings in Tennessee have a star rating above 4. -----


-- 5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000
;
----- 151 job postings have between 500 and 1000 views. -----


-- 6.	Show the average star rating for companies in each state. The output 
--      should show the state as `state` and the average rating for the state 
--      as `avg_rating`. Which state shows the highest average rating?
SELECT location AS state, ROUND(AVG(star_rating), 2) AS star_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY AVG(star_rating) DESC
;
----- Nebraska has the highest average star rating for it's companies. -----


-- 7.	Select unique job titles from the data_analyst_jobs table. 
--      How many are there?  881 unique job titles.
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
;

-- 8.	How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location='CA'
;
----- 230 unique job title from California -----

-- 9.	Find the name of each company and its average star rating for all companies 
--      that have more than 5000 reviews across all locations. How many companies
--      are there with more that 5000 reviews across all locations?
SELECT DISTINCT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000
;
---- 71 companies w/ more than 5000 ratings -----


-- 10.	Add the code to order the query in #9 from highest to lowest average star 
--      rating. Which company with more than 5000 reviews across all locations in 
--      the dataset has the highest star rating? What is that rating?
SELECT DISTINCT company, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY avg_rating DESC
;
----- Google has the highest average star rating w/ a 4. 3 star rating -----


-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different
--      job titles are there? 

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title ILIKE '% analyst %' -- ILIKE ignores case, % word % finds 'word' in string
;
----- 288 job titles with Analyst -----


-- 12.	How many different job titles do not contain either the word ‘Analyst’ or 
--      the word ‘Analytics’? What word do these positions have in common?
SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%analytics%'
;
----- 4 job titles w/o 'Analyst' or 'Analytics', all want Tableau -----


-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number
-- of jobs by industry (domain) that require SQL and have been posted longer than 
-- 3 weeks. 
--     - Disregard any postings where the domain is NULL. 
--     - Order your results so that the domain with the greatest number of 
--           `hard to fill` jobs is at the top. 
--     - Which three industries are in the top 4 on this list? How many jobs 
--            have been listed for more than 3 weeks for each of the top 4?
SELECT domain, COUNT(*) AS hard_to_fill
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
  AND days_since_posting > 21
  AND domain IS NOT NULL
GROUP BY domain
ORDER BY hard_to_fill DESC
;
----- "Internet & Software", "Banks & Financial Services", &    -----
----- "Consulting & Business Services" are the industries with  -----
----- the most hard to fill SQL jobs. With the following number -----
----- or hard to fill jobs:                                     -----
-----   -- Internet & Software: 62 hard to fill jobs            -----
-----   -- Banks & Financial Services: 61 hard to fill jobs     -----
-----   -- Consulting & Business Services: 57 hard to fill jobs -----