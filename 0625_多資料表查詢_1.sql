SELECT �q��.�Ȥ�s��
	   , �q��.�q��s��
	   , �q��.�I�ڤ覡
	   , �q�����.��ڳ��
	   , �q�����.�ƶq
	   , �q�����.��ڳ�� * �q�����.�ƶq AS �`���B
	   , RANK() OVER(PARTITION BY �q��.�I�ڤ覡 ORDER BY �q��.�Ȥ�s�� ASC, �q�����.��ڳ�� * �q�����.�ƶq DESC) AS �ƦW1
FROM �q�� INNER JOIN
	 �q����� ON �q��.�q��s�� = �q�����.�q��s��