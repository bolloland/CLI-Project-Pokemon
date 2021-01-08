
class PokemonClass 
    attr_accessor :name, :pokedex_no, :type, :hp, :attacks, :weaknesses, :att, :weak, :supertype, :get_attacks, :pic

    @@all = []
  
    def initialize(pokemon_data)
        self.name = pokemon_data["name"] 
        self.pokedex_no = pokemon_data["nationalPokedexNumber"]
        self.supertype = pokemon_data["supertype"]
        self.type = pokemon_data["types"] #.join()
        self.hp = pokemon_data["hp"]
        self.attacks = pokemon_data["attacks"]
        self.weaknesses = pokemon_data["weaknesses"] #.map {|w| w.values[0]}
        self.pic = pokemon_data["imageUrlHiRes"]
        @@all << self
    end
    
    def self.all
        @@all
    end
end
    