SELECT	CHOOSE(DATEPART(qq,�q��.�q�f���),'�Ĥ@�u','�ĤG�u','�ĤT�u','�ĥ|�u') AS �u��,
		�Ȥ�.���q�W��,
		SUM(�q�����.��ڳ��*�q�����.�ƶq) AS �`���B,
		RANK()OVER(PARTITION BY DATEPART(qq,�q��.�q�f���) ORDER BY SUM(�q�����.��ڳ��*�q�����.�ƶq) DESC) AS �ƦW
FROM	�Ȥ� INNER JOIN
		�q�� ON �Ȥ�.�Ȥ�s�� = �q��.�Ȥ�s�� INNER JOIN
		�q����� ON �q��.�q��s�� = �q�����.�q��s��
GROUP BY	�Ȥ�.���q�W��, DATEPART(qq,�q��.�q�f���)