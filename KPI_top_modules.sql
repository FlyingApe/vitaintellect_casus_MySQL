SELECT modulenaam, count(modulenaam) as aantal 
FROM vitaintellectdb.configuratie
GROUP BY modulenaam;