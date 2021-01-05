# require 'pry'
class Cli
    attr_accessor :input, :name_array, :pokemon_index_name, :pokedex_input, :alpha_input, :d, :attack_array, :type_input, :match_type_input, :ten_types, :tt

    # def render_ascii_art
    # File.readlines("../lib/ascii.rb") do |line|
    #     puts line
    #     end
    # end
    puts <<-'ART'.yellow
                                  ,'\                             
    _.----.        ____         ,'  \   ___    ___     ____       
_,-'       `.     |    |  /`.   \,-'    |   \  /   |   |    \  |`. 
\      __    \    '-.  | /   `.  ___    |    \/    |   '-.   \ |  |
 \.    \ \   |  __  |  |/    ,','_  `.  |          | __  |    \|  |
   \    \/   /,' _`.|      ,' / / / /   |          ,' _`.|     |  |
    \     ,-'/  /   \    ,'   | \/ / ,`.|         /  /   \  |     |
     \    \ |   \_/  |   `-.  \    `'  /|  |    ||   \_/  | |\    |
      \    \ \      /       `-.`.___,-' |  |\  /| \      /  | |   |
       \    \ `.__,'|  |`-._    `|      |__| \/ |  `.__,'|  | |   |
        \_.-'       |__|    `-._ |              '-.|     '-.| |   |
                                `'                            '-._|
ART

    #system(“clear”) - to clear screen'
    @ten_types = []

    def start 
         
        puts "~~~~~~~~~~~~~~~~~~~~Welcome to N.O.S.P.I.C.!~~~~~~~~~~~~~~~~~~~~~~~~~".blue
        puts "           New Online Smallish Pokemon Information Database!".blue
        Api.all_data  # << api get info method - check!
        main_menu
    end

    def main_menu
        puts ""
        puts "                      Welcome Trainers!!!                            ".yellow
        puts "     Use the menu below to explore the Pokemon on this island!       ".yellow
        what_letter
    end

    def what_letter
        puts ""
        puts "Type 'P' to list all (P)okemon by name.".cyan
        puts "Type 'T' to list all Pokemon (T)ypes.".cyan
        puts "Type 'X' to e(x)it the program.".cyan
        puts ""
        puts "Enter letter here:  ".magenta
        input = gets.strip
        
        if input == "P" || input == "p"
            indexed_by_name         # << list of all pokemon by name(or Pokedex #?)
        elsif input == "T"|| input == "t"
            list_pokemon_types
        elsif input == "X" || input == "x"
            puts "Exiting out...gotta catch 'em all!"
            exit     
        else
            puts "I didn't understand that...look again at your options:"
            what_letter
        end
    end

    def alpha_pokemon #sorted by Pokemon.name, indexed 0-99!
        #binding.pry
        PokemonClass.all.sort_by {|p| p.name}
    end
    
    def indexed_by_name #CLI menu list with index by Pokemon.name
        alpha_pokemon.each.with_index(1) {|p, ind| puts "#{ind}. #{p.name.cyan} "}
        pokemon_options
    end
    # binding.pry
    
    def pokemon_options
        puts ""
        puts "If you want more information about a Pokemon, enter its corresponding number below!".yellow
        puts "(If you want the main manu, hit 'M', and if you want to exit, hit 'X'.)".blue
        puts ""
        @pokedex_input = gets.strip
   
        if pokedex_input.to_i.between?(1, 100) 
            @alpha_input = pokedex_input.to_i-1
            pokemon_details(alpha_input)
        elsif pokedex_input == "M" || pokedex_input == "m"
            what_letter
        elsif pokedex_input == "X" || pokedex_input == "x"
            puts "Exiting out...Go catch 'em all!"
            puts ""
            exit  
        else
            puts "Sorry! You entered a non-existant number or I don't understand that command!"
            puts "Please, try again!"  
            pokemon_options
        end
    end

    def pokemon_details(alpha_input)
        @d = alpha_pokemon[alpha_input]
        puts "***********************************".yellow
        pokemon_name
        pokemon_supertype
        pokemon_number
        pokemon_hit_points
        pokemon_type
        pokemon_attacks
        pokemon_weaknesses
        puts "***********************************".yellow
        puts ""
        pokemon_options
    end

        def pokemon_name
            puts "Name: #{d.name.green}"
        end
        
        def pokemon_number
            puts "Pokedex Number: #{d.pokedex_no}" #why won't this take a color?
        end
        
        def pokemon_hit_points
            if d.hp == nil
                puts "Hit Points: This is a #{d.supertype.light_green} card, it doesn't have Hit Points."
            else
                puts "Hit Points: #{d.hp.light_green}"
            end
        end
        
        def pokemon_type
            if d.type == nil
                puts "Type: This card has no specific Type."
            else
                puts "Type: #{d.type.join().light_green}"
            end
        end

        def pokemon_supertype
            puts "Supertype: #{d.supertype.light_green}"
        end
        
        def pokemon_attacks
            #binding.pry
            if d.attacks == nil
                puts "Attacks: There are no Attacks for this card."
            else       
                @attack_array = []
                d.attacks.each do |x|
                @attack_array << x["name"]
            end   #x.values[1]                 
                puts "Attacks: #{@attack_array.join(", ").light_green}"
            end
        end

        def pokemon_weaknesses
            # binding.pry
            if d.weaknesses == nil
                puts "Weaknesses: There are no Weaknesses for this card."
            else
            d.weaknesses.map do |w|
                puts "Weaknesses: #{w.values[0].light_green}"
                end
            end
        end

    def list_pokemon_types
        all_types = []
        PokemonClass.all.each do |t|
            all_types << t.type
        end
            @ten_types = all_types.uniq.flatten.compact
        
            @ten_types.each.with_index(1) {|type, indx| puts "#{indx}. #{type}"}
            puts "***********************************"
            type_options
    end

    def type_options
        puts "To see all Pokemon of that type,"
        puts " enter its corresponding number below:"
        puts "  (If you want the main manu, hit 'M', and if you want to exit, hit 'X'.)"
        puts ""
        @type_input = gets.strip
        puts "***********************************" 
        if type_input.to_i.between?(1, 10) 
            @match_type_input = type_input.to_i-1
            match_type(match_type_input)
        elsif pokedex_input == "M" || pokedex_input == "m"
            what_letter
        elsif pokedex_input == "X" || pokedex_input == "x"
            puts "Exiting out...Go catch 'em all!"
            puts ""
            exit  
        else
            puts "Sorry! You entered a non-existant number or I don't understand that command!"
            puts "Please, try again!"  
            type_options
        end
    end
    
    def  match_type(match_type_input)
        @tt = []
        @tt << @ten_types[match_type_input]
        puts "These are all #{@ten_types[match_type_input]} types of Pokemon:"
        # PokemonClass.all.each do |t|
        #     if t.type.downcase == type_input.downcase
        alpha_pokemon.each.with_index(1) do |p, ind|
            #binding.pry
            if @tt == p.type
                puts "#{ind}. #{p.name}"
            end
        end
        puts ""
        pokemon_options
    end

end