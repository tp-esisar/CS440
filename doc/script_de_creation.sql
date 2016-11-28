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
  rue VARCHAR2(50),
  numeroRue NUMBER,
  PRIMARY KEY(idPersonne)
);

CREATE TABLE Pizzeria (
  idPizzeria NUMBER,
  idGerant NUMBER,
  nom VARCHAR2(50),
  ville VARCHAR2(50),
  codePostal NUMBER,
  rue VARCHAR2(50),
  numeroRue NUMBER,
  PRIMARY KEY (idPizzeria),
  FOREIGN KEY (idGerant) REFERENCES Personne(idPersonne)
);
  
CREATE TABLE IngredientOptionnels (
  idIngredient VARCHAR2(50),
  PRIMARY KEY(idIngredient)
);

CREATE TABLE Permis (
  typePermis VARCHAR2(50),
  PRIMARY KEY(typePermis)
);

CREATE TABLE VehiculeLivraison (
  idPlaque VARCHAR2(50),
  typePermis VARCHAR2(50),
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
  PRIMARY KEY (idBadge, idPizzeria),
  FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livraison (
  idLivraison NUMBER,
  idPlaque VARCHAR2(50),
  idPizzeria NUMBER,
  idBadge NUMBER,
  heureDepart DATE,
  heureArrivee DATE,
  PRIMARY KEY(idLivraison),
  FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  FOREIGN KEY (idPlaque) REFERENCES VehiculeLivraison(idPlaque)
);

CREATE TABLE Commande (
  idCommande NUMBER,
  idLivraison NUMBER,
  heurePrevue DATE,
  etatCommande NUMBER,
  prixTotal NUMBER(*,2),
  PRIMARY KEY (idCommande),
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


