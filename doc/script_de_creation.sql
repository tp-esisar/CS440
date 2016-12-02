CREATE TABLE VarietePizza (
  idVariete VARCHAR2(50),
  taille NUMBER NOT NULL,
  prix NUMBER(*,2) NOT NULL,
  CONSTRAINT pkVarietePizza PRIMARY KEY (idVariete),
  CONSTRAINT VarietePizza_Taille CHECK(taille>0 AND taille<4)
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
  CONSTRAINT pkPersonne PRIMARY KEY(idPersonne),
  CONSTRAINT Personne_numTelephone CHECK (numTelephone BETWEEN 0100000000 AND 0999999999),
  CONSTRAINT Personne_codePostal CHECK (codePostal BETWEEN 01000 AND 99999),
  CONSTRAINT Personne_numeroRue CHECK (numeroRue>0)
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
  CONSTRAINT pk_Pizzeria PRIMARY KEY (idPizzeria),
  CONSTRAINT fk_Gerant_Pizzeria FOREIGN KEY (idGerant) REFERENCES Personne(idPersonne),
  CONSTRAINT Pizzeria_codePostal CHECK(codePostal BETWEEN 01000 AND 99999),
  CONSTRAINT Pizzeria_numeroRue CHECK(numeroRue>0)
);
  
CREATE TABLE IngredientOptionnels (
  idIngredient VARCHAR2(50),
  disponible NUMBER(1) NOT NULL,
  CONSTRAINT pk_ingredientsOptionnels PRIMARY KEY(idIngredient)
);

CREATE TABLE Permis (
  typePermis VARCHAR2(50),
  CONSTRAINT pk_permis PRIMARY KEY(typePermis),
  CONSTRAINT Permis_typePermis CHECK (typePermis IN ('AM', 'A1', 'A2', 'A', 'B1', 'B', 'C1', 'C', 'D1', 'D', 'BE', 'C1E', 'CE', 'D1E', 'DE'))
);

CREATE TABLE VehiculeLivraison (
  idPlaque VARCHAR2(50),
  idpizzeria NUMBER NOT NULL,
  typePermis VARCHAR2(50) NOT NULL,
  supprime NUMBER(1),
  CONSTRAINT pk_Vehicule PRIMARY KEY (idPlaque),
  CONSTRAINT fk_typePermis_Vehicule FOREIGN KEY (typePermis) REFERENCES Permis(typePermis),
  CONSTRAINT pk_idPizzeria_Vehicule FOREIGN KEY (idpizzeria) REFERENCES Pizzeria(idpizzeria)
);

CREATE TABLE Client (
  idClient NUMBER,
  idPizzeria NUMBER,
  idPersonne NUMBER NOT NULL,
  CONSTRAINT pk_client PRIMARY KEY (idClient, idPizzeria),
  CONSTRAINT fk_idPizzeria_client FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  CONSTRAINT fk_idPersonne_client FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livreur (
  idBadge NUMBER,
  idPizzeria NUMBER,
  idPersonne NUMBER NOT NULL,
  dateNaissance DATE NOT NULL,
  supprime NUMBER(1),
  CONSTRAINT pk_livreur PRIMARY KEY (idBadge, idPizzeria),
  CONSTRAINT fk_idPizzeria_livreur FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  CONSTRAINT fk_idPersonne_livreur FOREIGN KEY (idPersonne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Livraison (
  idLivraison NUMBER,
  idPlaque VARCHAR2(50) NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idBadge NUMBER NOT NULL,
  CONSTRAINT pk_livraison PRIMARY KEY(idLivraison),
  CONSTRAINT fk_idBadge_livraison FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  CONSTRAINT fk_idPlaque_livraison FOREIGN KEY (idPlaque) REFERENCES VehiculeLivraison(idPlaque)
);

CREATE TABLE Commande (
  idCommande NUMBER,
  idClient NUMBER NOT NULL,
  idPizzeria NUMBER NOT NULL,
  idLivraison NUMBER,
  heurePrevue DATE,
  heureDepart DATE,
  heureArrivee DATE,
  etatCommande NUMBER NOT NULL,
  CONSTRAINT pk_commande PRIMARY KEY (idCommande),
  CONSTRAINT fk_client_commande FOREIGN KEY (idClient, idPizzeria) REFERENCES Client(idClient, idPizzeria),
  CONSTRAINT fk_livraison_commande FOREIGN KEY (idLivraison) REFERENCES Livraison(idLivraison)
);

CREATE TABLE PossessionPermis (
  typePermis VARCHAR2(50),
  idPizzeria NUMBER,
  idBadge NUMBER,
  CONSTRAINT pk_possessionPermis PRIMARY KEY (typePermis, idBadge, idPizzeria),
  CONSTRAINT fk_livreur_possessionPermis FOREIGN KEY (idBadge, idPizzeria) REFERENCES Livreur(idBadge, idPizzeria),
  CONSTRAINT fk_permis_possessionPermis FOREIGN KEY (typePermis) REFERENCES Permis(typePermis)
);

CREATE TABLE Pizza (
  idPizza NUMBER,
  idCommande NUMBER,
  idVariete  VARCHAR2(50) NOT NULL,
  nbPizza NUMBER NOT NULL,
  prixPizza NUMBER(*,2) NOT NULL,
  CONSTRAINT pk_pizza PRIMARY KEY(idPizza, idCommande),
  CONSTRAINT fk_idVariete_pizza FOREIGN KEY (idVariete) REFERENCES VarietePizza(idVariete),
  CONSTRAINT fk_idCommande_pizza FOREIGN KEY (idCommande) REFERENCES Commande(idCommande),
  CONSTRAINT pizza_nbPizza CHECK (nbPizza>0)
);

CREATE TABLE OptionnelPizza (
  idPizza NUMBER,
  idIngredient VARCHAR2(50),
  idCommande NUMBER,
  CONSTRAINT pk_optionnelPizza PRIMARY KEY (idPizza, idIngredient, idCommande),
  CONSTRAINT fk_pizza_optionnelPizza FOREIGN KEY (idPizza, idCommande) REFERENCES Pizza(idPizza, idCommande),
  CONSTRAINT fk_ingredients_optionnelPizza FOREIGN KEY (idIngredient) REFERENCES IngredientOptionnels(idIngredient)
);

CREATE TABLE PizzaProduite (
  idPizzeria NUMBER,
  idVariete VARCHAR2(50),
  CONSTRAINT pk_pizzaProduite PRIMARY KEY (idPizzeria, idVariete),
  CONSTRAINT fk_idPizzeria_pizzaProduite FOREIGN KEY (idPizzeria) REFERENCES Pizzeria(idPizzeria),
  CONSTRAINT fk_idVariete_pizzaProduite FOREIGN KEY (idVariete) REFERENCES VarietePizza(idVariete)
);


