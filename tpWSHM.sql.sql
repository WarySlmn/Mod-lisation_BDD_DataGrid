-- Table des offres

CREATE TABLE Offres (
    IdnumOffre INT UNSIGNED AUTO_INCREMENT,
    Ville VARCHAR(30),
    Departement INT UNSIGNED NOT NULL ,
    PRIMARY KEY(IdnumOffre)
);
-- Table des hébergements
CREATE TABLE Hebergement(
    IdnomHeberge VARCHAR(30) NOT NULL ,
    Adresse VARCHAR(30),
    UrlHeberge VARCHAR(30),
    LongitudeHerge DECIMAL(10,2),
    LatitudeHerge DECIMAL(10,2),
    NoteHerge FLOAT CHECK (  NoteHerge  >=1 AND NoteHerge  <= 5 ),
    numOffreId INT UNSIGNED NOT NULL,
    PRIMARY KEY( IdnomHeberge),
    FOREIGN KEY (numOffreId) REFERENCES Offres(IdnumOffre)
);
-- Tables spécifiques aux types d'hébergements
CREATE TABLE Hotel(
NbreEtoile INT,
NbreChambre INT,
PrixHotel FLOAT,
nomHergeId VARCHAR(30) NOT NULL,
PRIMARY KEY (nomHergeId),
FOREIGN KEY (nomHergeId) REFERENCES Hebergement(IdnomHeberge)
);

CREATE TABLE ChambreHote(
PrixSansDej DECIMAL(10,2),
PrixAvecDej DECIMAL(10,2),
nomHergeId VARCHAR(30) NOT NULL,
PRIMARY KEY (nomHergeId ),
FOREIGN KEY (nomHergeId) REFERENCES Hebergement(IdnomHeberge)
);

CREATE TABLE Camping(
HoraireOverture TIME,
nomSaison ENUM('Hiver','Ete','Printemps','Automne'),
PrixCamp FLOAT,
nbrePlace INT,
nomHergeId VARCHAR(30) NOT NULL,
TypeCamp ENUM('Bungolaw','Caravane','Camping Car','Tente'),
PRIMARY KEY(nomHergeId ),
FOREIGN KEY (nomHergeId) REFERENCES Hebergement(IdnomHeberge)
);


CREATE TABLE Appartement(
    TypeAppart ENUM('T1','T2','T3'),
    Taille INT,
    PrixAppart DECIMAL(8, 2),
    nomHergeId VARCHAR(30) NOT NULL,
    PRIMARY KEY ( nomHergeId),
    FOREIGN KEY ( nomHergeId) REFERENCES Hebergement(IdnomHeberge)
);
-- Table des restaurants
CREATE TABLE Restaurant(
    IdnomResto VARCHAR(30) NOT NULL ,
    NumeroTel INT,
    Adresse TEXT,
    LongitudeRestau DECIMAL(10,2),
    LatitudeRestau DECIMAL(10,2),
    HorairesOuverture TIME,
    NotesResto FLOAT CHECK (  NotesResto  >=1 AND NotesResto <= 5 ),
    TypeCuisine ENUM('Traditionnel','Fast-Food','Pizzeria'),
    numOffreId INT  UNSIGNED NOT NULL ,
    nomHebergeId VARCHAR(30) NOT NULL,
    CategoriePrix INT CHECK ( CategoriePrix >=1 AND CategoriePrix <=3 ),
    PRIMARY KEY (IdnomResto),
    FOREIGN KEY ( nomHebergeId) REFERENCES Hebergement(IdnomHeberge),
    FOREIGN KEY (numOffreId) REFERENCES Offres(IdnumOffre)
);

-- Tables pour les menus des restaurants
CREATE TABLE Menu (
    IdnomMenu VARCHAR(30) NOT NULL ,
    PrixMenu DECIMAL(10, 2),
    Entree VARCHAR(30),
    Plat VARCHAR(30),
    ChoixDessert VARCHAR(30),
    TypeMenu ENUM('gastro','enfant','végétarien'),
    RestotId VARCHAR(30) NOT NULL ,
    PRIMARY KEY( IdnomMenu,RestotId),
    FOREIGN KEY (RestotId) REFERENCES Restaurant( IdnomResto)
    );


