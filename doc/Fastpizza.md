#Fastpizza
*Application pour gérer l’ensemble des pizzerias*

##Pizzeria
- Numéro unique
- Nom
- Adresse postale (numéro de rue, rue, code postal, ville)
- Responsable gérant 
- Liste employés
- Liste des variétés de pizza gérées

##Responsable gérant
- Affecté à une seule pizzeria <- employé de la pizzeria

##Pizza
- Plusieurs variété : reine, marguerite, calzone …
	- Ensemble d’ingrédients de base
- Taille : grande, moyenne, mini
- Prix
- Ingrédient optionnel (max d’ingrédients en fonction de la taille, respectivement, 2, 4 ou +?) prix d’un ingrédient optionnel : 2€

##Livreurs
- Affecté à une seule pizzeria <- employé de la pizzeria
- Badge numéroté (numéro de la pizzeria)
- Nom
- Prénom
- Date de naissance
- Num tel
- Adresse mail
- Adresse postale (num rue, rue, code postal, ville)
- Type de permis véhicule (B, BSR, …)

##Client
- Numéro unique par pizzeria
- Nom 
- Prénom
- Num tel
- @ mail
- Adresse postale (num rue, rue, code postal, ville)
- Commande
	- Numéro de commande
	- Lignes de commande
		- pizza
		- Nombre de cette pizza
	- Prix
	- Heure de livraison désirée

##Livraison
- Livreur
- Véhicule de livraison
- Une ou plusieurs commandes
- Heure de départ
- Heure de retour

##Véhicule de livraison
- Plaque d’immatriculation
- Type (B : voiture, BSR : mobilette, …)


