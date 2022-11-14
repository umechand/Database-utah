drop table if exists air_quality_data;

create table air_quality_data(
state_name varchar(100),
country_name varchar(100),
state_code varchar(10),
country_code integer,
air_quality_date date,
aqi integer,
category varchar(100),
defining_parameter varchar(100),
defining_site varchar(100),
number_of_sites_reporting integer);

copy air_quality_data from '/Users/u1436376/Downloads/daily_aqi_by_county_2001.csv' with csv header;
copy air_quality_data from '/Users/u1436376/Downloads/daily_aqi_by_county_2011.csv' with csv header;
copy air_quality_data from '/Users/u1436376/Downloads/daily_aqi_by_county_2021.csv' with csv header;

select * from air_quality_data;

select extract (year from air_quality_date) from air_quality_data  group by extract (year from air_quality_date);

select extract (month from air_quality_date) from air_quality_data  
where extract (year from air_quality_date) = 2001
group by extract (month from air_quality_date) ;



--Q1 What is the average AQI (air quality index) by year by season (winter, spring, summer, fall)?
select avg(AQI), extract (year from air_quality_date),
(case when extract (month from air_quality_date) in (1,2,3) then 'WINTER'
	  when extract (month from air_quality_date) in (4,5,6) then 'SPRING'
	  when extract (month from air_quality_date) in (7,8,9) then 'SUMMER'
	  when extract (month from air_quality_date) in (10,11,12) then 'AUTUMN'
 end) as season
 from air_quality_data
 group by extract (year from air_quality_date),
 (case when extract (month from air_quality_date) in (1,2,3) then 'WINTER'
	  when extract (month from air_quality_date) in (4,5,6) then 'SPRING'
	  when extract (month from air_quality_date) in (7,8,9) then 'SUMMER'
	  when extract (month from air_quality_date) in (10,11,12) then 'AUTUMN'
 end);

--What were the top 10 locations with worst AQI in each year?  
select country_name, extract (year from air_quality_date), max(AQI)
from air_quality_data
group by extract (year from air_quality_date), 1
having extract (year from air_quality_date) = 2001
order by max(aqi) desc
limit 10;
select country_name, extract (year from air_quality_date), max(AQI)
from air_quality_data
group by extract (year from air_quality_date), 1
having extract (year from air_quality_date) = 2011
order by max(aqi) desc
limit 10;
select country_name, extract (year from air_quality_date), max(AQI)
from air_quality_data
group by extract (year from air_quality_date), 1
having extract (year from air_quality_date) = 2021
order by max(aqi) desc
limit 10;

--What were the top 10 locations that had the best improvement over 20 years, from the first year to the most recent year?  
--What were the 10 locations with the worst decline over 20 years?

select a.country_name, (aqi_first_year - aqi_recent_year) as aqi_imp from(
select country_name, avg(aqi) aqi_first_year from air_quality_data 
where extract(year from air_quality_date) = 2001
group by country_name ) a 
inner join 
(select country_name, avg(aqi) aqi_recent_year from air_quality_data 
where extract(year from air_quality_date) = 2021
group by country_name ) b
on a.country_name = b.country_name
order by aqi_imp desc 
limit 10;

select a.country_name, (aqi_first_year - aqi_recent_year) as aqi_imp from(
select country_name, avg(aqi) aqi_first_year from air_quality_data 
where extract(year from air_quality_date) = 2001
group by country_name ) a 
inner join 
(select country_name, avg(aqi) aqi_recent_year from air_quality_data 
where extract(year from air_quality_date) = 2021
group by country_name ) b
on a.country_name = b.country_name
order by aqi_imp  
limit 10;

--In Utah counties, how many days of "Unhealthy" air did we have in each year?  Is it improving?  

select count(extract(day from air_quality_date)) as no_of_days
from air_quality_data where state_name='Utah' and category like '%Unhealthy%' and extract(year from air_quality_date) = 2001;

select count(extract(day from air_quality_date)) as no_of_days
from air_quality_data where state_name='Utah' and category like '%Unhealthy%' and extract(year from air_quality_date) = 2011;

select count(extract(day from air_quality_date)) as no_of_days
from air_quality_data where state_name='Utah' and category like '%Unhealthy%' and extract(year from air_quality_date) = 2021;


--In Salt Lake County, which months have the most "Unhealthy" days?  Has that changed in 20 years?

select count(air_quality_date),
(case when extract (month from air_quality_date) = 1 then 'January'
	  when extract (month from air_quality_date) = 2 then 'Febuary'
	  when extract (month from air_quality_date) = 3 then 'March'
	  when extract (month from air_quality_date) = 4 then 'April'
	  when extract (month from air_quality_date) = 5 then 'May'
	  when extract (month from air_quality_date) = 6 then 'June'
	  when extract (month from air_quality_date) = 7 then 'July'
	  when extract (month from air_quality_date) = 8 then 'August'
	  when extract (month from air_quality_date) = 9 then 'September'
	  when extract (month from air_quality_date) = 10 then 'October'
	  when extract (month from air_quality_date) = 11 then 'November'
	  when extract (month from air_quality_date) = 12 then 'December'
	  end)as month_name
from air_quality_data 
where country_name like '%Salt Lake%' and category like '%Unhealthy%' and extract(year from air_quality_date) = 2001
group by month_name;

select count(air_quality_date),
(case when extract (month from air_quality_date) = 1 then 'January'
	  when extract (month from air_quality_date) = 2 then 'Febuary'
	  when extract (month from air_quality_date) = 3 then 'March'
	  when extract (month from air_quality_date) = 4 then 'April'
	  when extract (month from air_quality_date) = 5 then 'May'
	  when extract (month from air_quality_date) = 6 then 'June'
	  when extract (month from air_quality_date) = 7 then 'July'
	  when extract (month from air_quality_date) = 8 then 'August'
	  when extract (month from air_quality_date) = 9 then 'September'
	  when extract (month from air_quality_date) = 10 then 'October'
	  when extract (month from air_quality_date) = 11 then 'November'
	  when extract (month from air_quality_date) = 12 then 'December'
	  end)as month_name
from air_quality_data 
where country_name like '%Salt Lake%' and category like '%Unhealthy%' and extract(year from air_quality_date) = 2011
group by month_name;


select count(air_quality_date),
(case when extract (month from air_quality_date) = 1 then 'January'
	  when extract (month from air_quality_date) = 2 then 'Febuary'
	  when extract (month from air_quality_date) = 3 then 'March'
	  when extract (month from air_quality_date) = 4 then 'April'
	  when extract (month from air_quality_date) = 5 then 'May'
	  when extract (month from air_quality_date) = 6 then 'June'
	  when extract (month from air_quality_date) = 7 then 'July'
	  when extract (month from air_quality_date) = 8 then 'August'
	  when extract (month from air_quality_date) = 9 then 'September'
	  when extract (month from air_quality_date) = 10 then 'October'
	  when extract (month from air_quality_date) = 11 then 'November'
	  when extract (month from air_quality_date) = 12 then 'December'
	  end)as month_name
from air_quality_data 
where country_name like '%Salt Lake%' and category like '%Unhealthy%' and extract(year from air_quality_date) = 2021
group by month_name;






