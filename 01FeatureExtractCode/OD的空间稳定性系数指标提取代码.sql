--本代码用来提取车辆的OD稳定性系数

--建立各车辆的O1,D1,O2,D2视图
CREATE VIEW CAR_OD_ALL
AS
select CAR_O1.CAR_NUM , CAR_O1.XXYY AS O1, CAR_O2.XXYY AS O2 , CAR_D1.XXYY AS D1 , CAR_D2.XXYY AS D2
FROM
(
--各车辆早出行区间O点提取
Select CAR_NUM , XXYY
FROM
(  --该临时表为每辆车首次出现地点以及相应的次数以及其排序
SELECT CAR_NUM , XXYY , same_place_num,
row_number() Over(Partition By temp2.CAR_NUM Order By temp2.same_place_num DESC) same_place_num_order
FROM
(--该临时表为每辆车首次出现地点以及相应的次数
SELECT CAR_NUM , XXYY , COUNT(*) as same_place_num
FROM (--该临时表temp1将所有工作日所有车辆首次被检测的那条记录取出
(SELECT * FROM 
(Select HZ0601v.DEV_ID , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date Asc) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 06:30:00' And '2016/06/01 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.DEV_ID , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date Asc) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 06:30:00' And '2016/06/02 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.DEV_ID , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date Asc) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 06:30:00' And '2016/06/03 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.DEV_ID , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date Asc) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 06:30:00' And '2016/06/06 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.DEV_ID , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date Asc) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 06:30:00' And '2016/06/07 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.DEV_ID , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date Asc) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 06:30:00' And '2016/06/08 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.DEV_ID , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date Asc) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 06:30:00' And '2016/06/12 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.DEV_ID , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date Asc) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 06:30:00' And '2016/06/13 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.DEV_ID , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date Asc) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 06:30:00' And '2016/06/14 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.DEV_ID , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date Asc) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 06:30:00' And '2016/06/15 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.DEV_ID , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date Asc) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 06:30:00' And '2016/06/16 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.DEV_ID , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date Asc) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 06:30:00' And '2016/06/17 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.DEV_ID , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date Asc) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 06:30:00' And '2016/06/20 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.DEV_ID , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date Asc) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 06:30:00' And '2016/06/21 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.DEV_ID , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date Asc) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 06:30:00' And '2016/06/22 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.DEV_ID , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date Asc) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 06:30:00' And '2016/06/23 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.DEV_ID , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date Asc) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 06:30:00' And '2016/06/24 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.DEV_ID , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date Asc) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 06:30:00' And '2016/06/27 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.DEV_ID , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date Asc) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 06:30:00' And '2016/06/28 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.DEV_ID , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date Asc) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 06:30:00' And '2016/06/29 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.DEV_ID , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date Asc) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 06:30:00' And '2016/06/30 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)
) temp1
group by CAR_NUM , XXYY
) temp2
)temp3
where same_place_num_order = 1
) CAR_O1

INNER JOIN 

(
--各车辆晚出行区间O点提取
Select CAR_NUM , XXYY
FROM
(  --该临时表为每辆车首次出现地点以及相应的次数以及其排序
SELECT CAR_NUM , XXYY , same_place_num,
row_number() Over(Partition By temp2.CAR_NUM Order By temp2.same_place_num DESC) same_place_num_order
FROM
(--该临时表为每辆车首次出现地点以及相应的次数
SELECT CAR_NUM , XXYY , COUNT(*) as same_place_num
FROM (--该临时表temp1将所有工作日所有车辆首次被检测的那条记录取出
(SELECT * FROM 
(Select HZ0601v.DEV_ID , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date Asc) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.DEV_ID , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date Asc) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.DEV_ID , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date Asc) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.DEV_ID , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date Asc) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.DEV_ID , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date Asc) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.DEV_ID , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date Asc) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.DEV_ID, HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date Asc) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.DEV_ID , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date Asc) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.DEV_ID , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date Asc) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.DEV_ID , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date Asc) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.DEV_ID , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date Asc) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.DEV_ID , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date Asc) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.DEV_ID , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date Asc) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.DEV_ID , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date Asc) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.DEV_ID , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date Asc) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.DEV_ID , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date Asc) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.DEV_ID , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date Asc) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.DEV_ID , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date Asc) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.DEV_ID , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date Asc) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.DEV_ID , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date Asc) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.DEV_ID , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date Asc) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)
) temp1
group by CAR_NUM , XXYY
) temp2
)temp3
where same_place_num_order = 1
) CAR_O2

