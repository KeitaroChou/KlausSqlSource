-- 一般查詢
SELECT	產品類別.類別名稱,
		SUM(訂單明細.實際單價 * 訂單明細.數量) AS 銷售金額
FROM	訂單明細 INNER JOIN
		產品資料 ON 訂單明細.產品編號 = 產品資料.產品編號 AND 訂單明細.實際單價 < 產品資料.建議單價 RIGHT OUTER JOIN
		產品類別 ON 產品資料.類別編號 = 產品類別.類別編號
GROUP BY	產品類別.類別名稱
ORDER BY	SUM(訂單明細.實際單價 * 訂單明細.數量) DESC


-- 子查詢
SELECT	產品類別.類別名稱,
		SUM(abc.實際單價 * abc.數量) AS 銷售金額
FROM	產品類別 LEFT OUTER JOIN (	SELECT	產品資料.類別編號, 訂單明細.數量, 訂單明細.實際單價, 產品資料.建議單價
									FROM	訂單明細 INNER JOIN
											產品資料 ON 訂單明細.產品編號 = 產品資料.產品編號 
									WHERE	訂單明細.實際單價 <  產品資料.建議單價	) AS abc ON 產品類別.類別編號 = abc.類別編號
GROUP BY	產品類別.類別名稱
ORDER BY	銷售金額 DESC