#Fastpizza
*Application pour g�rer l�ensemble des pizzerias*

##Pizzeria
- Num�ro unique
- Nom
- Adresse postale (num�ro de rue, rue, code postal, ville)
- Responsable g�rant 
- Liste employ�s
- Liste des vari�t�s de pizza g�r�es

##Responsable g�rant
- Affect� � une seule pizzeria <- employ� de la pizzeria

##Pizza
- Plusieurs vari�t�: reine, marguerite, calzone �
	- Ensemble d�ingr�dients de base
- Taille�: grande, moyenne, mini
- Prix
- Ingr�dient optionnel (max d�ingr�dients en fonction de la taille, respectivement, 2, 4 ou +?) prix d�un ingr�dient optionnel�: 2�

##Livreurs
- Affect� � une seule pizzeria <- employ� de la pizzeria
- Badge num�rot� (num�ro de la pizzeria)
- Nom
- Pr�nom
- Date de naissance
- Num tel
- Adresse mail
- Adresse postale (num rue, rue, code postal, ville)
- Type de permis v�hicule (B, BSR, �)

##Client
- Num�ro unique par pizzeria
- Nom 
- Pr�nom
- Num tel
- @ mail
- Adresse postale (num rue, rue, code postal, ville)
- Commande
	- Num�ro de commande
	- Lignes de commande
		- Vari�t� pizza
		- Taille pizza
		- (Ingr�dients optionnels)
		- Nombre de cette pizza
	- Prix
	- Heure de livraison d�sir�e

##Livraison
- Livreur
- V�hicule de livraison
- Une ou plusieurs commandes
- Heure de d�part
- Heure de retour

##V�hicule de livraison
- Plaque d�immatriculation
- Type (B�: voiture, BSR�: mobilette, �)

