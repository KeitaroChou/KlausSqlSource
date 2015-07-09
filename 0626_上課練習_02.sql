SELECT	訂單.*
FROM	訂單 INNER JOIN ( SELECT	*
							FROM	訂單明細
							WHERE	實際單價 >= 30)
		訂單明細 ON 訂單.訂單編號 = 訂單明細.訂單編號