CREATE TABLE Attraction(
    idNomAttract VARCHAR(30) NOT NULL ,
    NumeroTel INT UNSIGNED,
    Adresse TEXT,
    LongitudeAttract DECIMAL(10,2),
    LatitudeAttract DECIMAL(10,2),
    TypeAttraction ENUM('Site touristique', 'Musée','Espace vert', 'parc','Diverstissement','Zoo','Aquariums') NOT NULL,
    HoraireOuverture TIME,
    NoteAttract FLOAT CHECK (  NoteAttract >=1 AND NoteAttract <= 5 ),
    PrixAttraction FLOAT,
    numOffreId INT UNSIGNED NOT NULL ,
    PRIMARY KEY (idNomAttract),
    FOREIGN KEY (numOffreid) REFERENCES Offres(IdnumOffre)
);

-- Table des activités des attractions
CREATE TABLE Activites(
    IdnomActivite VARCHAR(30) NOT NULL  ,
    description  TEXT,
    TypePublic ENUM('Enfant','Adulte'),
    TypeActivite ENUM('Visite Guidéé','Concert','Atelier'),
    Duree INT,
    PrixActivite DECIMAL(10,2),
    nomAttractId VARCHAR(30),
    PRIMARY KEY( IdnomActivite,nomAttractId),
    FOREIGN KEY (nomAttractId) REFERENCES Attraction( idNomAttract)
);

CREATE TABLE ListePhoto(
    IdnomListe VARCHAR(30)NOT NULL ,
    nomAttractid VARCHAR(30),
    nomHebergeid VARCHAR(30) ,
    nomRestoid VARCHAR(30) ,
    FOREIGN KEY (nomHebergeid) REFERENCES Hebergement(IdnomHeberge),
    FOREIGN KEY (nomAttractid) REFERENCES Attraction(idNomAttract),
    FOREIGN KEY (nomRestoid) REFERENCES Restaurant(IdnomResto),
    PRIMARY KEY(IdnomListe)
);


-- Table des internautes
CREATE TABLE Internautes (
    Idemail VARCHAR(30) NOT NULL,
    Pseudo VARCHAR(30),
    MotDePasse VARCHAR(30),
    VilleInternaute VARCHAR(30),
    PRIMARY KEY( Idemail)

);


DROP TABLE avis;
-- Table des avis des internautes
CREATE TABLE Avis (
    IdnumAvis INT UNSIGNED AUTO_INCREMENT,
    NoteAvis DECIMAL(10, 1),
    DateAvis DATE,
    Commentaire VARCHAR(30),
    PRIMARY KEY(IdnumAvis),
    emailId VARCHAR(30) NOT NULL,
    nomRestoid VARCHAR(30),
    nomActiviteId VARCHAR(30),
    nomHergeId VARCHAR(30),
    nomAttactionId VARCHAR(30),
    TypeTourisme ENUM('Couple','Famille','Amis','Solo'),
    FOREIGN KEY (emailId) REFERENCES Internautes(Idemail),
    FOREIGN KEY (nomRestoid) REFERENCES Restaurant(IdnomResto),
    FOREIGN KEY (nomActiviteId) REFERENCES Activites(IdnomActivite),
    FOREIGN KEY (nomHergeId) REFERENCES Hebergement(IdnomHeberge),
    FOREIGN KEY (nomAttactionId) REFERENCES Attraction(idNomAttract)

);

-- insertion de la Table Offres.
INSERT INTO `Offres` (`IdnumOffre`, `Departement`, `Ville`)
VALUES(1,10,'Troyes'),
      (2,11,'Carsassone'),
      (3,12,'Rodez'),
      (4,13,'Marseille'),
      (5,15,'Caen'),
      (6,17,'Dijon'),
      (7,35,'Rennes'),
      (8,54,'Nancy'),
      (9,72,'Le Mans'),
      (10,75,'Paris')
;