ON CAR_O1.CAR_NUM = CAR_O2.CAR_NUM

INNER JOIN

(
--各车辆早出行区间D点提取
Select CAR_NUM , XXYY
FROM
(  --该临时表为每辆车首次出现地点以及相应的次数以及其排序
SELECT CAR_NUM , XXYY , same_place_num,
row_number() Over(Partition By temp2.CAR_NUM Order By temp2.same_place_num DESC) same_place_num_order
FROM
(--该临时表为每辆车首次出现地点以及相应的次数
SELECT CAR_NUM , XXYY , COUNT(*) as same_place_num
FROM (--该临时表temp1将所有工作日所有车辆首次被检测的那条记录取出
(SELECT * FROM 
(Select HZ0601v.DEV_ID , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date DESC) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 06:30:00' And '2016/06/01 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.DEV_ID , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date DESC) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 06:30:00' And '2016/06/02 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.DEV_ID , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date DESC) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 06:30:00' And '2016/06/03 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.DEV_ID , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
HZ0606v.Car_Type , HZ0606v.Xxyy , HZ0606v.Res , HZ0606v.Urban , HZ0606v.Gao , 
HZ0606v.Inin , HZ0606v.Out , HZ0606v.Waiin , HZ0606v.Waiout , 
Row_Number() Over(Partition By HZ0606v.Car_Num Order By HZ0606v.Cap_Date DESC) Detected_Time
From HZ0606v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 06:30:00' And '2016/06/06 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0607v.DEV_ID , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date DESC) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 06:30:00' And '2016/06/07 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.DEV_ID , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
HZ0608v.Car_Type , HZ0608v.Xxyy , HZ0608v.Res , HZ0608v.Urban , HZ0608v.Gao , 
HZ0608v.Inin , HZ0608v.Out , HZ0608v.Waiin , HZ0608v.Waiout , 
Row_Number() Over(Partition By HZ0608v.Car_Num Order By HZ0608v.Cap_Date DESC) Detected_Time
From HZ0608v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 06:30:00' And '2016/06/08 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0612v.DEV_ID , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date DESC) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 06:30:00' And '2016/06/12 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.DEV_ID , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date DESC) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 06:30:00' And '2016/06/13 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.DEV_ID , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date DESC) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 06:30:00' And '2016/06/14 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.DEV_ID , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date DESC) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 06:30:00' And '2016/06/15 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.DEV_ID , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date DESC) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 06:30:00' And '2016/06/16 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.DEV_ID , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date DESC) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 06:30:00' And '2016/06/17 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.DEV_ID , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date DESC) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 06:30:00' And '2016/06/20 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.DEV_ID , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
HZ0621v.Car_Type , HZ0621v.Xxyy , HZ0621v.Res , HZ0621v.Urban , HZ0621v.Gao , 
HZ0621v.Inin , HZ0621v.Out , HZ0621v.Waiin , HZ0621v.Waiout , 
Row_Number() Over(Partition By HZ0621v.Car_Num Order By HZ0621v.Cap_Date DESC) Detected_Time
From HZ0621v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 06:30:00' And '2016/06/21 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0622v.DEV_ID , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date DESC) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 06:30:00' And '2016/06/22 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.DEV_ID , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date DESC) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 06:30:00' And '2016/06/23 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.DEV_ID , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
HZ0624v.Car_Type , HZ0624v.Xxyy , HZ0624v.Res , HZ0624v.Urban , HZ0624v.Gao , 
HZ0624v.Inin , HZ0624v.Out , HZ0624v.Waiin , HZ0624v.Waiout , 
Row_Number() Over(Partition By HZ0624v.Car_Num Order By HZ0624v.Cap_Date DESC) Detected_Time
From HZ0624v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 06:30:00' And '2016/06/24 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0627v.DEV_ID , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date DESC) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 06:30:00' And '2016/06/27 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.DEV_ID , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date DESC) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 06:30:00' And '2016/06/28 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.DEV_ID , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date DESC) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 06:30:00' And '2016/06/29 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.DEV_ID , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date DESC) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 06:30:00' And '2016/06/30 10:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)
) temp1
group by CAR_NUM , XXYY
) temp2
)temp3
where same_place_num_order = 1
) CAR_D1


