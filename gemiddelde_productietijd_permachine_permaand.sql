SELECT 	logboek.maand, 
		logboek.machinenummer, 
        activiteit.activiteit, 
        concat((avg(logboek.duur) DIV 60), " uur en ", ROUND(MOD(avg(logboek.duur), 60)), " minuten") as "gemiddelde productietijd"
FROM
(
	SELECT 	concat(month(start_activiteit), "-", year(start_activiteit)) as maand, 
			machinenummer, 
            productieactiviteit, 
            timestampdiff(minute, start_activiteit, eind_activiteit) as duur
	FROM vitaintellectdb.productielogboek
	ORDER BY machinenummer
) as logboek 
LEFT JOIN vitaintellectdb.productieactiviteit as activiteit
ON logboek.productieactiviteit=activiteit.activiteitnummer
GROUP BY maand, machinenummer, productieactiviteit
ORDER BY activiteit;