-- Insertion de la table hébergement

    INSERT INTO `Hebergement` (`IdnomHeberge`, `adresse`, `UrlHeberge`, `LongitudeHerge`,`LatitudeHerge`,`NoteHerge`,`numOffreId` ) VALUES
 ('Lopli', '321 Passage Delesseux', 'https://www.commentcamarche.net/', 54.4,69.4,3,1),
 ('Fiel', '21 rue Delesseux', 'https://www.amarche.net/', 25.4,39.4,4,6),
 ('Pomme', '3 rue grimme', 'https://www.Bomment.com', 46.4,64.4,2,2),
 ('Faise', '67  rue livre ', 'https://www.Fommarche.fr/', 20.4,67.4,4,5),
 ('Timea', '51 rue heureuse', 'https://www.Pomme.net/', 87.4,76.4,3,8),
 ('Divin', '34 rue malheureux', 'https://www.ommenmar.com/', 24.4,36.4,3,6),
 ('Serr' ,'7 rue crapper', 'https://www.mmentcamar.net/',22.4,39.4,2,10),
 ('Vingn', '54 rue feuille', 'https://www.lommcam.fr/', 21.4,39.4,1,4),
 ('Poot', '59 rue argent', 'https://www.sommemar.fr/', 26.4,39.4,4,9),
 ('Crope', '69 rue scammer', 'https://www.fjsueile.com/', 56.4,39.4,5,7),
 ('Fontaine', '78 rue tyron', 'https://www.fjsue.com/', 35.4,25.4,3,8),
  ('MontBlanc', '69 rue summer', 'https://www.fueile.com/', 15.4,39.4,5,10),
('Voulette', '7 rue diary', 'https://www.fueilette.com/', 15.4,29.4,3,10);


-- Insertion de la hôtel
INSERT INTO `Hotel` (`NbreEtoile`,`NbreChambre`, `PrixHotel`,`nomHergeId`) VALUES
(4, 32, 420, 'Serr'),
(1, 15, 45, 'Lopli'),
(5, 30, 540, 'Pomme');


-- Insertion de la table camping
    INSERT INTO `Camping` (`HoraireOverture`,`nomSaison`,`PrixCamp`,`nbrePlace`,`nomHergeId`,`TypeCamp`)
    VALUES ('10:20', 'Hiver',73, 78,'Fiel','Camping Car'),
            ('12:30', 'Hiver',67, 78,'Divin','Camping Car'),
            ('8:45', 'Ete',45, 78,'Crope','Caravane'),
            ('11:20','Automne',80,42,'Fontaine','Tente');

-- Insertion de la table chambreHote

INSERT INTO `ChambreHote` (`PrixSansDej`,`PrixAvecDej`, `nomHergeId`) VALUES
(50, 60,'Poot'),
(46, 56, 'Vingn'),
(70,100,'Voulette');

-- Insertiion de la table Appartement
    INSERT INTO `Appartement` (`TypeAppart`,`Taille`, `PrixAppart`, `nomHergeId`)
    VALUES('T2', 70, 230,'Faise'),
         ('T1', 27, 305,'Timea'),
          ('T3',50,420,'MontBlanc');

-- Insertion des Restaurant

INSERT INTO `Restaurant`(`IdnomResto`,`NumeroTel`,`Adresse`,`LongitudeRestau`,`LatitudeRestau`,`HorairesOuverture`,`NotesResto`,`TypeCuisine`, `numOffreId`,`nomHebergeId`,`CategoriePrix`)
VALUES ('Desange',0625897452,'20 Rue de fontaine',45.7,55.8,'10:54',4,'Traditionnel',2, 'Serr',2),
       ('Arte',0625815252,'27 Rue de la montage',50.7,56.8,'9:20',3,'Pizzeria',5, 'Lopli',3),
       ('King',0758815252,'3 Rue de la baie ',10.7,26.8,'11:20',2,'Fast-Food',3, 'Pomme',1),
      ('Panthouse',0785815252,'2 Rue Massay',20.7,17.8,'9:20',3,'Traditionnel',1, 'Fiel',3),
('Alchmy',0624815252,'27 Rue du mans',30.7,46.8,'15:20',2,'Fast-Food',4, 'Divin',2),
('Soul',0785815252,'7 Rue de Metz',40.7,56.8,'8:20',4,'Pizzeria',7, 'Crope',1),
('Loey',0785815045,'8 Rue poirau',20.7,518.8,'8:20',4,'Fast-Food',7, 'Fontaine',2);


-- Insertion de la table Menu
    INSERT INTO `Menu` (`IdnomMenu`,`PrixMenu`, `Entree`, `Plat`, `ChoixDessert`, `TypeMenu`,`RestotId`)
    VALUES
        ('Rose', 29, 'salade', 'viande', 'gateau','gastro', 'Desange'),
