--note:2016年6月的工作日日期为:1,2,3,6,7,8,12,13,14,15,16,17,20,21,22,23,24,27,28,29,30
--节假日:4,5,9,10,11,18,19,25,26

--建立出行者一个月平峰时段出行被检测均值与标准差表格.
CREATE TABLE WORKDAY_OFFPEAK_STD_AND_AVG
AS
(
select CAR_NUM , STDDEV(fd) AS STD_FD , avg(fd) as avg_fd
FROM
(
(Select CAR_NUM , COUNT(*) AS fd From Hz0601v 
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 00:00:00' And '2016/06/01 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 10:30:00' And '2016/06/01 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/01 21:30:00' And '2016/06/01 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0602v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 00:00:00' And '2016/06/02 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 10:30:00' And '2016/06/02 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/02 21:30:00' And '2016/06/02 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0603v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 00:00:00' And '2016/06/03 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 10:30:00' And '2016/06/03 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/03 21:30:00' And '2016/06/03 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0606v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 00:00:00' And '2016/06/06 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 10:30:00' And '2016/06/06 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/06 21:30:00' And '2016/06/06 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0607v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 00:00:00' And '2016/06/07 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 10:30:00' And '2016/06/07 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/07 21:30:00' And '2016/06/07 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0608v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 00:00:00' And '2016/06/08 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 10:30:00' And '2016/06/08 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/08 21:30:00' And '2016/06/08 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0612v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 00:00:00' And '2016/06/12 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 10:30:00' And '2016/06/12 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/12 21:30:00' And '2016/06/12 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0613v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 00:00:00' And '2016/06/13 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 10:30:00' And '2016/06/13 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/13 21:30:00' And '2016/06/13 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0614v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 00:00:00' And '2016/06/14 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 10:30:00' And '2016/06/14 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/14 21:30:00' And '2016/06/14 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0615v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 00:00:00' And '2016/06/15 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 10:30:00' And '2016/06/15 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/15 21:30:00' And '2016/06/15 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0616v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 00:00:00' And '2016/06/16 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 10:30:00' And '2016/06/16 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/16 21:30:00' And '2016/06/16 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0617v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 00:00:00' And '2016/06/17 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 10:30:00' And '2016/06/17 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/17 21:30:00' And '2016/06/17 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0620v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 00:00:00' And '2016/06/20 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 10:30:00' And '2016/06/20 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/20 21:30:00' And '2016/06/20 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0621v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 00:00:00' And '2016/06/21 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 10:30:00' And '2016/06/21 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/21 21:30:00' And '2016/06/21 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0622v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 00:00:00' And '2016/06/22 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 10:30:00' And '2016/06/22 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/22 21:30:00' And '2016/06/22 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0623v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 00:00:00' And '2016/06/23 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 10:30:00' And '2016/06/23 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/23 21:30:00' And '2016/06/23 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0624v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 00:00:00' And '2016/06/24 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 10:30:00' And '2016/06/24 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/24 21:30:00' And '2016/06/24 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0627v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 00:00:00' And '2016/06/27 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 10:30:00' And '2016/06/27 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/27 21:30:00' And '2016/06/27 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0628v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 00:00:00' And '2016/06/28 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 10:30:00' And '2016/06/28 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/28 21:30:00' And '2016/06/28 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0629v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 00:00:00' And '2016/06/29 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 10:30:00' And '2016/06/29 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/29 21:30:00' And '2016/06/29 23:59:59')
   and RES = 1
group by CAR_NUM)
union all
(Select CAR_NUM , COUNT(*) AS fd From Hz0630v
Where (To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 00:00:00' And '2016/06/30 06:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 10:30:00' And '2016/06/30 15:30:00'
   Or To_Char(Cap_Date,'yyyy/mm/dd hh24:mi:ss') Between '2016/06/30 21:30:00' And '2016/06/30 23:59:59')
   and RES = 1
group by CAR_NUM)) temp1
group by CAR_NUM
)