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
--les noms des colonnes de cette table. 
create function collonnesDe(@tableNom varchar(30))
as
begin
	 declare @collonnes
	  return(select top 0 * from Article )
end
