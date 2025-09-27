Create database covid19;

SELECT * FRom covid_19;


-- Retrieve all data for the USA in March 2020.

SELECT DISTINCT *
FROM Covid_19
WHERE country = "USA" 
AND DATE  BETWEEN "2020-03-01" AND "2020-03-31"
;

-- Find the total number of confirmed cases in India.

SELECT country,sum(deaths)AS TOTAL_deaths
FrOM Covid_19
GROUP BY COUNTRY
ORDER BY TOTAL_DEATHS
DESC
LIMIT 5
;

-- Find the country with the highest number of vaccinations on a single day.

SELECT COUNTRY,date_, vaccinations
FROM COVID_19
order by vaccinations
DESC
limit 1;

-- Calculate the average number of daily confirmed cases for each country.

SELECT COUNTRY, AVG(confirmed_cases) as daily_avg 
FROM covid_19
group by country
;

-- Find the date with the highest number of reported deaths worldwide.

SELECT date_ , SUM(deaths) as total_deaths
FROM COVID_19
Group by date_
order by total_deaths
desc
limit 1
;

-- Find countries where more than 80% of confirmed cases have recovered.

SELECT confirmed_cases,country
FROM covid_19
GROUP BY confirmed_cases
HAVING SUM(recovered) * 100.0 / SUM(confirmed_cases) > 80;





