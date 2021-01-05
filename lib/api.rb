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
        #binding.pry          #all card info is in arrays under the key called ":cards"
#         data.each(sjonObj, function(key, value){
#     if (value === "" || value === null){
#         delete sjonObj[key];
#     }
# })
        data.each do |pokemon_data| 
            #binding.pry        #sorts each array and 
             PokemonClass.new(pokemon_data)       #adheres it to a new Pokemon. 
            end
    end
  
end

# def get_names
#         data["cards"].each do |hash|
#             hash.map do |key, value|
#                 [:key]
#         end
#     end
# end