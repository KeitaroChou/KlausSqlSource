select count(訂單編號) as 訂單數量,
max(實際單價) as 最大單價,
min(實際單價) as 最小單價,
max(數量) as 採購最大數量,
min(數量) as 採購最小數量,
sum(數量) as 總數量, 
sum(實際單價) as 總單價,
convert(varchar,convert(money,sum(數量*實際單價)),1) as 總金額,
avg(數量*實際單價) as 平均總單價
from 訂單明細