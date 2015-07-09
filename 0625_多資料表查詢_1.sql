SELECT 訂單.客戶編號
	   , 訂單.訂單編號
	   , 訂單.付款方式
	   , 訂單明細.實際單價
	   , 訂單明細.數量
	   , 訂單明細.實際單價 * 訂單明細.數量 AS 總金額
	   , RANK() OVER(PARTITION BY 訂單.付款方式 ORDER BY 訂單.客戶編號 ASC, 訂單明細.實際單價 * 訂單明細.數量 DESC) AS 排名1
FROM 訂單 INNER JOIN
	 訂單明細 ON 訂單.訂單編號 = 訂單明細.訂單編號