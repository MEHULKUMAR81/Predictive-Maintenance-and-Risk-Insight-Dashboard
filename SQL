create table Bronze_layer (
UID int,
ProductID varchar(50),
P_Type   varchar(50),
air_temp decimal(10,2),
process_temp decimal(10,2),
rot_speed int,
Torque decimal(10,2),
tool_wear decimal(10,2),
Target int,
Failure_type varchar(50)
)

=====================================================================================================================
TRUNCATE TABLE Bronze_layer;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.6/Uploads/predictive maintenance/predictive_maintenance.csv'
INTO TABLE Bronze_layer
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@UID,@ProductID,@P_Type,@air_temp,@process_temp,@rot_speed,@Torque,@tool_wear,@Target,@Failure_type)
SET
UID = NULLIF(@UID,''),
ProductID = NULLIF(@ProductID,''),
P_Type = NULLIF(@P_Type,''),
air_temp = NULLIF(@air_temp,''),
process_temp = NULLIF(@process_temp,''),
rot_speed = NULLIF(@rot_speed,''),
Torque = NULLIF(@Torque,''),
tool_wear = NULLIF(@tool_wear,''),
Target = NULLIF(@Target,''),
Failure_Type=NULLIF(@Failure_Type,'');
==========================================================================================================================
drop table if exists  silver_layer;
create table silver_layer as 
select 
UID,
substring(ProductID,2,length(ProductID)) as ProductID,
P_type,
case 
when P_type ='M' then 'Medium Quality'
when P_type ='L' then 'LowQuality'
when P_type ='H' then 'High Quality'
end as product_quality,
air_temp,
process_temp,
rot_speed,
Torque,
tool_wear,
Target,
Failure_type
from bronze_layer
=============================================================================================================================
select 
min(tool_wear) as min_tool_wear,
max(tool_wear) as max_tool_wear,
avg(tool_wear) as avg_tool_wear,
sum(case when Target ='1' then 1 else 0 end ) as failures 
from silver_layer
group by tool_wear 
order by failures desc

================================================================================================================================

DROP TABLE IF EXISTS gold_layer;

CREATE TABLE gold_layer AS
WITH ranked AS (
    SELECT
        *,
        NTILE(3) OVER (ORDER BY Torque) AS torque_group,
        NTILE(3) OVER (ORDER BY tool_wear) AS wear_group,
        NTILE(3) OVER (ORDER BY process_temp - air_temp) AS temp_diff_group
    FROM silver_layer
)

SELECT
    UID,
    ProductID,
    P_Type,

    air_temp,
    process_temp,
    rot_speed,
    Torque,
    tool_wear,
    Target,
    process_temp - air_temp AS temp_diff,
    Torque * rot_speed AS load_index,
    round((Torque * rot_speed * 2 * 3.14159) / 60,2) AS power_watts,

    CASE
        WHEN torque_group = 1 THEN 'Low Torque'
        WHEN torque_group = 2 THEN 'Medium Torque'
        ELSE 'High Torque'
    END AS torque_bucket,

    CASE
        WHEN wear_group = 1 THEN 'Low Wear'
        WHEN wear_group = 2 THEN 'Medium Wear'
        ELSE 'High Wear'
    END AS wear_zone,

    CASE
        WHEN temp_diff_group = 1 THEN 'Low Temp Difference'
        WHEN temp_diff_group = 2 THEN 'Medium Temp Difference'
        ELSE 'High Temp Difference'
    END AS temp_diff_zone,

    CASE
        WHEN Target = 1 THEN 'Failed'
        ELSE 'Normal'
    END AS machine_status

FROM ranked
order by UID asc
