--在漏检问题解决的基础上将机动车不同路径选择的问题也解决,将各车辆D2的稳定性系数提取出来
CREATE TABLE STABLE_RATIO_D2_NEW
AS
SELECT CAR_NUM , DEV_ID_1_D_2_P , DEV_ID_2_D_1_P , STABLE_NUM1 , same_place_num ,STABLE_NUM2, STABLE_NUM2 / 21 AS STABLE_RATIO
FROM
( --最终的解决漏检和不同路径选择的表格
select CAR_NUM , DEV_ID_1_D_2_P , DEV_ID_2_D_1_P , STABLE_NUM1 , same_place_num , 
case
    when DEV_ID_1_D_2_P != DEV_ID_2_D_1_P THEN  nvl(STABLE_NUM1,0) + nvl(same_place_num , 0)
    else nvl(STABLE_NUM1,0) end
as STABLE_NUM2 

FROM
( --得到所有车辆的首次被检测第二大概率点的被检测次数和第二次被检侧最大概率点的被检测次数
select first_place_second_possible2.same_place_num , first_place_second_possible2.DEV_ID as DEV_ID_1_D_2_P, 
deal_with_unget.CAR_NUM , deal_with_unget.STABLE_NUM1 , deal_with_unget.DEV_ID AS DEV_ID_2_D_1_P
FROM
(
select *
FROM
(--将第一次被检测到的第二大概率点得到,并限制阈值筛选,仅筛选出工作日被剪次数大于等于3天的
Select *
from
(  --提取出每辆车在该月各个首次被检测最大概率点,第二大概率点,第二次被检测最大概率点
SELECT CAR_NUM , DEV_ID , DETECTED_TIME , same_place_num , 
row_number() Over(Partition By first_second_place_times.Car_Num , first_second_place_times.DETECTED_TIME
 Order By first_second_place_times.same_place_num DESC , first_second_place_times.DEV_ID DESC) same_place_num_order
FROM(--提取出每辆车在该月各个首次被检测地点的次数和各个第二次被检测地点的次数

SELECT CAR_NUM , DEV_ID , DETECTED_TIME , COUNT(*) AS same_place_num
FROM(--每天早出行区间第一次被检测和第二次被检测记录合并成的临时表

(SELECT * FROM 
(Select HZ0601v.Dev_Id , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date DESC) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.Dev_Id , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date DESC) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.Dev_Id , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date DESC) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.Dev_Id , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date DESC) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.Dev_Id , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date DESC) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.Dev_Id , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date DESC) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.Dev_Id , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date DESC) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.Dev_Id , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date DESC) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.Dev_Id , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date DESC) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.Dev_Id , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date DESC) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.Dev_Id , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date DESC) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.Dev_Id , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date DESC) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.Dev_Id , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date DESC) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.Dev_Id , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date DESC) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.Dev_Id , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date DESC) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.Dev_Id , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date DESC) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.Dev_Id , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date DESC) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.Dev_Id , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date DESC) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.Dev_Id , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date DESC) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.Dev_Id , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date DESC) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.Dev_Id , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date DESC) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)
) first_second_place_all_day --每天早出行区间第一次被检测和第二次被检测记录合并成的临时表
group by CAR_NUM , DEV_ID , DETECTED_TIME
) first_second_place_times   --提取出每辆车在该月各个首次被检测地点的次数和各个第二次被检测地点的次数
) first_second_possible_place  --提取出每辆车在该月各个首次被检测最大概率点,第二大概率点,第二次被检测最大概率点
where ((first_second_possible_place.same_place_num_order = 1 or first_second_possible_place.same_place_num_order = 2)
and first_second_possible_place.Detected_Time = 1) 
or 
(first_second_possible_place.same_place_num_order = 1 
and first_second_possible_place.Detected_Time = 2) 
) first_place_second_possible  --将第一次被检测到的第二大概率点得到,并限制阈值筛选,仅筛选出工作日被剪次数大于等于3天的
where Detected_Time = 1 and same_place_num_order = 2 and same_place_num >= 3
) first_place_second_possible2


