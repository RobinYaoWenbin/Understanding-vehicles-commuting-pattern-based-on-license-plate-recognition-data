-- 通勤车辆在玉古路浙大路北(DEV_ID:2148383)一天的流量变化情况(时间窗取为半个小时)
--2016年6月15日作为case来分析,单位为veh/hour
select h,m,(count(*)*2) as freq
from
(
select hz0615v.CAR_NUM,  substr(To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss'), 12 ,2) as h, 
  floor(to_number(substr(To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss'), 15 ,2))/30) as m,To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss')
from hz0615v
inner join commutingvehicle  com
on hz0615v.CAR_NUM = com.CAR_NUM
where  DEV_ID = 2148383
) commuttab
group by h,m
order by h,m


--------------------------------------------------------------------------------------------------------

-- 所有车辆在玉古路浙大路北(DEV_ID:2148383)一天的流量变化情况(时间窗取为半个小时)
--2016年6月15日作为case来分析,单位为veh/hour
select h,m,(count(*)*2) as freq
from
(
select CAR_NUM,  substr(To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss'), 12 ,2) as h, 
  floor(to_number(substr(To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss'), 15 ,2))/30) as m,To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss')
from hz0615v
where  DEV_ID = 2148383
) vehtab
group by h,m
order by h,m