--note:2016年6月的工作日日期为:1,2,3,6,7,8,12,13,14,15,16,17,20,21,22,23,24,27,28,29,30
--节假日:4,5,9,10,11,18,19,25,26
--确定早晚高峰时间段

--提取平均每个工作日车辆首次被检测时间分布情况
select Interv , (count(*) / 21) as VehNum
from 
(--6月所有工作日所有车辆第一次被检测时间汇总表

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0601V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0602V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0603V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0606V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0607V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0608V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0612V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0613V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0614V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0615V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0616V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0617V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0620V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0621V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0622V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0623V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0624V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0627V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0628V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0629V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(min(CAP_DATE),'hh24')) + (to_number(to_char(min(CAP_DATE),'mi'))/60) + (to_number(to_char(min(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0630V
where RES = 1
group by CAR_NUM)

)
group by Interv


--提取平均每个工作日车辆最后一次被检测时间分布情况
select Interv , (count(*) / 21) as VehNum
from 
(--6月所有工作日所有车辆第一次被检测时间汇总表

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0601V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0602V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0603V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0606V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0607V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0608V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0612V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0613V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0614V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0615V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0616V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0617V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0620V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0621V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0622V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0623V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0624V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0627V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0628V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0629V
where RES = 1
group by CAR_NUM)

union all

(select CAR_NUM , 
    ceil((to_number(to_char(max(CAP_DATE),'hh24')) + (to_number(to_char(max(CAP_DATE),'mi'))/60) + (to_number(to_char(max(CAP_DATE),'ss')) / 60 / 60)) * 2) as Interv
from HZ0630V
where RES = 1
group by CAR_NUM)

)
group by Interv