('Bleu', 14, 'bettrave', 'riz', 'yaourt','enfant', 'Arte'),
('Rouge', 24, 'salade', 'couscous', 'chocolat','vegetarien', 'King'),
('Jien', 45, 'carrote', 'goudougoudou', 'beignet','vegetarien', 'Panthouse'),
('Orange', 23, 'aubergine', 'fufu', 'yaourt','gastro', 'Alchmy'),
('Herbe', 34, 'concombre', 'tiep', 'gateau','gastro', 'Soul'),
('Gayon', 35, 'salade', 'chawarma', 'fondant','enfant', 'Loey');


-- insertion des attractions
INSERT INTO `Attraction` (`idNomAttract`, `NumeroTel`, `adresse`, `LongitudeAttract`, `LatitudeAttract`, `TypeAttraction`,`HoraireOuverture`,`NoteAttract`,`numOffreId`)
VALUES ('Titapolis',0654885210,'23 Rue May',20.4,58.8,'Aquariums','10:20',3,1),
       ('Diablrpolis',0652555210,'13 Rue julien',37.4,45.8,'Musée','8:50',2,3),
       ('Génimonde',0705561218,'23 rue de la croix',10.7,18.1,'Parc','9:30',3,2),
       ('Fantopolis',0754855216,'28 rue Astrid',18.7,58.8,'Aquariums','10:30',3,6),
       ('Zombiland',0754885220,'5 Rue Maylie',21.4,28.8,'Espace vert','12:20',3,5),
       ('La Zone Orange',0654885561,'15 Rue Mouche',30.5,8.8,'Site touristique','10:20',4,4),
       ('Le pays des cauchemars',0754885228,'27 Rue sollide',20.4,58.8,'Espace vert','11:45',5,5),
       ('La pente',0684885217,'26 Rue trou',52.4,45.8,'Aquariums','14:20',5,8),
       ('Escaladeur',0794885210,'1 Rue Mulatière',21.5,48.8,'Parc','15:20',2,9),
       ('La Petite Sirène',0654775210,'21 Rue de poulet',20.4,38.8,'Musée','12:20',3,3);

UPDATE activites
SET TypePublic ='Adulte'
WHERE IdnomActivite='Marche';
UPDATE activites
SET TypeActivite ='Visite Guidéé'
WHERE IdnomActivite='Parachute';


-- Insertion de la table Activités
    INSERT INTO `Activites` (`IdnomActivite`, `description`, `Duree`,`PrixActivite`, `typePublic`,`TypeActivite`, `nomAttractId`) VALUES
('RollerCoaster', 'attraction sur siege', 15, 10, 'Adulte','Concert', 'Titapolis'),
('Coast', 'pour les enfants courageux', 15, 10, 'Enfant','Atelier', 'Diablrpolis'),
('Jet', 'une belle vue en hauteur', 20, NULL, 'Enfant','concert', 'Fantopolis'),
('Avion', 'en plein ciel', 45, NULL, 'Enfant','atelier', 'Zombiland'),
('Parachute', 'haute voltige', 35, 60, 'Adulte','Visite Guidée', 'La Zone Orange'),
('Mirroir', 'trouver la sortie', 10,NULL, 'Enfant','atelier', 'Escaladeur'),
('chant', 'en lisse sur piste', 10, 20, 'Enfant','concert', 'La pente'),
('Rando', 'détente', 60, NULL, 'Enfant','Visite Guidée', 'Le pays des cauchemars'),
('Marche', 'pure detente', 60,5, 'Adulte', 'Visite Guidée','La Petite Sirène'),
('Voltige', 'au risque', 30, 45, 'Adulte','Atelier','Génimonde');




-- insertion liste photos
    INSERT INTO ListePhoto(`IdnomListe`, `nomAttractid`,`nomHebergeid`,`nomRestoid`)
    VALUES ('Le Mont-Beuvay','Titapolis',NULL,NULL),
           ('Le château de Bazoches','Diablrpolis',NULL,NULL),
            ('La Nature','Fantopolis',NULL,NULL),
            ('Slow travel','Génimonde',NULL,NULL),
            ('Univers du vin',NULL, 'Poot',NULL),
            ('Rivière',NULL,'Vingn',NULL),
            ('Slow ski',NULL,'Pomme',NULL),
            ('Bien être',NULL,'Faise',NULL),
            ('Montage',NULL,'Timea',NULL),
            ('Culture',NULL, NULL,'Desange'),
            ('Marché  du Noel',NULL,NULL,'Arte'),
            ('Randonnéé',NULL,NULL,'King');