right outer join 

( --解决漏检问题后的表

--得到解决漏检问题后的CAR_NUM , STABLE_NUM1 , DEV_ID(第二次被检测到的最大概率点)
select deal_with_missing.CAR_NUM , deal_with_missing.STABLE_NUM1 , sec_detec_first_poss.DEV_ID
FROM

( --解决漏检问题之后的表
--将漏检问题解决
SELECT CAR_NUM , COUNT(*) AS STABLE_NUM1
FROM
(  --各车辆首次被检测地点是首次最大概率点或第二次最大概率点
select first_place_all_day.CAR_NUM , first_place_all_day.DEV_ID 
FROM
(  ----该临时表包含第一次被检测的最大概率点和第二次被检测的最大概率点,并且去重了
SELECT CAR_NUM , DEV_ID
FROM  
(  --该临时表包含第一次被检测的最大概率点和第二次被检测的最大概率点
select *
FROM
(
Select *
from
(  --提取出每辆车在该月各个首次被检测最大概率点,第二大概率点,第二次被检测最大概率点
SELECT CAR_NUM , DEV_ID , DETECTED_TIME , same_place_num , 
row_number() Over(Partition By first_second_place_times.Car_Num , first_second_place_times.DETECTED_TIME
 Order By first_second_place_times.same_place_num DESC, first_second_place_times.DEV_ID DESC) same_place_num_order
FROM(--提取出每辆车在该月各个首次被检测地点的次数和各个第二次被检测地点的次数

SELECT CAR_NUM , DEV_ID , DETECTED_TIME , COUNT(*) AS same_place_num
FROM(--每天早出行区间第一次被检测和第二次被检测记录合并成的临时表

(SELECT * FROM 
(Select HZ0601v.Dev_Id , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date DESC) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.Dev_Id , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date DESC) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.Dev_Id , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date DESC) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.Dev_Id , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date DESC) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.Dev_Id , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date DESC) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.Dev_Id , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date DESC) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.Dev_Id , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date DESC) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.Dev_Id , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date DESC) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.Dev_Id , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date DESC) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.Dev_Id , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date DESC) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.Dev_Id , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date DESC) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.Dev_Id , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date DESC) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.Dev_Id , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date DESC) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.Dev_Id , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date DESC) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.Dev_Id , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date DESC) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.Dev_Id , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date DESC) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.Dev_Id , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date DESC) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.Dev_Id , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date DESC) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.Dev_Id , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date DESC) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.Dev_Id , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date DESC) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.Dev_Id , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date DESC) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)
) first_second_place_all_day --每天早出行区间第一次被检测和第二次被检测记录合并成的临时表
group by CAR_NUM , DEV_ID , DETECTED_TIME
) first_second_place_times   --提取出每辆车在该月各个首次被检测地点的次数和各个第二次被检测地点的次数
) first_second_possible_place  --提取出每辆车在该月各个首次被检测最大概率点,第二大概率点,第二次被检测最大概率点
where ((first_second_possible_place.same_place_num_order = 1 or first_second_possible_place.same_place_num_order = 2)
and first_second_possible_place.Detected_Time = 1) 
or 
(first_second_possible_place.same_place_num_order = 1 
and first_second_possible_place.Detected_Time = 2) 
)  first_second_possible_place2 
WHERE same_place_num_order = 1
)  first_second_possible_place3  --该临时表包含第一次被检测的最大概率点和第二次被检测的最大概率点
GROUP BY CAR_NUM , DEV_ID
)first_second_possible_place4  --该临时表包含第一次被检测的最大概率点和第二次被检测的最大概率点,并且去重了


inner join