ON CAR_O1.CAR_NUM = CAR_D1.Car_Num

INNER JOIN

(
--各车辆晚出行区间D点提取
Select CAR_NUM , XXYY
FROM
(  --该临时表为每辆车首次出现地点以及相应的次数以及其排序
SELECT CAR_NUM , XXYY , same_place_num,
row_number() Over(Partition By temp2.CAR_NUM Order By temp2.same_place_num DESC) same_place_num_order
FROM
(--该临时表为每辆车首次出现地点以及相应的次数
SELECT CAR_NUM , XXYY , COUNT(*) as same_place_num
FROM (--该临时表temp1将所有工作日所有车辆首次被检测的那条记录取出
(SELECT * FROM 
(Select HZ0601v.DEV_ID , HZ0601v.Dev_Name , HZ0601v.Car_Num , HZ0601v.Way_Id , HZ0601v.Cap_Date ,
HZ0601v.Car_Type , HZ0601v.Xxyy , HZ0601v.Res , HZ0601v.Urban , HZ0601v.Gao , 
HZ0601v.Inin , HZ0601v.Out , HZ0601v.Waiin , HZ0601v.Waiout , 
row_number() Over(Partition By Hz0601v.Car_Num Order By Hz0601v.Cap_Date DESC) Detected_Time
From Hz0601v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0602v.DEV_ID , HZ0602v.Dev_Name , HZ0602v.Car_Num , HZ0602v.Way_Id , HZ0602v.Cap_Date ,
HZ0602v.Car_Type , HZ0602v.Xxyy , HZ0602v.Res , HZ0602v.Urban , HZ0602v.Gao , 
HZ0602v.Inin , HZ0602v.Out , HZ0602v.Waiin , HZ0602v.Waiout , 
Row_Number() Over(Partition By HZ0602v.Car_Num Order By HZ0602v.Cap_Date DESC) Detected_Time
From HZ0602v 
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0603v.DEV_ID , HZ0603v.Dev_Name , HZ0603v.Car_Num , HZ0603v.Way_Id , HZ0603v.Cap_Date ,
HZ0603v.Car_Type , HZ0603v.Xxyy , HZ0603v.Res , HZ0603v.Urban , HZ0603v.Gao , 
HZ0603v.Inin , HZ0603v.Out , HZ0603v.Waiin , HZ0603v.Waiout , 
Row_Number() Over(Partition By HZ0603v.Car_Num Order By HZ0603v.Cap_Date DESC) Detected_Time
From HZ0603v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0606v.DEV_ID , HZ0606v.Dev_Name , HZ0606v.Car_Num , HZ0606v.Way_Id , HZ0606v.Cap_Date ,
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
(Select HZ0607v.DEV_ID , HZ0607v.Dev_Name , HZ0607v.Car_Num , HZ0607v.Way_Id , HZ0607v.Cap_Date ,
HZ0607v.Car_Type , HZ0607v.Xxyy , HZ0607v.Res , HZ0607v.Urban , HZ0607v.Gao , 
HZ0607v.Inin , HZ0607v.Out , HZ0607v.Waiin , HZ0607v.Waiout , 
Row_Number() Over(Partition By HZ0607v.Car_Num Order By HZ0607v.Cap_Date DESC) Detected_Time
From HZ0607v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0608v.DEV_ID , HZ0608v.Dev_Name , HZ0608v.Car_Num , HZ0608v.Way_Id , HZ0608v.Cap_Date ,
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
(Select HZ0612v.DEV_ID , HZ0612v.Dev_Name , HZ0612v.Car_Num , HZ0612v.Way_Id , HZ0612v.Cap_Date ,
HZ0612v.Car_Type , HZ0612v.Xxyy , HZ0612v.Res , HZ0612v.Urban , HZ0612v.Gao , 
HZ0612v.Inin , HZ0612v.Out , HZ0612v.Waiin , HZ0612v.Waiout , 
Row_Number() Over(Partition By HZ0612v.Car_Num Order By HZ0612v.Cap_Date DESC) Detected_Time
From HZ0612v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0613v.DEV_ID , HZ0613v.Dev_Name , HZ0613v.Car_Num , HZ0613v.Way_Id , HZ0613v.Cap_Date ,
HZ0613v.Car_Type , HZ0613v.Xxyy , HZ0613v.Res , HZ0613v.Urban , HZ0613v.Gao , 
HZ0613v.Inin , HZ0613v.Out , HZ0613v.Waiin , HZ0613v.Waiout , 
Row_Number() Over(Partition By HZ0613v.Car_Num Order By HZ0613v.Cap_Date DESC) Detected_Time
From HZ0613v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0614v.DEV_ID , HZ0614v.Dev_Name , HZ0614v.Car_Num , HZ0614v.Way_Id , HZ0614v.Cap_Date ,
HZ0614v.Car_Type , HZ0614v.Xxyy , HZ0614v.Res , HZ0614v.Urban , HZ0614v.Gao , 
HZ0614v.Inin , HZ0614v.Out , HZ0614v.Waiin , HZ0614v.Waiout , 
Row_Number() Over(Partition By HZ0614v.Car_Num Order By HZ0614v.Cap_Date DESC) Detected_Time
From HZ0614v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0615v.DEV_ID , HZ0615v.Dev_Name , HZ0615v.Car_Num , HZ0615v.Way_Id , HZ0615v.Cap_Date ,
HZ0615v.Car_Type , HZ0615v.Xxyy , HZ0615v.Res , HZ0615v.Urban , HZ0615v.Gao , 
HZ0615v.Inin , HZ0615v.Out , HZ0615v.Waiin , HZ0615v.Waiout , 
Row_Number() Over(Partition By HZ0615v.Car_Num Order By HZ0615v.Cap_Date DESC) Detected_Time
From HZ0615v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0616v.DEV_ID , HZ0616v.Dev_Name , HZ0616v.Car_Num , HZ0616v.Way_Id , HZ0616v.Cap_Date ,
HZ0616v.Car_Type , HZ0616v.Xxyy , HZ0616v.Res , HZ0616v.Urban , HZ0616v.Gao , 
HZ0616v.Inin , HZ0616v.Out , HZ0616v.Waiin , HZ0616v.Waiout , 
Row_Number() Over(Partition By HZ0616v.Car_Num Order By HZ0616v.Cap_Date DESC) Detected_Time
From HZ0616v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0617v.DEV_ID , HZ0617v.Dev_Name , HZ0617v.Car_Num , HZ0617v.Way_Id , HZ0617v.Cap_Date ,
HZ0617v.Car_Type , HZ0617v.Xxyy , HZ0617v.Res , HZ0617v.Urban , HZ0617v.Gao , 
HZ0617v.Inin , HZ0617v.Out , HZ0617v.Waiin , HZ0617v.Waiout , 
Row_Number() Over(Partition By HZ0617v.Car_Num Order By HZ0617v.Cap_Date DESC) Detected_Time
From HZ0617v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0620v.DEV_ID , HZ0620v.Dev_Name , HZ0620v.Car_Num , HZ0620v.Way_Id , HZ0620v.Cap_Date ,
HZ0620v.Car_Type , HZ0620v.Xxyy , HZ0620v.Res , HZ0620v.Urban , HZ0620v.Gao , 
HZ0620v.Inin , HZ0620v.Out , HZ0620v.Waiin , HZ0620v.Waiout , 
Row_Number() Over(Partition By HZ0620v.Car_Num Order By HZ0620v.Cap_Date DESC) Detected_Time
From HZ0620v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0621v.DEV_ID , HZ0621v.Dev_Name , HZ0621v.Car_Num , HZ0621v.Way_Id , HZ0621v.Cap_Date ,
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
(Select HZ0622v.DEV_ID , HZ0622v.Dev_Name , HZ0622v.Car_Num , HZ0622v.Way_Id , HZ0622v.Cap_Date ,
HZ0622v.Car_Type , HZ0622v.Xxyy , HZ0622v.Res , HZ0622v.Urban , HZ0622v.Gao , 
HZ0622v.Inin , HZ0622v.Out , HZ0622v.Waiin , HZ0622v.Waiout , 
Row_Number() Over(Partition By HZ0622v.Car_Num Order By HZ0622v.Cap_Date DESC) Detected_Time
From HZ0622v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0623v.DEV_ID , HZ0623v.Dev_Name , HZ0623v.Car_Num , HZ0623v.Way_Id , HZ0623v.Cap_Date ,
HZ0623v.Car_Type , HZ0623v.Xxyy , HZ0623v.Res , HZ0623v.Urban , HZ0623v.Gao , 
HZ0623v.Inin , HZ0623v.Out , HZ0623v.Waiin , HZ0623v.Waiout , 
Row_Number() Over(Partition By HZ0623v.Car_Num Order By HZ0623v.Cap_Date DESC) Detected_Time
From HZ0623v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0624v.DEV_ID , HZ0624v.Dev_Name , HZ0624v.Car_Num , HZ0624v.Way_Id , HZ0624v.Cap_Date ,
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
(Select HZ0627v.DEV_ID , HZ0627v.Dev_Name , HZ0627v.Car_Num , HZ0627v.Way_Id , HZ0627v.Cap_Date ,
HZ0627v.Car_Type , HZ0627v.Xxyy , HZ0627v.Res , HZ0627v.Urban , HZ0627v.Gao , 
HZ0627v.Inin , HZ0627v.Out , HZ0627v.Waiin , HZ0627v.Waiout , 
Row_Number() Over(Partition By HZ0627v.Car_Num Order By HZ0627v.Cap_Date DESC) Detected_Time
From HZ0627v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0628v.DEV_ID , HZ0628v.Dev_Name , HZ0628v.Car_Num , HZ0628v.Way_Id , HZ0628v.Cap_Date ,
HZ0628v.Car_Type , HZ0628v.Xxyy , HZ0628v.Res , HZ0628v.Urban , HZ0628v.Gao , 
HZ0628v.Inin , HZ0628v.Out , HZ0628v.Waiin , HZ0628v.Waiout , 
Row_Number() Over(Partition By HZ0628v.Car_Num Order By HZ0628v.Cap_Date DESC) Detected_Time
From HZ0628v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0629v.DEV_ID , HZ0629v.Dev_Name , HZ0629v.Car_Num , HZ0629v.Way_Id , HZ0629v.Cap_Date ,
HZ0629v.Car_Type , HZ0629v.Xxyy , HZ0629v.Res , HZ0629v.Urban , HZ0629v.Gao , 
HZ0629v.Inin , HZ0629v.Out , HZ0629v.Waiin , HZ0629v.Waiout , 
Row_Number() Over(Partition By HZ0629v.Car_Num Order By HZ0629v.Cap_Date DESC) Detected_Time
From HZ0629v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)

UNION ALL

(SELECT * FROM 
(Select HZ0630v.DEV_ID , HZ0630v.Dev_Name , HZ0630v.Car_Num , HZ0630v.Way_Id , HZ0630v.Cap_Date ,
HZ0630v.Car_Type , HZ0630v.Xxyy , HZ0630v.Res , HZ0630v.Urban , HZ0630v.Gao , 
HZ0630v.Inin , HZ0630v.Out , HZ0630v.Waiin , HZ0630v.Waiout , 
Row_Number() Over(Partition By HZ0630v.Car_Num Order By HZ0630v.Cap_Date DESC) Detected_Time
From HZ0630v
WHERE To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' 
and RES = 1   --只研究限行区内的小汽车
) ORDERBYTIME1
WHERE DETECTED_TIME = 1)
) temp1
group by CAR_NUM , XXYY
) temp2
)temp3
where same_place_num_order = 1
) CAR_D2
ON CAR_O1.CAR_NUM = CAR_D2.CAR_NUM





--在建立各车辆O1,O2,D1,D2视图的基础上求出x11,x22,x12,x21,我筛选出的车辆必然是x11,x22,x12,x21都有的,因为我前面是做inner join的
CREATE VIEW OD_MATRIX
AS
SELECT CAR_NUM , GetDistance(O1 , D1) AS X11 , GetDistance(O1 , D2) AS X12 ,
       GetDistance(O2 , D1) AS X21 , GetDistance(O2 , D2) AS X22
FROM
Car_Od_All



--在得到OD_MATRIX后,通过计算得到车辆的OD的空间稳定系数Fs
CREATE table OD_SPATIAL_STABLE_RATIO
AS
select CAR_NUM , 
(case greatest(X11 , X22)
WHEN 0 THEN NULL    --NULL意味着车辆在早晚出行区间都只各被检测到了一个点
ELSE ((X11*X22-X12*X21) / POWER(greatest(X11 , X22) , 2) - (X12+X21) / greatest(X11 , X22)) 
End
) FS
FROM
OD_MATRIX


