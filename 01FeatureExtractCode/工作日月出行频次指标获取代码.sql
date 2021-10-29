--note:2016年6月的工作日日期为:1,2,3,6,7,8,12,13,14,15,16,17,20,21,22,23,24,27,28,29,30
--节假日:4,5,9,10,11,18,19,25,26

--代码用来统计车辆工作日月出行频次,并将结果建立视图
create table workday_tra_freq
as
Select Car_Num,Count(*) As Fm , count(*) / 21 as fm_ratio --6月工作日出行率
FROM
(select DISTINCT CAR_NUM from HZ0601v where RES = 1
union all
select DISTINCT CAR_NUM from HZ0602V where RES = 1
Union All
Select Distinct Car_Num From Hz0603V where RES = 1
Union All
Select Distinct Car_Num From Hz0606V where RES = 1
Union All
Select Distinct Car_Num From Hz0607V where RES = 1
Union All
Select Distinct Car_Num From Hz0608V where RES = 1
Union All
Select Distinct Car_Num From Hz0612V where RES = 1
Union All
Select Distinct Car_Num From Hz0613V where RES = 1
Union All
Select Distinct Car_Num From Hz0614V where RES = 1
Union All
Select Distinct Car_Num From Hz0615V where RES = 1
Union All
Select Distinct Car_Num From Hz0616V where RES = 1
Union All
Select Distinct Car_Num From Hz0617V where RES = 1
Union All
Select Distinct Car_Num From Hz0620V where RES = 1
Union All
Select Distinct Car_Num From Hz0621V where RES = 1
Union All
Select Distinct Car_Num From Hz0622V where RES = 1
Union All
Select Distinct Car_Num From Hz0623V where RES = 1
Union All
Select Distinct Car_Num From Hz0624V where RES = 1
Union All
Select Distinct Car_Num From Hz0627V where RES = 1
Union All
Select Distinct Car_Num From Hz0628V where RES = 1
Union All
Select Distinct Car_Num From Hz0629V where RES = 1
Union All
Select Distinct Car_Num From Hz0630V where RES = 1) A
group by CAR_NUM;
