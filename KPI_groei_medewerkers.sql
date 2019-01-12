SELECT 	concat(month(datum_in_dienst), "-", year(datum_in_dienst)) as maand,
		count(medewerkernummer) as "nieuwe personeelsleden"
FROM vitaintellectdb.medewerker
GROUP BY maand;