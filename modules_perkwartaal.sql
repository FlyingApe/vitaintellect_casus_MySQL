SELECT best.kwartaal, best.jaar, conf.modulenaam, count(conf.modulenaam) as aantal 
FROM 	
(
	SELECT year(besteldatum) as jaar, round(month(besteldatum)/3 + 0.3) as kwartaal, bestelnummer 
	FROM vitaintellectdb.bestelling 
	ORDER BY jaar, kwartaal ASC
) as best 
INNER JOIN vitaintellectdb.configuratie as conf ON best.bestelnummer=conf.bestelnummer 
GROUP BY jaar DESC, kwartaal ASC, modulenaam;
