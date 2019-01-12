SELECT	maand,
		modulenaam,
        count(modulenaam) as aantal
FROM
(
	SELECT 	concat(month(best.besteldatum), "-", year(best.besteldatum)) as maand,
			best.bestelnummer,
			conf. modulenaam
	FROM vitaintellectdb.bestelling as best
	LEFT JOIN vitaintellectdb.configuratie as conf ON best.bestelnummer=conf.bestelnummer
	ORDER BY maand
) as mod_maand
GROUP BY maand, modulenaam
ORDER BY modulenaam, maand;