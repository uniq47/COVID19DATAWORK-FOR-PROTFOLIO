


--Looking at total cases vs total deaths 
-- it shows the likely hood of dying if we contract coid in the country but here it's for  the nepal
SELECT location, date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentages
FROM protfolioproject..CovidDeaths$
WHERE location like '%Nepal%'
order by 1,2


-- looking at the total cases vs the population
-- shows what percentage of people got covid
SELECT location, date,population,total_cases,(total_cases/population)*100 as PercentOfPopulationInfected
FROM protfolioproject..CovidDeaths$
WHERE location like '%Nepal%'
order by 1,2

-- looking at countries who have the higest infection rate compare with population
SELECT location, population,MAX(total_cases) as higestInfectionCount,MAX((total_cases/population))*100 as PercentOfPopulationInfected
FROM protfolioproject..CovidDeaths$
--WHERE location like '%Nepal%'
Group by location, population
order by PercentOfPopulationInfected DESC



-- showing countries with higest death count per population

SELECT location, MAX(CAST(total_deaths as int)) as totalDeathCounts
FROM protfolioproject..CovidDeaths$
WHERE continent is not null
--WHERE location like '%Nepal%'
Group by location
order by totaldeathcounts  DESC

-- grouping by continent now 




-- showing the continent with the higest death count

SELECT continent, MAX(CAST(total_deaths as int)) as totalDeathCounts
FROM protfolioproject..CovidDeaths$
WHERE continent is not null
--WHERE location like '%Nepal%'
Group by continent
order by totaldeathcounts  DESC


-- GLobal Numbers total cases from the begining

SELECT  date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int))as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*1000 as DeathPercentage-- total_deaths,(total_deaths/total_cases)*100 as DeathPercentages
FROM protfolioproject..CovidDeaths$
--WHERE location like '%Nepal%'
WHERE continent is not null
Group by date
order by 1,2 

-- total cases over all all over the world 
SELECT  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int))as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*1000 as DeathPercentage-- total_deaths,(total_deaths/total_cases)*100 as DeathPercentages
FROM protfolioproject..CovidDeaths$
--WHERE location like '%Nepal%'
WHERE continent is not null
--Group by date
order by 1,2 


-- looking at total population vs Vaccination



SELECT death.continent, death.location, death.date,death.population, vac.new_vaccinations
,cast(vac.new_vaccinations as int) as newnum
--later i want to add a sum on each column 
into #temp1
FROM protfolioproject..CovidDeaths$ death
join protfolioproject..CovidVaccinations$  vac
	ON death.location = vac.location
	and death.date= vac.date
WHERE death.continent  is not null 
group by death.continent, death.location, death.date,death.population, vac.new_vaccinations
--order by 2,3 


SELECT t1.*
--sum(newnum) OVER (ORDER BY location) AS RunningAgeTotal
--later i want to add a sum on each column 
FROM #temp1 t1
WHERE t1.continent  is not null 
--group by t1.continent, t1.location, t1.date,t1.population, t1.new_vaccinations,t1.newnum
--order by 2,3 

drop table #temp1


