# require 'pry'
# require 'rubygems'
# require 'httparty'
# require 'json'

class Api 
    attr_accessor :all_data
    
    
    all_data = []
    
    def self.cards_url
        "https://api.pokemontcg.io/v1/cards"
    end 

    def self.all_data
        get_pokemon_data
    end

    def self.get_pokemon_data               #pulls data hash from URL
        response = HTTParty.get(cards_url)  #converts JSON data into nested array that we'll call 'response'
        data = response["cards"]  
            data.each do |pokemon_data| 
                                              #sorts each array and 
             PokemonClass.new(pokemon_data)       #adheres it to a new Pokemon. 
            end
    end
  
end
