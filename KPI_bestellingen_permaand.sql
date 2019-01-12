SELECT 	concat(month(besteldatum), "-", year(besteldatum)) as maand,
		count(bestelnummer) as "aantal bestellingen"
FROM vitaintellectdb.bestelling
GROUP BY maand;