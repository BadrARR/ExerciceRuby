#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'

class Html 
  #chargement et gestion des exceptions lors de l'ouverture du fichier
  def charger(url)
  	website = open(url)
  	return website
  rescue
  	puts "Erreur lors du chargement du site"
  end

  #Nokogiri pour l'utilisation des selector CSS
  def parser(site)
    document = Nokogiri::HTML(site)
    return document
  end
end



class Resultats
  #fonction qui prend en param le document resutlant et la classe CSS tel qu'elle est définie sur la page HTML
  def afficher_article_5c(doc, class_css)
  	puts "*****************Affichage des valeurs avec 5c"
    titre_5_c = doc.css(class_css) #retourne a array contenant tous les elmts de la classe
  	compteur = 0
  	titre_5_c.each do |val| #parcours de l'array
      break if compteur == 3 #compteur de nbre d'affichage
  	  if val.content.include? "5c" #verifie si le titre contient 5c
  	  	str = val.content.to_s 
  	  	str.strip!
  	    puts str
  	    compteur += 1 #incremente le compteur d'affichage uen fois une valeur trouvé
  	  end
    end   	
  end 

  #fonction prend en param le doc resultant et la classe css tel qu'elle est déf sur la page html
  def calculer_total_prix(doc, class_css)
    puts "*****************Somme total des prix" 
  	compteur = 0.0 #compteur des prix
  	somme = doc.css(class_css) #retourne a array contenant tous les elmts de la classe
  	somme.each do |calcul| #parcours de l'array
  	  str = String(calcul.content).split("€").first.delete(' ') #conversion en string et suppression des espaces et du signe € 
  	  compteur += str.to_f # conversion en float puis calcule de la somme 
    end
    puts "somme total = #{compteur}"
  end

  #fonction prend en param le doc resultant et la classe css tel qu'elle est déf sur la page html
  def calculer_total_article_sup_200(doc, class_css)
  	puts "*****************Somme total des articles avec un prix > 200€"
  	nbre_article_sup_200 = 0 #compteur des articles sup a 200
  	somme = doc.css(class_css) #retourne a array contenant tous les elmts de la classe
  	somme.each do |calcul| #parcours de l'array
  	  str = String(calcul.content).split("€").first.delete(' ') #conversion en string et suppression des espaces et du signe € 
  	  nbre_article_sup_200 += 1 if str.to_f>200 # conversion en float puis vérification de la valeur. Si >200 on incremente compteur des articles >200
    end
    puts "#{nbre_article_sup_200}"	
  end
end


url = "https://www.leboncoin.fr/telephonie/offres/ile_de_france/?f=a&th=1&ps=8&pe=11&q=iphone"
lien = Html.new 
charger_doc = lien.charger(url)
parser_doc = lien.parser(charger_doc)
results = Resultats.new
results.afficher_article_5c(parser_doc,'h2.item_title')
results.calculer_total_prix(parser_doc,'h3.item_price')
results.calculer_total_article_sup_200(parser_doc,'h3.item_price')
