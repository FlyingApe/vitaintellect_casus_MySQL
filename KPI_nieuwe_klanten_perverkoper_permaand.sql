SELECT 	unieke_klanten.maand, 
        concat(mdw.voorletters, " ", mdw.naam) as verkoper, 
		count(unieke_klanten.klantnummer) as nieuwe_klanten
FROM
(
	SELECT 	distinct klantnummer,
			verkoper,
			concat(month(besteldatum), "-", year(besteldatum)) as maand
	FROM vitaintellectdb.bestelling
	GROUP BY klantnummer
	ORDER BY besteldatum
) as unieke_klanten
INNER JOIN vitaintellectdb.medewerker as mdw ON unieke_klanten.verkoper=mdw.medewerkernummer
GROUP BY maand, verkoper
ORDER BY maand, nieuwe_klanten DESC;