(  --所有天的首次被检测地点所在行
(SELECT * FROM 
(Select HZ0601v.Dev_Id , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date DESC) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0602v.Dev_Id , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date DESC) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0603v.Dev_Id , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date DESC) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0606v.Dev_Id , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date DESC) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.Dev_Id , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date DESC) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0608v.Dev_Id , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date DESC) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.Dev_Id , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date DESC) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0613v.Dev_Id , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date DESC) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0614v.Dev_Id , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date DESC) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0615v.Dev_Id , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date DESC) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0616v.Dev_Id , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date DESC) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0617v.Dev_Id , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date DESC) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0620v.Dev_Id , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date DESC) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0621v.Dev_Id , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date DESC) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.Dev_Id , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date DESC) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0623v.Dev_Id , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date DESC) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0624v.Dev_Id , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date DESC) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.Dev_Id , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date DESC) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0628v.Dev_Id , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date DESC) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0629v.Dev_Id , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date DESC) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 )

UNION ALL

(SELECT * FROM 
(Select HZ0630v.Dev_Id , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date DESC) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)
) first_place_all_day   --所有天的首次被检测地点所在行

on (first_second_possible_place4.CAR_NUM = first_place_all_day.CAR_NUM 
AND first_second_possible_place4.DEV_ID = first_place_all_day.DEV_ID )
) first_place_work  --各车辆首次被检测地点是首次最大概率点或第二次最大概率点
group by CAR_NUM
) deal_with_missing




left outer join




(   --每辆车第二次被检测到的最大概率点dev_id
Select *
from
(  --提取出每辆车在该月第二次被检测到的最大概率点
SELECT CAR_NUM , DEV_ID , DETECTED_TIME , same_place_num , 
row_number() Over(Partition By first_second_place_times.Car_Num , first_second_place_times.DETECTED_TIME
 Order By first_second_place_times.same_place_num DESC , first_second_place_times.DEV_ID DESC) same_place_num_order
FROM(--提取出每辆车在该月各个首次被检测地点的次数和各个第二次被检测地点的次数

SELECT CAR_NUM , DEV_ID , DETECTED_TIME , COUNT(*) AS same_place_num
FROM(--每天早出行区间第一次被检测和第二次被检测记录合并成的临时表

(SELECT * FROM 
(Select HZ0601v.Dev_Id , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date DESC) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.Dev_Id , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date DESC) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.Dev_Id , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date DESC) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.Dev_Id , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date DESC) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.Dev_Id , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date DESC) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.Dev_Id , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date DESC) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.Dev_Id , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date DESC) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.Dev_Id , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date DESC) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.Dev_Id , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date DESC) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.Dev_Id , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date DESC) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.Dev_Id , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date DESC) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.Dev_Id , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date DESC) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.Dev_Id , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date DESC) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.Dev_Id , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date DESC) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.Dev_Id , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date DESC) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.Dev_Id , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date DESC) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.Dev_Id , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date DESC) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.Dev_Id , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date DESC) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.Dev_Id , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date DESC) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.Dev_Id , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date DESC) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.Dev_Id , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date DESC) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1 or DETECTED_TIME = 2)
) first_second_place_all_day --每天早出行区间第一次被检测和第二次被检测记录合并成的临时表
group by CAR_NUM , DEV_ID , DETECTED_TIME
) first_second_place_times   --提取出每辆车在该月各个首次被检测地点的次数和各个第二次被检测地点的次数
) first_second_possible_place  --提取出每辆车在该月各个首次被检测最大概率点,第二大概率点,第二次被检测最大概率点
where 
(first_second_possible_place.same_place_num_order = 1 
and first_second_possible_place.Detected_Time = 2) 
) sec_detec_first_poss

on deal_with_missing.CAR_NUM = sec_detec_first_poss.CAR_NUM
) deal_with_unget

on first_place_second_possible2.CAR_NUM = deal_with_unget.CAR_NUM
) deal_with_unget_multi_way --得到所有车辆的首次被检测最大概率点的被检测次数和第一次被检侧第二大概率点的被检测次数
) deal_with_unget_multi_way2 --最终的解决漏检和不同路径选择的表格










