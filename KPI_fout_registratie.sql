SELECT 	concat(day(log.start_activiteit), "-", month(log.start_activiteit), "-", year(log.start_activiteit)) as datum,
		log.lognummer,
        log.machinenummer, 
        act.activiteit,
        log.medewerkernummer,
        concat(mdw.voorletters, " ", mdw.naam) as medewerker
FROM vitaintellectdb.productielogboek as log
LEFT JOIN vitaintellectdb.medewerker as  mdw ON log.medewerkernummer=mdw.medewerkernummer
LEFT JOIN vitaintellectdb.productieactiviteit as act ON log.productieactiviteit=act.activiteitnummer
WHERE productieactiviteit>=90
ORDER BY log.start_activiteit;