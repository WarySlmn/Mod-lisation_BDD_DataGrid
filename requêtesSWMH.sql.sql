-- 1)
SELECT nomHergeId,PrixHotel,NbreChambre FROM hotel,hebergement,offres
WHERE nomHergeId=IdnomHeberge AND numOffreId=IdnumOffre AND Ville='Paris';

-- 2)
SELECT NoteAvis,DateAvis,Commentaire FROM avis,internautes
WHERE emailId=Idemail AND Pseudo='Internaute_1';

-- 3)
SELECT  DISTINCT Attraction.idNomAttract, Attraction.TypeAttraction, Attraction.Adresse
FROM Avis,Attraction,offres
    WHERE Offres.IdnumOffre= Attraction.numOffreId
    AND Attraction.idNomAttract= Avis.nomAttactionId
    AND Ville ='Le Mans'
    AND TypeTourisme='Famille'
    AND NoteAvis > 4;

-- 4)
SELECT Activites.IdnomActivite, Activites.description, Activites.TypeActivite, Attraction.TypeAttraction
FROM Activites
JOIN Attraction ON Activites.nomAttractId = Attraction.idNomAttract
JOIN Offres ON Attraction.numOffreId = Offres.IdnumOffre
WHERE Activites.PrixActivite IS NULL
 AND Offres.Ville = 'Rodez'
AND Activites.TypePublic = 'Enfant';


-- 5)
SELECT DISTINCT nomHergeId as nomHotel ,Ville, hb.Adresse,NbreEtoile, R.IdnomResto,IdnomMenu FROM Hotel h,restaurant R, Offres off,Hebergement hb, Menu m
WHERE off.Departement='11'
AND TypeMenu='végétarien'
AND off.IdnumOffre=hb.numOffreId
AND hb.IdnomHeberge=R.nomHebergeId
AND R.IdnomResto=m.RestotId;


-- 6)
SELECT COUNT(DISTINCT Attraction.idNomAttract) AS NombreDeMusees
FROM Attraction
JOIN Activites ON Attraction.idNomAttract = Activites.nomAttractId
JOIN Offres ON Attraction.numOffreId = Offres.IdnumOffre
WHERE Offres.Ville = 'Rodez'
  AND TypeAttraction = 'Musée'
  AND Activites.TypeActivite = 'Visite Guidéé'
  AND Activites.TypePublic = 'Adulte'
  AND Activites.PrixActivite < 10;

-- 7)
SELECT AVG(PrixMenu) FROM Menu m
INNER JOIN  restaurant R ON  m.RestotId = R.IdnomResto
INNER JOIN Offres O on R.numOffreId = O.IdnumOffre
WHERE TypeMenu='gastro'
AND O.Ville IN ('Marseille','Carsassone');

-- 8)
SELECT TypeAttraction, AVG(NombrePhotos) AS MoyennePhotos
FROM (
    SELECT Attraction.TypeAttraction, COUNT(ListePhoto.IdnomListe) AS NombrePhotos
    FROM Attraction
    LEFT JOIN ListePhoto ON Attraction.idNomAttract = ListePhoto.nomAttractid
    GROUP BY Attraction.TypeAttraction, Attraction.idNomAttract
) AS Su
GROUP BY TypeAttraction;

-- 9)
SELECT MAX(Duree) FROM Activites act
INNER JOIN attraction a ON a.idNomAttract=act.nomAttractId
INNER JOIN offres off  on off.IdnumOffre = A.numOffreId
WHERE off.Ville='Rodez'
GROUP BY TypeActivite;

-- 10)
SELECT COUNT(TypeCamp) AS CampingOuvert FROM Camping
INNER JOIN Hebergement H on Camping.nomHergeId = H.IdnomHeberge
INNER JOIN Offres O on H.numOffreId = O.IdnumOffre
WHERE TypeCamp ='Camping Car'
AND O.Ville= 'Dijon'
AND nomSaison='Hiver'
AND nbrePlace IS NOT NULL;