-- Insertion des internautes
INSERT INTO `Internautes` (`Idemail`,`Pseudo`, `MotDePasse`, `VilleInternaute`)
VALUES('internaute-1@gmail.com','Internaute_1','12Internaute','Nantes',
      ('internaute02@gmail','Fluxy','02fluxy','Toulouse'),
      ('scubrinainternaute@gmail.com','Scrubina','scrubina10','Béziers'),
      ('saki@gmail.com','Saki','3004Saki','Lille'),
      ('mooney.54@gmail.com','Mooney','54@Mooney','Nice'),
      ('technikal99@gmail.com','Technikal','99 Technikal','Grenoble'),
      ('prodigy@gmail.com','Prodigy','&prodigy9','Saint-Etienne'),
      ('neon.44@gmail.com','Neon','&65 Neon','Metz'),
      ('kardiak87@gmail.com','Kardiak','74@kardiak','Amiens'),
      ('thecrew@gmail.com','TheCrew','Crew28','Limoges')
;

-- Insertion de la table Avis
INSERT INTO `Avis` (`IdnumAvis`,`Commentaire`, `noteAvis`, `DateAvis` ,`emailId`,`nomRestoid`,`nomActiviteId`, `nomHergeId`,`nomAttactionId`,`TypeTourisme`) VALUES
( 1,'tres bon resto', 3 , '2023-12-01', 'internaute-1@gmail.com','Alchmy',NULL, NULL,NULL,'Couple'),
( 2,'bon accueil', 2 , '2023-05-10' , 'internaute02@gmail', NULL, NULL, 'Lopli',NULL,'Famille'),
( 11,'belle activite', 1 , '2023-07-21' , 'internaute-1@gmail.com',NULL, 'Rando', NULL,NULL,'Solo'),
( 32,'pas mal comme resto', 4 , '2023-01-01' , 'internaute-1@gmail.com',NULL,NULL, 'Serr',NULL,'Amis'),
( 54,'génial', 3 , '2023-12-01' , 'internaute-1@gmail.com', NULL, NULL, 'Poot',NULL,'Solo'),
( 3,'excellent', 4 , '2023-10-21' , 'scubrinainternaute@gmail.com', NULL,'RollerCoaster', NULL,NULL,'Amis'),
( 4,'moyen l accueil', 1 , '2023-08-23' ,  'saki@gmail.com',NULL ,NULL, 'Timea',NULL,'Couple'),
( 5,'activite amusante', 5 , '2023-01-12' , 'mooney.54@gmail.com', NULL, NULL, 'Divin',NULL,'Famille'),
( 6,'tres bon activite', 4 , '2023-04-14', 'technikal99@gmail.com', 'King', NULL, NULL,NULL,'Couple'),
( 45,'Woahh', 1 , '2023-10-15', 'technikal99@gmail.com', NULL,'Coast', NULL,NULL,'Solo'),
( 7,'beau paysage', 3 , '2023-09-01' , 'prodigy@gmail.com', NULL,'Jet', NULL,NULL,'Amis'),
( 8,'Bien', 2 , '2023-05-20' , 'neon.44@gmail.com', NULL, NULL, 'Fiel',NULL,'Famille'),
( 9,'rien a redire', 5, '2023-07-08', 'kardiak87@gmail.com','Soul',NULL, NULL,NULL,'Couple'),
( 10,'impecable', 2 , '2023-10-06', 'thecrew@gmail.com', 'Desange', NULL, NULL,NULL,'Amis'),
( 70,'waaoh super', 4 , '2021-10-06', 'thecrew@gmail.com', NULL, NULL, NULL,'La Petite Sirène','Solo'),
( 21,'Null vraiment ', 5 , '2022-11-06', 'kardiak87@gmail.com', NULL, NULL, NULL,'Zombiland','Famille'),
( 18,'pas mal comme attraction', 3 , '2021-10-06', 'kardiak87@gmail.com', NULL, NULL, NULL,'Génimonde','Solo'),
( 23,'boff', 2 , '2022-12-06', 'technikal99@gmail.com', NULL, NULL, NULL,'Escaladeur','Famille'),
(49,'extra', 5 , '2021-11-06', 'prodigy@gmail.com',NULL, NULL, NULL,'Génimonde','Couple'),
(89,'Yeahhh', 5 , '2021-11-23','mooney.54@gmail.com' ,NULL, NULL, NULL,'Escaladeur','Famille'),
(99,'trop cool', 5 , '2021-11-20','prodigy@gmail.com' ,NULL, NULL, NULL,'Escaladeur','Famille')
;



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

-- 11)
SELECT At.idNomAttract,At.Adresse,At.TypeAttraction FROM attraction At
INNER JOIN Offres O ON At.numOffreId = O.IdnumOffre
INNER JOIN Activites act ON At.idNomAttract = act.nomAttractId
INNER JOIN Avis A on act.IdnomActivite = A.nomActiviteId
WHERE act.TypePublic='Enfant'
AND A.TypeTourisme ='Famille'
AND O.Ville ='Caen'
AND act.PrixActivite IS NULL
AND At.HoraireOuverture BETWEEN '11:00:00' AND '15:00:00'
AND A.NoteAvis > 4;

