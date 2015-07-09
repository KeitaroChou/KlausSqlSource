select count (*) as 訂單總數
from 訂單

select * 
from 訂單

select count ([實際到貨日期]) as 訂單總數
from 訂單


select sum(數量) as 總數量, sum(實際單價) as 總單價, sum(數量*實際單價) as 總金額
from 訂單明細

select avg(實際單價) as 平均單價
from 訂單明細

select max(數量) as 最大訂購數量
from 訂單明細

select min(數量) as 最小訂購數量
from 訂單明細

select 訂單編號,產品編號,實際單價,數量,sum(實際單價*數量) as 總金額
from 訂單明細