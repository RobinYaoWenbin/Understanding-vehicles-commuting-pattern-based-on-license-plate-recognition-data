--note:2016年6月的工作日日期为:1,2,3,6,7,8,12,13,14,15,16,17,20,21,22,23,24,27,28,29,30
--节假日:4,5,9,10,11,18,19,25,26

--建立早晚高峰月出行频次系数表格
CREATE TABLE WORKDAY_PEAKHOUR_FREQ
As
(
Select Car_Num,Count(*) As Fm , count(*) / 21 as Fm_Ratio --6月工作日出行率
FROM
(
(Select Distinct Car_Num From Hz0601v Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 06:30:00' And '2016/06/01 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0601V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 15:30:00' And '2016/06/01 21:30:00' and RES = 1)
union all
(Select Distinct Car_Num From HZ0602V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 06:30:00' And '2016/06/02 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0602V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 15:30:00' And '2016/06/02 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0603V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 06:30:00' And '2016/06/03 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0603V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 15:30:00' And '2016/06/03 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0606V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 06:30:00' And '2016/06/06 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0606V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 15:30:00' And '2016/06/06 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0607V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 06:30:00' And '2016/06/07 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0607V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 15:30:00' And '2016/06/07 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0608V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 06:30:00' And '2016/06/08 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0608V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 15:30:00' And '2016/06/08 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0612V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 06:30:00' And '2016/06/12 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0612V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 15:30:00' And '2016/06/12 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0613V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 06:30:00' And '2016/06/13 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0613V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 15:30:00' And '2016/06/13 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0614V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 06:30:00' And '2016/06/14 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0614V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 15:30:00' And '2016/06/14 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0615V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 06:30:00' And '2016/06/15 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0615V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 15:30:00' And '2016/06/15 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0616V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 06:30:00' And '2016/06/16 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0616V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 15:30:00' And '2016/06/16 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0617V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 06:30:00' And '2016/06/17 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0617V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 15:30:00' And '2016/06/17 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0620V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 06:30:00' And '2016/06/20 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0620V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 15:30:00' And '2016/06/20 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0621V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 06:30:00' And '2016/06/21 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0621V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 15:30:00' And '2016/06/21 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0622V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 06:30:00' And '2016/06/22 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0622V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 15:30:00' And '2016/06/22 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0623V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 06:30:00' And '2016/06/23 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0623V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 15:30:00' And '2016/06/23 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0624V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 06:30:00' And '2016/06/24 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0624V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 15:30:00' And '2016/06/24 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0627V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 06:30:00' And '2016/06/27 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0627V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 15:30:00' And '2016/06/27 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0628V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 06:30:00' And '2016/06/28 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0628V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 15:30:00' And '2016/06/28 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0629V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 06:30:00' And '2016/06/29 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0629V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 15:30:00' And '2016/06/29 21:30:00' and RES = 1)
Union All
(Select Distinct Car_Num From Hz0630V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 06:30:00' And '2016/06/30 10:30:00' and RES = 1
intersect 
select Distinct Car_Num From Hz0630V Where To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 15:30:00' And '2016/06/30 21:30:00' and RES = 1)) A
group by CAR_NUM
)