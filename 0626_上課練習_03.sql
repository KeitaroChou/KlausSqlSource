-- �@��d��
SELECT	���~���O.���O�W��,
		SUM(�q�����.��ڳ�� * �q�����.�ƶq) AS �P����B
FROM	�q����� INNER JOIN
		���~��� ON �q�����.���~�s�� = ���~���.���~�s�� AND �q�����.��ڳ�� < ���~���.��ĳ��� RIGHT OUTER JOIN
		���~���O ON ���~���.���O�s�� = ���~���O.���O�s��
GROUP BY	���~���O.���O�W��
ORDER BY	SUM(�q�����.��ڳ�� * �q�����.�ƶq) DESC


-- �l�d��
SELECT	���~���O.���O�W��,
		SUM(abc.��ڳ�� * abc.�ƶq) AS �P����B
FROM	���~���O LEFT OUTER JOIN (	SELECT	���~���.���O�s��, �q�����.�ƶq, �q�����.��ڳ��, ���~���.��ĳ���
									FROM	�q����� INNER JOIN
											���~��� ON �q�����.���~�s�� = ���~���.���~�s�� 
									WHERE	�q�����.��ڳ�� <  ���~���.��ĳ���	) AS abc ON ���~���O.���O�s�� = abc.���O�s��
GROUP BY	���~���O.���O�W��
ORDER BY	�P����B DESC