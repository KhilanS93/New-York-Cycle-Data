select *
from CycleData.dbo.NY_citybikes_stations$

select *
from CycleData..NY_citybikes_trips$

--Bikes departing from and ending to which station and who are the users of those bikes

select st.station_id, st. num_bikes_available, st.name, tr.end_station_id,tr.end_station_name,tr.tripduration, tr.usertype , tr.gender, 2022 - tr.birth_year as age
from CycleData..NY_citybikes_stations$ st
join CycleData..NY_citybikes_trips$ tr
	on st.name = tr.start_station_name
	and st.station_id = tr.start_station_id
where tr.birth_year is not null
order by st.station_id

-- how many bike avaliable at each stations

select station_id, num_bikes_available
from CycleData.dbo.NY_citybikes_stations$

--checking for duplicates

with rownumCTE as (
select *,
	ROW_NUMBER() over (
	partition by tripduration,
				starttime,
				stoptime,
				bikeID
				order by bikeid)
					row_num
from CycleData..NY_citybikes_trips$
)
select *
from rownumCTE
where row_num >1


order by bikeid

--Top 10 bike stations with highest number of trips



select top 10 start_station_ID, count(end_station_ID)as numoftrip 
from CycleData..NY_citybikes_trips$
group by start_station_id
order by numoftrip desc







