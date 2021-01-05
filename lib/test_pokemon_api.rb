# require 'net/http'
# require 'open-uri'
# require 'json'
# require 'httparty'
# #require 'pokemon_tcg_sdk'
 
# class GetPokemon
#    #https://docs.pokemontcg.io/#api_v1cards_list
#   URL = "https://api.pokemontcg.io/v1/cards"

#   def get_pokemon
#     uri = URI.parse(URL)
#     response = Net::HTTP.get_response(uri)
#     response.body
#   end

#   def parse_json
#     # we use the JSON library to parse the API response into nicely formatted JSON
#       pokecards = JSON.parse(self.get_pokemon)
#       pokecards.map do |info|
#         info
#       end
#     end
# end

# pokecards = GetPokemon.new
# puts pokecards.parse_json
