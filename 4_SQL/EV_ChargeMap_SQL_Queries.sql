USE EV_ChargeMap;

-- 1. View total number of charging stations
SELECT COUNT(*) AS Total_Charging_Stations
FROM ev_charging_stations;


-- 2. View total charging points
SELECT SUM(charging_points) AS Total_Charging_Points
FROM ev_charging_stations;


-- 3. Count operational stations
SELECT COUNT(*) AS Operational_Stations
FROM ev_charging_stations
WHERE status = 'Operational';


-- 4. Calculate operational rate
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Operational' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS Operational_Rate_Percent
FROM ev_charging_stations;


-- 5. Calculate active charging points
SELECT
    SUM(Active_Charging_Points) AS Active_Charging_Points
FROM ev_charging_stations;


-- 6. Status-wise station and charging point analysis
SELECT
    status,
    COUNT(*) AS Station_Count,
    SUM(charging_points) AS Charging_Points
FROM ev_charging_stations
GROUP BY status
ORDER BY Charging_Points DESC;


-- 7. State-wise charging infrastructure
SELECT
    state,
    COUNT(*) AS Station_Count,
    SUM(charging_points) AS Charging_Points
FROM ev_charging_stations
GROUP BY state
ORDER BY Charging_Points DESC;


-- 8. Top 10 charging stations by capacity
SELECT
    station_id,
    station_name,
    state,
    charging_points,
    status
FROM ev_charging_stations
ORDER BY charging_points DESC
LIMIT 10;


-- 9. High-capacity stations / anomaly analysis
SELECT
    station_id,
    station_name,
    state,
    charging_points,
    status
FROM ev_charging_stations
WHERE charging_points > 3.5
ORDER BY charging_points DESC;


-- 10. Operational vs non-operational stations
SELECT
    CASE
        WHEN status = 'Operational' THEN 'Operational'
        ELSE 'Non-Operational'
    END AS Operational_Category,
    COUNT(*) AS Station_Count,
    SUM(charging_points) AS Charging_Points
FROM ev_charging_stations
GROUP BY Operational_Category;


-- 11. Average charging points per station
SELECT
    ROUND(AVG(charging_points), 2) AS Average_Charging_Points
FROM ev_charging_stations;


-- 12. Minimum and maximum charging capacity
SELECT
    MIN(charging_points) AS Minimum_Charging_Points,
    MAX(charging_points) AS Maximum_Charging_Points
FROM ev_charging_stations;


-- 13. Charging stations with active charging points
SELECT
    COUNT(*) AS Stations_With_Active_Points
FROM ev_charging_stations
WHERE Active_Charging_Points > 0;


-- 14. Check duplicate station IDs
SELECT
    station_id,
    COUNT(*) AS Duplicate_Count
FROM ev_charging_stations
GROUP BY station_id
HAVING COUNT(*) > 1;


-- 15. Data quality check for missing coordinates
SELECT
    COUNT(*) AS Missing_Coordinates
FROM ev_charging_stations
WHERE latitude IS NULL
   OR longitude IS NULL;
