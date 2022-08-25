-- Joining both the tables 

SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(bigint, CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date ROWS UNBOUNDED PRECEDING)
FROM CovidAnalysisProject..CovidDeaths CD
JOIN CovidAnalysisProject..CovidVaccinations CV
ON CD.location = CV.location
AND CD.date = CD.date
WHERE CD.continent IS NOT NULL
ORDER BY 2, 3;

-- Using CTE 

With PopVac(Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
AS (

SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(bigint, CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date ROWS UNBOUNDED PRECEDING) RollingPeopleVaccinated
FROM CovidAnalysisProject..CovidDeaths CD
JOIN CovidAnalysisProject..CovidVaccinations CV
ON CD.location = CV.location
AND CD.date = CD.date
WHERE CD.continent IS NOT NULL

)

SELECT *, (RollingPeopleVaccinated/Population) * 100 
FROM PopVac


-- Creating Views to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS 
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(bigint, CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date ROWS UNBOUNDED PRECEDING) AS RollingCount
FROM CovidAnalysisProject..CovidDeaths CD
JOIN CovidAnalysisProject..CovidVaccinations CV
ON CD.location = CV.location
AND CD.date = CD.date
WHERE CD.continent IS NOT NULL

