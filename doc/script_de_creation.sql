CREATE TABLE VarietePizza (
  idVariete VARCHAR2(50),
  taille NUMBER,
  prix NUMBER(*,2),
  PRIMARY KEY (idVariete)
);

CREATE TABLE Personne (
  idPersonne NUMBER,
  nom VARCHAR2(50),
  prenom VARCHAR2(50),
  numTelephone NUMBER,
  adresseMail VARCHAR2(50),
  ville VARCHAR2(50),
  codePostal NUMBER,
  rue VARCHAR2(100),
  numeroRue NUMBER,
  PRIMARY KEY(idPersonne)
);

CREATE TABLE Pizzeria (
  idPizzeria NUMBER,
  idGerant NUMBER UNIQUE,
  nom VARCHAR2(50),
  ville VARCHAR2(50),
  codePostal NUMBER,
  rue VARCHAR2(100),
  numeroRue NUMBER,
  supprime NUMBER(1),
  PRIMARY KEY (idPizzeria),
  FOREIGN KEY (idGerant) REFERENCES Personne(idPersonne)
);
  
CREATE TABLE IngredientOptionnels (
  idIngredient VARCHAR2(50),
  disponible NUMBER(1),
  PRIMARY KEY(idIngredient)
);

CREATE TABLE Permis (
-- type du permis AM, A1, A2, A, B1, B, C1, C, D1, D, BE, C1E, CE, D1E, DE
  typePermis VARCHAR2(50),
  PRIMARY KEY(typePermis)
);

CREATE TABLE VehiculeLivraison (
  idPlaque VARCHAR2(50),
  typePermis VARCHAR2(50),
  supprime NUMBER(1),
  PRIMARY KEY (idPlaque),
  FOREIGN KEY (typePermis) REFERENCES Permis(typePermis)
);

CREATE TABLE Client (
  idClient NUMBER,
  idPizzeria NUMBER,
  idPersonne NUMBER,
  PRIMARY KEY (idClient, idPizzeria),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livreur (
  idBadge NUMBER,
  idPizzeria NUMBER,
  idPersonne NUMBER,
  dateNaissance DATE,
  supprime NUMBER(1),
  PRIMARY KEY (idBadge, idPizzeria),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livraison (
  idLivraison NUMBER,
  idPlaque VARCHAR2(50),
  idPizzeria NUMBER,
  idBadge NUMBER,
  PRIMARY KEY(idLivraison),
  FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  FOREIGN KEY (idPlaque) REFERENCES VehiculeLivraison(idPlaque)
);

CREATE TABLE Commande (
  idCommande NUMBER,
  idClient NUMBER,
  idPizzeria NUMBER,
  idLivraison NUMBER,
  heurePrevue TIMESTAMP,
  heureDepart TIMESTAMP,
  heureArrivee TIMESTAMP,
  etatCommande NUMBER,
  prixTotal NUMBER(*,2),
  PRIMARY KEY (idCommande),
  FOREIGN KEY (idClient, idPizzeria) REFERENCES Client(idClient, idPizzeria),
  FOREIGN KEY (idLivraison) REFERENCES Livraison(idLivraison)
);

CREATE TABLE PossessionPermis (
  typePermis VARCHAR2(50),
  idPizzeria NUMBER,
  idBadge NUMBER,
  PRIMARY KEY (typePermis, idBadge, idPizzeria),
  FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  FOREIGN KEY (typePermis) REFERENCES Permis(typePermis)
);

CREATE TABLE Pizza (
  idPizza NUMBER,
  idCommande NUMBER,
  idVariete  VARCHAR2(50),
  nbPizza NUMBER,
  prixPizza NUMBER(*,2),
  PRIMARY KEY(idPizza, idCommande),
  FOREIGN KEY (idVariete) REFERENCES VarietePizza(idVariete),
  FOREIGN KEY (idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE OptionnelPizza (
  idPizza NUMBER,
  idIngredient VARCHAR2(50),
  idCommande NUMBER,
  PRIMARY KEY (idPizza, idIngredient, idCommande),
  FOREIGN KEY (idPizza, idCommande) REFERENCES Pizza(idPizza, idCommande),
  FOREIGN KEY (idIngredient) REFERENCES IngredientOptionnels(idIngredient)
);

CREATE TABLE PizzaProduite (
  idPizzeria NUMBER,
  idVariete VARCHAR2(50),
  PRIMARY KEY (idPizzeria, idVariete),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idVariete) REFERENCES VarietePizza(idVariete)
);


