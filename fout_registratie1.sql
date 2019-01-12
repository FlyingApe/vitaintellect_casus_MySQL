SELECT 	a.productieactiviteit as foutcode, 
	c.activiteit,
        a.machinenummer as machine,
	count(a.productieactiviteit) as "aantal fout", 
	b.aantal as uit, 
	round(((count(a.productieactiviteit)/b.aantal)*100), 1) as percentage
FROM vitaintellectdb.productielogboek as a
LEFT JOIN 
(
	SELECT productieactiviteit, count(productieactiviteit) as aantal
    	FROM vitaintellectdb.productielogboek
    	WHERE productieactiviteit < 90
    	GROUP BY productieactiviteit
)as b on a.productieactiviteit=(b.productieactiviteit+90)
LEFT JOIN vitaintellectdb.productieactiviteit as c ON a.productieactiviteit=c.activiteitnummer 
WHERE a.productieactiviteit >= 90
GROUP BY a.productieactiviteit;
