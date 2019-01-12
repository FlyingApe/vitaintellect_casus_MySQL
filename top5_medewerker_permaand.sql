SELECT 	tijd.m as maand, 
	tijd.medewerkernummer, 
        concat(medewerker.voorletters, " ", medewerker.naam) as naam,
        concat((avg(tijd.totaaltijd) DIV 60), " uur en ", ROUND(MOD(avg(tijd.totaaltijd), 60)), " minuten") as "Totaal gewerkt"
FROM
(
	SELECT 	*, @num := if(@maand = maand, @num := @num + 1, 1) as rij_num,
			@maand := maand as m
	FROM
    	(
		SELECT maand, medewerkernummer, sum(duur) as totaaltijd
		FROM 
        	(
			SELECT 	concat(month(start_activiteit), "-", year(start_activiteit)) as maand, 
				medewerkernummer, 
				timestampdiff(minute, start_activiteit, eind_activiteit) as duur  
            		FROM vitaintellectdb.productielogboek 
            		ORDER BY maand, medewerkernummer
		) as duurtabel
		GROUP BY maand, medewerkernummer
		ORDER BY maand, totaaltijd DESC
	) as a
) as tijd
LEFT JOIN vitaintellectdb.medewerker as medewerker ON tijd.medewerkernummer=medewerker.medewerkernummer
WHERE tijd.rij_num <= 5
GROUP BY tijd.maand, tijd.medewerkernummer
ORDER BY tijd.maand, tijd.totaaltijd DESC
