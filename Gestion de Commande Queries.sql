use GestionCom

--3-	Cr�er une fonction qui lit une chaine de caract�re puis mettre 
-- en majuscule la premi�re lettre et le reste en minuscule.
create function premierLittreEnMajuscule(@chaine varchar(100))
returns varchar(100)
as 
begin
  return upper(substring(@chaine,1,1))+lower(substring(@chaine,2,len(@chaine)));
end

print dbo.premierLittreEnMajuscule('bOUtissante')


--4-	Cr�er une fonction qui permet de lire le nom d�une table puis afficher
-- les noms des colonnes de cette table. 
create function collonnesDe(@tableNom varchar(30))
returns  table
as
	 return select COLUMN_NAME from Information_schema.columns where table_name=@tableNom
select * from collonnesDe('LigneCommande')

-- 5-	Cr�er une fonction nomm�e F_ListeArticles qui return la liste
-- des articles d'une commande dont le num�ro est donn� en param�tre 
create function F_ListeArticles(@numCom int)
returns table
as
  return select l.numArt,qteCommandee,puart,qtEenStock,seuilMinimum, seuilMaximum 
  from LigneCommande l join Article a
  on l.numArt=a.numArt
  where numCom=@numCom
select * from F_ListeArticles(10)

-- 6-	Cr�er une proc�dure stock�e nomm�e PS_MontantArticles, 
-- qui utilise une fonction de calcul du montant, pour afficher la liste des lignes 
-- d�articles d'une commande dont le num�ro est donn� en param�tre.

create procedure PS_MontantArticles(@numCom int)
as 
begin
  print dbo.calMontant(@numCom)
  select l.numArt,qteCommandee,puart,qtEenStock,seuilMinimum, seuilMaximum  from LigneCommande l join Article a
  on l.numArt=a.numArt
  where numCom=@numCom
end 
exec PS_MontantArticles 10

--7-	Cr�er une fonction qui retourne une table contenant les d�tails d�une commande
create function GetCommandDetails(@numCom int)
returns @details table(numArt int,puart decimal,qtcommndee int,montant decimal)
as
begin
   insert into @details select l.numArt,puart,qteCommandee,(qteCommandee*puart)
   from LigneCommande l join Article a
   on l.numArt=a.numArt
   where numCom=@numCom
   return
end

select * from GetCommandDetails(10)