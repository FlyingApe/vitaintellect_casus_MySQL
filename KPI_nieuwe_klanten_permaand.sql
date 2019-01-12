SELECT maand, count(klantnummer) as "nieuwe klanten"
FROM
(
	SELECT 	distinct klantnummer,
			concat(month(besteldatum), "-", year(besteldatum)) as maand
	FROM vitaintellectdb.bestelling
	GROUP BY klantnummer
	ORDER BY besteldatum
) as unieke_klanten
GROUP BY maand;