-- 12)
    SELECT o.IdnumOffre, o.ville FROM offres o
    INNER JOIN restaurant R On o.IdnumOffre = R.numOffreId
    INNER JOIN Avis A on R.IdnomResto = A.nomRestoid
    WHERE A.TypeTourisme='Couple'
    GROUP BY nomRestoid,nomAttactionId,nomHergeId
    ORDER BY
     AVG(A.NoteAvis) DESC;

--  Creation des index multi-colonnes sur TypeTourisme, NoteAvis et DateAvis dans la table Avis
CREATE INDEX idx_TypeTourisme_NoteAvis_DateAvis
ON Avis (TypeTourisme, NoteAvis, DateAvis);

-- Creation des indexs multi-colonnes sur TypeMenu et PrixMenu dans la table Menu
CREATE INDEX idx_TypeMenu_PrixMenu
ON Menu (TypeMenu, PrixMenu);

-- Création de l'interanute
CREATE USER 'internauteS1W1M2H2'@'localhost' IDENTIFIED BY 'Warha30';
GRANT SELECT ON tpWSHM TO 'internauteS1W1M2H2'@'localhost';

-- Création du gestionnaire
CREATE USER 'gestionnaireS1W1M2H2'@'localhost' IDENTIFIED BY 'Warha30';
GRANT SELECT, INSERT, UPDATE, DELETE ON tpWSHM TO 'gestionnaireS1W1M2H2'@'localhost';

-- Création de l'administrateur
CREATE USER 'administrateurS1W1M2H2'@'localhost' IDENTIFIED BY 'Warha30';
GRANT ALL PRIVILEGES ON tpWSHM TO 'administrateurS1W1M2H2'@'localhost';


-- Création de l'utiliasteur
CREATE USER 'utilisateurS1W1M2H2'@'localhost' IDENTIFIED BY 'Warha30';
GRANT INSERT ON tpWSHM.internautes TO 'utilisateurS1W1M2H2'@'localhost';
GRANT INSERT ON tpWSHM.avis TO 'utilisateurS1W1M2H2'@'localhost';

-- Création d'une vue B11
CREATE VIEW vueB11 AS
SELECT At.idNomAttract,At.Adresse,At.TypeAttraction
FROM attraction At
INNER JOIN Offres O ON At.numOffreId = O.IdnumOffre
INNER JOIN Activites act ON At.idNomAttract = act.nomAttractId
INNER JOIN Avis A on act.IdnomActivite = A.nomActiviteId
WHERE act.TypePublic='Enfant'
AND A.TypeTourisme ='Famille'
AND O.Ville ='Caen'
AND act.PrixActivite IS NULL
AND At.HoraireOuverture BETWEEN '11:00:00' AND '15:00:00'
AND At.NoteAttract > 4;

-- Creation des  triggers

CREATE TRIGGER trig1
BEFORE INSERT ON Restaurant
FOR EACH ROW
BEGIN
   IF ``.Restaurant.CategoriePrix>3 OR ``.Restaurant.CategoriePrix<1 THEN
       SIGNAL SQLSTATE '45000' set message_text = 'Le prix n entre pas dans la catégorie';
       END IF;
END;

-- Création d'une procédure stockée

CREATE PROCEDURE procB12(IN IdnumOffre INT)
BEGIN
    SELECT o.IdnumOffre, o.ville FROM offres o
    INNER JOIN restaurant R On o.IdnumOffre = R.numOffreId
    INNER JOIN Avis A on R.IdnomResto = A.nomRestoid
    WHERE A.TypeTourisme='Couple'
    GROUP BY nomRestoid,nomAttactionId,nomHergeId
    ORDER BY
     AVG(A.NoteAvis) DESC;
END;
CALL procB12(4);

