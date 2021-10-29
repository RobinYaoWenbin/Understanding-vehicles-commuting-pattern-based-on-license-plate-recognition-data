--note:2016年6月的工作日日期为:1,2,3,6,7,8,12,13,14,15,16,17,20,21,22,23,24,27,28,29,30
--节假日:4,5,9,10,11,18,19,25,26

--统计下2016年6月工作日通勤车的被检测频次
select COUNT(*) AS DETECTEDNUM , (COUNT(*) / 21) AS AVG_DETECTEDNUM
FROM
( --限行区内所有工作日的被检测记录
(select *
from HZ0601V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0602V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0603V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0606V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0607V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0608V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0612V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0613V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0614V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0615V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0616V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0617V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0620V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0621V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0622V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0623V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0624V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0627V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0628V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0629V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))

UNION ALL

(select *
from HZ0630V
where RES = 1 AND CAR_NUM in (select CAR_NUM FROM commutingvehicle))
) COMDATA


--统计2016年6月所有车辆在杭州市限行区内的记录条数
select count(*) as DETECTEDNUM , (count(*) / 21) as AVG_DETECTEDNUM
FROM
(  --该临时表为所有车辆在工作日的所有记录
(select *
from HZ0601V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0602V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0603V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0606V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0607V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0608V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0612V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0613V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0614V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0615V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0616V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0617V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0620V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0621V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0622V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0623V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0624V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0627V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0628V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0629V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))

UNION ALL

(select *
from HZ0630V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT))
) AllVehicleData


--统计通勤车辆在早晚高峰的车辆数和被检测频次
select COUNT(CAR_NUM) AS DISCARNUM , (COUNT(CAR_NUM)/21) AS AVG_DISCARNUM ,
    SUM(freq) AS TotalNum , (SUM(freq) / 21) AS Avg_TotalNum 
from
( --杭州市限行区内早晚高峰通勤车记录
(select CAR_NUM , count(*) as freq
from 
HZ0601V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 06:30:00' And '2016/06/01 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0602V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 06:30:00' And '2016/06/02 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0603V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 06:30:00' And '2016/06/03 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0606V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 06:30:00' And '2016/06/06 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0607V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 06:30:00' And '2016/06/07 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0608V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 06:30:00' And '2016/06/08 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0612V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 06:30:00' And '2016/06/12 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0613V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 06:30:00' And '2016/06/13 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0614V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 06:30:00' And '2016/06/14 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0615V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 06:30:00' And '2016/06/15 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0616V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 06:30:00' And '2016/06/16 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0617V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 06:30:00' And '2016/06/17 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0620V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 06:30:00' And '2016/06/20 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0621V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 06:30:00' And '2016/06/21 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0622V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 06:30:00' And '2016/06/22 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0623V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 06:30:00' And '2016/06/23 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0624V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 06:30:00' And '2016/06/24 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0627V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 06:30:00' And '2016/06/27 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0628V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 06:30:00' And '2016/06/28 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0629V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 06:30:00' And '2016/06/29 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , count(*) as freq
from 
HZ0630V
WHERE RES = 1 AND CAR_NUM IN (select * FROM commutingvehicle) 
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 06:30:00' And '2016/06/30 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00') 
group by CAR_NUM)
) CominPeakData


--统计所有车辆在早晚高峰的车辆数和被检测频次
select COUNT(CAR_NUM) AS DISCARNUM , (COUNT(CAR_NUM)/21) AS AVG_DISCARNUM ,
    SUM(freq) AS TotalNum , (SUM(freq) / 21) AS Avg_TotalNum 
from
( --杭州市限行区内早晚高峰所有车辆记录
(select CAR_NUM , COUNT(*) AS freq
from 
HZ0601V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 06:30:00' And '2016/06/01 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0602V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 06:30:00' And '2016/06/02 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0603V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 06:30:00' And '2016/06/03 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0606V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 06:30:00' And '2016/06/06 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0607V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 06:30:00' And '2016/06/07 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0608V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 06:30:00' And '2016/06/08 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0612V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 06:30:00' And '2016/06/12 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0613V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 06:30:00' And '2016/06/13 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0614V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 06:30:00' And '2016/06/14 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0615V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 06:30:00' And '2016/06/15 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0616V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 06:30:00' And '2016/06/16 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0617V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 06:30:00' And '2016/06/17 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0620V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 06:30:00' And '2016/06/20 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0621V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 06:30:00' And '2016/06/21 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0622V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 06:30:00' And '2016/06/22 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0623V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 06:30:00' And '2016/06/23 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0624V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 06:30:00' And '2016/06/24 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0627V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 06:30:00' And '2016/06/27 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0628V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 06:30:00' And '2016/06/28 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0629V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 06:30:00' And '2016/06/29 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00') 
group by CAR_NUM)

union all

(select CAR_NUM , COUNT(*) AS freq
from 
HZ0630V
WHERE RES = 1 AND CAR_NUM in (select CAR_NUM FROM COMMUVEHFEAT)
        and (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 06:30:00' And '2016/06/30 10:30:00' 
        or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00') 
group by CAR_NUM)
) CominPeakData

