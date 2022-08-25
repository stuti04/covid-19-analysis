-- % of death in India from Feb 2020 to Aug 2022
-- Shows likelihood of dying from covid in India if you contract the virus. 

SELECT Location, date, total_cases, total_deaths, ((total_deaths/total_cases) * 100) AS percent_deaths
FROM CovidAnalysisProject..CovidDeaths
WHERE Location = 'India'
ORDER BY 1, 2 DESC;


-- What percent of the population contracted the coronavirus?

SELECT Location, date, total_cases, population, ((total_cases/population) * 100) AS percent_cases
FROM CovidAnalysisProject..CovidDeaths 
WHERE Location = 'India'
ORDER BY 1, 2 DESC;


-- Total number of cases in a country 

SELECT Location, MAX(total_cases) AS max_cases
FROM CovidAnalysisProject..CovidDeaths 
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY Location;


-- Deleted unwanted location names as high income, low income, etc.

DELETE FROM CovidAnalysisProject..CovidDeaths
WHERE Location = 'Low income' OR Location = 'International';


-- Highest % of people infected by country

SELECT Location, population, MAX(total_cases) AS total_cases_count, MAX((total_cases/population) * 100) AS percent_population_infected
FROM CovidAnalysisProject..CovidDeaths 
WHERE continent IS NOT NULL
GROUP BY Location, population
ORDER BY percent_population_infected DESC;


-- Total death count by countries

SELECT Location, MAX(CAST(total_deaths AS int)) AS total_deaths_count
FROM CovidAnalysisProject..CovidDeaths 
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY total_deaths_count DESC;


-- Total death count by continent

SELECT continent, MAX(CAST(total_deaths AS int)) AS total_deaths_count
FROM CovidAnalysisProject..CovidDeaths 
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths_count DESC;

SELECT * 
FROM CovidAnalysisProject..CovidDeaths

-- Total cases per day across the globe

SELECT date, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths AS INT)) AS total_new_deaths, (SUM(CAST(new_deaths AS INT))/SUM(new_cases)) * 100 AS new_deaths_percent 
FROM CovidAnalysisProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- Total new cases & deaths overall 

SELECT SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths AS INT)) AS total_new_deaths, (SUM(CAST(new_deaths AS INT))/SUM(new_cases)) * 100 AS new_deaths_percent 
FROM CovidAnalysisProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;






