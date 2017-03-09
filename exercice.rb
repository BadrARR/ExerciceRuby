#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'

$i = 0

begin 
  website = open("https://www.leboncoin.fr/telephonie/offres/ile_de_france/?f=a&th=1&ps=8&pe=11&q=iphone")
  doc = Nokogiri::HTML(website)
  #titre avec 5 et c
  puts "*****************Affichage des valeurs avec 5c"
  titre_5_c = doc.css('h2.item_title')
  compteur = 0
  titre_5_c.each do |val|
    break if compteur == 3 
  	if val.content.include? "5c"
  	  puts val.content
  	  compteur += 1
  	end
  end 

  #Somme de tous les articles
  puts "*****************Somme total des prix"
  compteur = 0.0
  nbre_article_sup_200 = 0
  somme = doc.css('h3.item_price')
  somme.each do |calcul|
  	str = String(calcul.content).split("€").first.delete(' ')
  	compteur += str.to_f
  	nbre_article_sup_200 += 1 if str.to_f>200 #verification des nombre d'articles sup a 200€
  end
  puts "somme = #{compteur}"
  
  puts "*****************Somme total des articles avec un prix > 200€"
  puts "#{nbre_article_sup_200}"

  rescue Exception => e
  	puts "Exception gérée"
    puts e.message 
end