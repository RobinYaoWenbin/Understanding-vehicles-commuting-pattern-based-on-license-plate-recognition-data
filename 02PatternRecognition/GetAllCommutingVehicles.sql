--利用决策树得到的通勤规则得到杭州市限行区内所有的通勤车
create view CommutingVehicle
    as
    (
Select CAR_NUM
From COMMUVEHFEAT
WHERE (D1 > 0.31 AND D2 > 0.214) or (D2 > 0.595 AND D1 <= 0.31)
)



--本地车牌通勤车数量(最终的本地通勤车数量并不是在这边获得的,而是在CommutingVehiclesAnalysis里的python里得到的)
select count(*) from CommutingVehicle
where CAR_NUM like '%浙A%'

--外地车牌通勤车数量(最终的外地通勤车数量并不是在这边获得的,而是在CommutingVehiclesAnalysis里的python里得到的)
select count(*) from CommutingVehicle
where CAR_NUM not like '%浙A%'

