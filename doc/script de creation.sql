CREATE TABLE Client (
  idClient INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Personne_idPersonne INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(idClient, Personne_idPersonne),
  INDEX Client_FKIndex1(Personne_idPersonne)
);

CREATE TABLE Commande (
  idCommande INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  idLivraison INTEGER UNSIGNED NOT NULL,
  heurePrevue INTEGER UNSIGNED NULL,
  etatCommande INTEGER UNSIGNED NULL,
  prixTotal FLOAT NULL,
  PRIMARY KEY(idCommande),
  INDEX Commande_FKIndex1(idLivraison)
);

CREATE TABLE IngrédientOptionnels (
  idIngrédient TEXT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(idIngrédient)
);

CREATE TABLE Livraison (
  idLivraison INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  idPlaque TEXT NOT NULL,
  idPersonne INTEGER UNSIGNED NOT NULL,
  idBadge INTEGER UNSIGNED NOT NULL,
  heureDepart INTEGER UNSIGNED NULL,
  heureArrivee INTEGER UNSIGNED NULL,
  PRIMARY KEY(idLivraison),
  INDEX Livraison_FKIndex1(idBadge, idPersonne),
  INDEX Livraison_FKIndex2(idPlaque)
);

CREATE TABLE Livreur (
  idBadge INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  idPersonne INTEGER UNSIGNED NOT NULL,
  dateNaissance DATE NULL,
  PRIMARY KEY(idBadge, idPersonne)
);

CREATE TABLE Livreur_has_Permis (
  typePermis TEXT NOT NULL,
  idPersonne INTEGER UNSIGNED NOT NULL,
  idBadge INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(typePermis),
  INDEX Livreur_has_Permis_FKIndex1(idBadge, idPersonne),
  INDEX Livreur_has_Permis_FKIndex2(typePermis)
);

CREATE TABLE Permis (
  typePermis TEXT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(typePermis)
);

CREATE TABLE Personne (
  idPersonne INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nom TEXT NULL,
  prenom TEXT NULL,
  numTelephone INTEGER UNSIGNED NULL,
  adresseMail TEXT NULL,
  ville TEXT NULL,
  codePostal INTEGER UNSIGNED NULL,
  rue TEXT NULL,
  numeroRue INTEGER UNSIGNED NULL,
  PRIMARY KEY(idPersonne)
);

CREATE TABLE Pizza (
  idPizza INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  idCommande INTEGER UNSIGNED NOT NULL,
  idVariete  TEXT NOT NULL,
  nbPizza INTEGER UNSIGNED NULL,
  PRIMARY KEY(idPizza, idCommande),
  INDEX Pizza_FKIndex1(idVariete ),
  INDEX Pizza_FKIndex2(idCommande)
);

CREATE TABLE Pizza_has_IngredientOptionnels (
  idPizza INTEGER UNSIGNED NOT NULL,
  idIngrédient TEXT NOT NULL,
  idCommande INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(idPizza, idIngrédient),
  INDEX Pizza_has_IngrédientOptionnels_FKIndex1(idPizza, idCommande),
  INDEX Pizza_has_IngrédientOptionnels_FKIndex2(idIngrédient)
);

CREATE TABLE Pizzeria (
  idPizzeria INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Personne_idPersonne INTEGER UNSIGNED NOT NULL,
  nom TEXT NULL,
  ville TEXT NULL,
  codePostal INTEGER UNSIGNED NULL,
  rue TEXT NULL,
  numeroRue INTEGER UNSIGNED NULL,
  PRIMARY KEY(idPizzeria)
);

CREATE TABLE Pizzeria_has_VarietePizzeria (
  idPizzeria INTEGER UNSIGNED NOT NULL,
  idVariete TEXT NOT NULL,
  PRIMARY KEY(idPizzeria, idVariete),
  INDEX Pizzeria_has_VarietePizzeria_FKIndex1(idPizzeria),
  INDEX Pizzeria_has_VarietePizzeria_FKIndex2(idVariete)
);

CREATE TABLE VarietePizzeria (
  idVariete TEXT NOT NULL AUTO_INCREMENT,
  taille INTEGER UNSIGNED NULL,
  prix FLOAT NULL,
  PRIMARY KEY(idVariete)
);

CREATE TABLE VehiculeLivraison (
  idPlaque TEXT NOT NULL AUTO_INCREMENT,
  typePermis TEXT NOT NULL,
  PRIMARY KEY(idPlaque),
  INDEX VehiculeLivraison_FKIndex1(typePermis)
);


