SELECT 	concat(month(log.start_activiteit), "-", year(log.start_activiteit)) as maand, 
        concat(mdw.voorletters, " ", mdw.naam) as naam,
		log.medewerkernummer, 
        count(log.lognummer) as "aantal fouten"
FROM vitaintellectdb.productielogboek as log
LEFT JOIN vitaintellectdb.medewerker as mdw ON log.medewerkernummer = mdw.medewerkernummer
WHERE productieactiviteit >= 90
GROUP BY maand, medewerkernummer
;