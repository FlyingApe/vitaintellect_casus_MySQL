SELECT 	tijd.maand, 
		tijd.medewerkernummer, 
        concat(medewerker.voorletters, " ", medewerker.naam) as naam,
        concat((avg(tijd.totaaltijd) DIV 60), " uur en ", ROUND(MOD(avg(tijd.totaaltijd), 60)), " minuten") as "Totaal gewerkt",
        fout.fouten as "gemaakte fouten",
        truncate(fout.fouten/round(tijd.totaaltijd/60),3) as fouten_per_uur
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
) as tijd
LEFT JOIN vitaintellectdb.medewerker as medewerker ON tijd.medewerkernummer=medewerker.medewerkernummer
LEFT JOIN
(
	SELECT 	concat(month(log.start_activiteit), "-", year(log.start_activiteit)) as maand, 
			concat(mdw.voorletters, " ", mdw.naam) as naam,
			log.medewerkernummer, 
			count(log.lognummer) as fouten
	FROM vitaintellectdb.productielogboek as log
	LEFT JOIN vitaintellectdb.medewerker as mdw ON log.medewerkernummer = mdw.medewerkernummer
	WHERE productieactiviteit >= 90
	GROUP BY maand, medewerkernummer
) as fout ON tijd.medewerkernummer=fout.medewerkernummer AND tijd.maand=fout.maand
GROUP BY tijd.maand, tijd.medewerkernummer
ORDER BY fouten_per_uur DESC
