create table combined_dataset_newyork_bike_ride(
	select * from new_york_dec_jan nydj 
	union all
	select * from new_york_jan_feb nyjf 
	union all
	select * from new_york_feb_mar nyfm 
	union all
	select * from new_york_mar_apr nyma 
	union all
	select * from new_york_apr_may nyam 
	union all
	select * from new_york_may_jun nymj 
	union all
)


CREATE TABLE combined_dataset AS
SELECT * FROM new_york_dec_jan nydj  LIMIT 0;

INSERT INTO combined_dataset SELECT * FROM new_york_jan_feb ;
INSERT INTO combined_dataset SELECT * FROM new_york_feb_mar ;
INSERT INTO combined_dataset SELECT * FROM new_york_mar_apr ;
INSERT INTO combined_dataset SELECT * FROM new_york_apr_may ;
INSERT INTO combined_dataset SELECT * FROM new_york_may_jun ;

select * from combined_dataset 

--Visualize the distribution of ride durations

-- Convert string columns to timestamps
ALTER TABLE combined_dataset
    ALTER COLUMN started_at TYPE TIMESTAMP USING started_at::timestamp,
    ALTER COLUMN ended_at TYPE TIMESTAMP USING ended_at::timestamp;

-- Calculate ride duration
SELECT ride_id, ended_at - started_at AS ride_duration
FROM combined_dataset;



--Explore the distribution of rideable types and member vs. casual riders

-- counting type of bike
SELECT rideable_type, COUNT(*) AS ride_count
FROM combined_dataset
GROUP BY rideable_type;

-- counting member or casual 
SELECT member_casual, COUNT(*) AS ride_count
FROM combined_dataset
GROUP BY member_casual;


--Analyze the usage patterns based on different time intervals

SELECT date_trunc('day', started_at) AS ride_date, COUNT(*) AS ride_count
FROM combined_dataset
GROUP BY ride_date
ORDER BY ride_date;



select * from combined_dataset 


--Geospatial Analysis
--Plot the start and end locations of rides

SELECT start_lat, start_lng, start_station_name
FROM combined_dataset;

SELECT end_lat, end_lng, end_station_name
FROM combined_dataset


--User Behavior Analysis:
--Compare the usage patterns between casual riders and members

SELECT member_casual, AVG(ended_at - started_at) AS avg_ride_duration
FROM combined_dataset
GROUP BY member_casual;


--Temporal Analysis
--Identify peak hours/days for rides

SELECT EXTRACT(hour FROM started_at) AS hour_of_day, COUNT(*) AS ride_count
FROM combined_dataset
GROUP BY hour_of_day
ORDER BY hour_of_day;

SELECT EXTRACT(dow FROM started_at) AS day_of_week, COUNT(*) AS ride_count
FROM combined_dataset
GROUP BY day_of_week
ORDER BY day_of_week;














