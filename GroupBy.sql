select  訂單編號,sum(數量*實際單價) as 訂單總金額
from 訂單明細
group by 訂單編號
order by 訂單總金額 DESC