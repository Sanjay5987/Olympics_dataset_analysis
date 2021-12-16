--Looking at raw dataset

select * 
from olympic_games..results

--Adding a column for MedalCount and assigning Values
alter table olympic_games..results
add MedalCount numeric(38) ;

update olympic_games..results
set MedalCount = 0
where Medals = 'NA'

update olympic_games..results
set MedalCount = 1
where Medals in ('Gold','Silver','Bronze')

--Splitting Games colummn into Year and Season seperately

alter table olympic_games..results
add Year numeric(38)

update olympic_games..results
set Year = Left(Games,charindex(' ',Games))
from olympic_games..results

alter table olympic_games..results
add Season nvarchar(255)

update olympic_games..results
set Season = Right(Games,charindex(' ',Games)+1)
from olympic_games..results


--Looking at gender wise Total medals won

select Sex, sum(MedalCount) as TotalMedalsCount
from olympic_games..results
group by Sex

--Looking at Total medals won on basis of cities where games were organised

select City, sum(MedalCount) as TotalMedalsCount
from olympic_games..results
group by City
order by TotalMedalsCount desc

--Looking at Youngest and oldest Players who got gold

select Name,Year,Season, Age, Medals ,Sport
from olympic_games..results
where (Age <= 13 or Age >=64) and (Medals = 'Gold')
order by Age asc

--Games-wise Medal distribution
Select sport,Medals, sum(MedalCount) as TotalMedalCount
from olympic_games..results
where Medals <> 'NA'
group by Medals, Sport
order by Medals desc

--Looking at Country-wise Total Medal distribution 
Select NOC, sum(MedalCount) as TotalMedalCount
from olympic_games..results
group by NOC
Having sum(MedalCount) <> 0
order by TotalMedalCount desc

--Country-wise gold medals
select NOC, Medals, sum(MedalCount) as TotalMedalCount
from olympic_games..results
where Medals <> 'NA' and Medals = 'Gold'
group by NOC, Medals
order by TotalMedalCount desc

--Year-wise Medal distribution
Select Year, Medals, sum(MedalCount) as TotalMedalCount
from olympic_games..results
where Medals <> 'NA'
Group by Year, Medals
order by Year desc

--Medal achievements of india
select  Year,Season, Medals, sum(MedalCount) as TotalMedalCount
from olympic_games..results
where NOC = 'IND' and Medals <> 'NA'
group by Medals, Year,Season
order by Year desc

--Total Year-wise gold-Count of india
select  Year,Season, Medals, sum(MedalCount) as TotalMedalCount
from olympic_games..results
where (NOC = 'IND') and (Medals <> 'NA') and (Medals = 'Gold')
group by Medals, Year,Season
order by Year desc

