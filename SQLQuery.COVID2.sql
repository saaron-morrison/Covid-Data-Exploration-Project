Select *
From [PortfolioProject.COVID]..[COVID.Deaths]
Where continent is not null
Order by 3,4

--Select *
--From [PortfolioProject.COVID]..[COVID.Vaccinations]
--Order by 3,4


-- Let's Break Things Down by Country

Select location, Max(cast(Total_deaths as int)) as TotalDeathCount
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Where continent is not null
Group by location
Order by TotalDeathCount desc

--Breakdown by Continent, sans 'World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Low income'

Select location, Max(cast(Total_deaths as int)) as TotalDeathCount
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Where continent is null
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Low income')
Group by location
Order by TotalDeathCount desc

--Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From [PortfolioProject.COVID]..[COVID.Deaths]
Where continent is not null
Order by 1,2

--Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From [PortfolioProject.COVID]..[COVID.Deaths]
Where location like '%states%'
and continent is not null
Order by 1,2

--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

Select Location, date, population, total_cases,(total_cases/population)*100 as PercentPopulationInfected
From [PortfolioProject.COVID]..[COVID.Deaths]
Where location like '%states%'
Order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Group by Location, Population
Order by PercentPopulationInfected desc

-- Looking at Countries with Highest Infection Rate compared to Population, Date

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Group by Location, Population, date
Order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population

Select Location, Max(cast(Total_deaths as int)) as TotalDeathCount
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Where continent is not null
Group by Location
Order by TotalDeathCount desc

--Showing continents with the highest death count per population

Select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc

--Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths ,SUM(cast(New_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From [PortfolioProject.COVID]..[COVID.Deaths]
--Where location like '%states%'
Where continent is not null
--Group by date
Order by 1,2


-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [PortfolioProject.COVID]..[COVID.Deaths] dea
Join [PortfolioProject.COVID]..[COVID.Vaccinations] vac
     On dea.location = vac.location
	 and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

-- Use CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [PortfolioProject.COVID]..[COVID.Deaths] dea
Join [PortfolioProject.COVID]..[COVID.Vaccinations] vac
     On dea.location = vac.location
	 and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--Temp Table

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [PortfolioProject.COVID]..[COVID.Deaths] dea
Join [PortfolioProject.COVID]..[COVID.Vaccinations] vac
     On dea.location = vac.location
	 and dea.date = vac.date
--Where dea.continent is not null
--Order by 2, 3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store date for later visualizations

Create View PercentPopulationVaccinated2 as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [PortfolioProject.COVID]..[COVID.Deaths] dea
Join [PortfolioProject.COVID]..[COVID.Vaccinations] vac
     On dea.location = vac.location
	 and dea.date = vac.date
Where dea.continent is not null
--Order by 2, 3


Select *
From PercentPopulationVaccinated2