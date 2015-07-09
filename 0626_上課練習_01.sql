SELECT	CHOOSE(DATEPART(qq,訂單.訂貨日期),'第一季','第二季','第三季','第四季') AS 季度,
		客戶.公司名稱,
		SUM(訂單明細.實際單價*訂單明細.數量) AS 總金額,
		RANK()OVER(PARTITION BY DATEPART(qq,訂單.訂貨日期) ORDER BY SUM(訂單明細.實際單價*訂單明細.數量) DESC) AS 排名
FROM	客戶 INNER JOIN
		訂單 ON 客戶.客戶編號 = 訂單.客戶編號 INNER JOIN
		訂單明細 ON 訂單.訂單編號 = 訂單明細.訂單編號
GROUP BY	客戶.公司名稱, DATEPART(qq,訂單.訂貨日期)