CREATE TABLE VarietePizza (
  idVariete VARCHAR2(50) NOT NULL,
  taille NUMBER NOT NULL,
  prix NUMBER(*,2),
  PRIMARY KEY (idVariete)
  --CONSTRAINT VarietePizza_taille CHECK(taille > 0)
);

CREATE TABLE Personne (
  idPersonne NUMBER,
  nom VARCHAR2(50) NOT NULL,
  prenom VARCHAR2(50) NOT NULL,
  numTelephone NUMBER NOT NULL,
  adresseMail VARCHAR2(50) NOT NULL,
  ville VARCHAR2(50) NOT NULL,
  codePostal NUMBER NOT NULL,
  rue VARCHAR2(100) NOT NULL,
  numeroRue NUMBER NOT NULL,
  PRIMARY KEY(idPersonne)
  --CONSTRAINT Personne_numeroRue CHECK (numeroRue>0),
  --CONSTRAINT Personne_codePostal CHECK (codePostal BETWEEN 01000 AND 99999),
  --CONSTRAINT Personne_numTelephone CHECK (numTelephone BETWEEN 0100000000 AND 0999999999)
);

CREATE TABLE Pizzeria (
  idPizzeria NUMBER,
  idGerant NUMBER UNIQUE,
  nom VARCHAR2(50) NOT NULL,
  ville VARCHAR2(50) NOT NULL,
  codePostal NUMBER  NOT NULL,
  rue VARCHAR2(100) NOT NULL,
  numeroRue NUMBER NOT NULL,
  supprime NUMBER(1) NOT NULL,
  PRIMARY KEY (idPizzeria),
  FOREIGN KEY (idGerant) REFERENCES Personne(idPersonne)
  --CONSTRAINT Personne_numeroRue CHECK(numeroRue>0),
  --CONSTRAINT Personne_codePostal CHECK(codePostal BETWEEN 01000 AND 99999),
);
  
CREATE TABLE IngredientOptionnels (
  idIngredient VARCHAR2(50) NOT NULL,
  disponible NUMBER(1) NOT NULL,
  PRIMARY KEY(idIngredient)
);

CREATE TABLE Permis (
-- type du permis AM, A1, A2, A, B1, B, C1, C, D1, D, BE, C1E, CE, D1E, DE
  typePermis VARCHAR2(50) NOT NULL,
  PRIMARY KEY(typePermis)
  --CONSTRAINT Permis_typePermis CHECK (typePermis IN ('AM', 'A1', 'A2', 'A', 'B1', 'B', 'C1', 'C', 'D1', 'D', 'BE', 'C1E', 'CE', 'D1E', 'DE')
);

CREATE TABLE VehiculeLivraison (
  idPlaque VARCHAR2(50) NOT NULL,
  idpizzeria NUMBER NOT NULL,
  typePermis VARCHAR2(50) NOT NULL,
  supprime NUMBER(1),
  PRIMARY KEY (idPlaque),
  FOREIGN KEY (typePermis) REFERENCES Permis(typePermis),
  FOREIGN KEY (idpizzeria) REFERENCES Pizzeria(idpizzeria)
  --CONSTRAINT Permis_typePermis CHECK (typePermis IN ('AM', 'A1', 'A2', 'A', 'B1', 'B', 'C1', 'C', 'D1', 'D', 'BE', 'C1E', 'CE', 'D1E', 'DE')
);

CREATE TABLE Client (
  idClient NUMBER NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idPersonne NUMBER NOT NULL,
  PRIMARY KEY (idClient, idPizzeria),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livreur (
  idBadge NUMBER NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idPersonne NUMBER NOT NULL,
  dateNaissance DATE NOT NULL,
  supprime NUMBER(1),
  PRIMARY KEY (idBadge, idPizzeria),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livraison (
  idLivraison NUMBER NOT NULL,
  idPlaque VARCHAR2(50) NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idBadge NUMBER NOT NULL,
  PRIMARY KEY(idLivraison),
  FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  FOREIGN KEY (idPlaque) REFERENCES VehiculeLivraison(idPlaque)
);

CREATE TABLE Commande (
  idCommande NUMBER NOT NULL,
  idClient NUMBER NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idLivraison NUMBER NOT NULL,
  heurePrevue DATE,
  heureDepart DATE,
  heureArrivee DATE,
  etatCommande NUMBER NOT NULL,
  prixTotal NUMBER(*,2) NOT NULL,
  PRIMARY KEY (idCommande),
  FOREIGN KEY (idClient, idPizzeria) REFERENCES Client(idClient, idPizzeria),
  FOREIGN KEY (idLivraison) REFERENCES Livraison(idLivraison)
  --CONSTRAINT Commande_heureArrivee_heureDepart CHECK (heureArrivee > heureDepart)
);

CREATE TABLE PossessionPermis (
  typePermis VARCHAR2(50) NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idBadge NUMBER NOT NULL,
  PRIMARY KEY (typePermis, idBadge, idPizzeria),
  FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  FOREIGN KEY (typePermis) REFERENCES Permis(typePermis)
  --CONSTRAINT Permis_typePermis CHECK (typePermis IN ('AM', 'A1', 'A2', 'A', 'B1', 'B', 'C1', 'C', 'D1', 'D', 'BE', 'C1E', 'CE', 'D1E', 'DE')
);

CREATE TABLE Pizza (
  idPizza NUMBER NOT NULL,
  idCommande NUMBER NOT NULL,
  idVariete  VARCHAR2(50) NOT NULL,
  nbPizza NUMBER NOT NULL,
  prixPizza NUMBER(*,2) NOT NULL,
  PRIMARY KEY(idPizza, idCommande),
  FOREIGN KEY (idVariete) REFERENCES VarietePizza(idVariete),
  FOREIGN KEY (idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE OptionnelPizza (
  idPizza NUMBER NOT NULL,
  idIngredient VARCHAR2(50) NOT NULL,
  idCommande NUMBER NOT NULL,
  PRIMARY KEY (idPizza, idIngredient, idCommande),
  FOREIGN KEY (idPizza, idCommande) REFERENCES Pizza(idPizza, idCommande),
  FOREIGN KEY (idIngredient) REFERENCES IngredientOptionnels(idIngredient)
);

CREATE TABLE PizzaProduite (
  idPizzeria NUMBER NOT NULL,
  idVariete VARCHAR2(50) NOT NULL,
  PRIMARY KEY (idPizzeria, idVariete),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idVariete) REFERENCES VarietePizza(idVariete)
);


