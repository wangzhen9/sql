create table temp_0113_1 as
select a.user_id,b.item_name, sum(a.fee/100) fee22
          from source.C01089_B_BILL_201702 a
         inner join  source.c01016_item_201611 b
            on a.INTEGRATE_ITEM_CODE = b.item_id and a.cycle_id = '201702'
           and b.item_name like '增值业务%'
         group by a.user_id,b.item_name
drop table temp_0410;
create table temp_0410 as
select  e.month_id,e.prov_id,e.prov_name,e.area_id,e.area_name,e.city_code,e.city_name,e.user_id,e.serial_number,e.cust_type,e.pro duct_id,e.product_name,e.user_type_code,e.net_type_code,e.open_date,e.develop_staff_id,e.dev_name,e.develop_depart_id,e.de part_name,c.item_name,c.fee22,e.fee,e.fee2,e.adjust_before,e.adjust_after,e.a_discnt,e.b_discnt,e.writeoff_fee1,e.sumfee
  from (select a.user_id,'' item_name, sum(a.fee22) fee22
          from temp_0113_1 a group by a.user_id) c,
source.user_info_201702  e
    where e.user_id = c.user_id and cast((c.fee22*100/e.fee2) as decimal(20,2))>=80 and  e.product_name not like '智慧沃家 共享版%' ;
