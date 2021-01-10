# require 'pry'
class Cli
    attr_accessor :input, :name_array, :pokemon_index_name, :pokedex_input, :alpha_input, :d, :attack_array, :type_input, :match_type_input, :ten_types, :tt

    def pokemon_art
    puts <<-'ART'.yellow
                                  ,'\                             
    _.----.        ____         ,'  \   ___    ___     ____       
_,-'       `.     |    |  /`.   \,-''   |   \  /   |   |    \  |`. 
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
    end

    @ten_types = []

    def start 
        system("clear")
        pokemon_art
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
            puts "Exiting out...".blue + "Gotta catch 'em all!".yellow
            exit     
        else
            puts "I didn't understand that...look again at your options:"
            what_letter
        end
    end

    def alpha_pokemon #sorted by Pokemon.name, indexed 0-99!
        PokemonClass.all.sort_by {|p| p.name}
    end
    
    def indexed_by_name #CLI menu list with index by Pokemon.name  ??????COLUMNS?????
        alpha_pokemon.each.with_index(1) {|p, ind| puts "#{ind}. #{p.name.cyan} "}
        
        pokemon_options
    end
    
    def pokemon_options #gets input for individual Cards || menu options || invalid response
        puts ""
        puts "***********************************".yellow
        puts "If you want more information about a Pokemon, enter its corresponding number below!".yellow
        puts "    (If you want the main menu, hit 'M', and if you want to exit, hit 'X'.)".blue
        puts ""
        @pokedex_input = gets.strip
        if pokedex_input.to_i.between?(1, 100) 
            @alpha_input = pokedex_input.to_i-1
            pokemon_details(alpha_input)
        elsif pokedex_input == "M" || pokedex_input == "m"
            what_letter
        elsif pokedex_input == "X" || pokedex_input == "x"
            puts "Exiting out...".blue + "Gotta catch 'em all!".yellow
            puts ""
            exit  
        else
            puts "Sorry! You entered a non-existant number or I don't understand that command!".magenta
            puts "Please, try again!".magenta
            pokemon_options
        end
    end

    def pokemon_details(alpha_input) #returns leveled data based on user input
        @d = alpha_pokemon[alpha_input]
        puts "***********************************".yellow
        pokemon_name
        pokemon_supertype
        pokemon_number
        pokemon_hit_points
        pokemon_type
        pokemon_attacks
        pokemon_weaknesses
        pokemon_pic
        puts "***********************************".yellow
        
        pokemon_options
    end

        def pokemon_name #returns name
            puts "Name: #{d.name.green}"
        end
        
        def pokemon_number #returns number, if available, or alternate response for nil
            if d.pokedex_no == nil
                puts "Pokedex Number: ".white + "This is a(n) ".green + "#{d.supertype.magenta}" + " card, it doesn't have a Pokedex Number.".green
            else
                puts "Pokedex Number: #{d.pokedex_no.to_s.light_green}" 
            end
        end

        def pokemon_hit_points #returns hp, if available, or alternate response for nil
            if d.hp == nil
                puts "Hit Points: ".white + "This is a(n) ".green + "#{d.supertype.magenta}" + " card, it doesn't have Hit Points.".green
            else
                puts "Hit Points: #{d.hp.light_green}"
            end
        end
        
        def pokemon_type #returns type, if available, or alternate response for nil
            if d.type == nil
                puts "Type:".white + " This card has no specific Type.".green
            else
                puts "Type: #{d.type.join().light_green}"
            end
        end

        def pokemon_supertype #returns supertype
            puts "Supertype: #{d.supertype.light_green}"
        end
        
        def pokemon_attacks #filters out nil response, then iterates through and returns attacks 
            if d.attacks == nil
                puts "Attacks:".white + " There are no Attacks for this card.".green
            else       
                @attack_array = []
                d.attacks.each do |x|
                @attack_array << x["name"]
            end                 
                puts "Attacks: #{@attack_array.join(", ").light_green}"
            end
        end

        def pokemon_weaknesses #filters out nil response, then iterates through and returns weaknesses 
            if d.weaknesses == nil
                puts "Weaknesses: ".white + "There are no Weaknesses for this card.".green
            else
            d.weaknesses.map do |w|
                puts "Weaknesses: #{w.values[0].light_green}"
                end
            end
        end

        def pokemon_pic #returns link to hi-res photo (could be updated)
            puts "Card View: ".white + "#{d.pic.light_green}"
        end

    def list_pokemon_types #returns indexed list of unique types from alpha_list
        all_types = []
        PokemonClass.all.each do |t|
            all_types << t.type
        end
            @ten_types = all_types.uniq.flatten.compact
        
            @ten_types.each.with_index(1) {|type, indx| puts "#{indx}. #{type.light_blue}"}
            puts "***********************************"
            type_options
    end

    def type_options #returns same pokemon_details from original list of 100 || main menu || exit
        puts "To see all Pokemon of that type,".light_yellow
        puts " enter its corresponding number below:".light_yellow
        puts "  (If you want the main manu, hit 'M', and if you want to exit, hit 'X'.)".light_blue
        puts ""
        @type_input = gets.strip
        puts "***********************************" 
        if type_input.to_i.between?(1, 10) 
            @match_type_input = type_input.to_i-1
            match_type(match_type_input)
        elsif type_input == "M" || type_input == "m"
            what_letter
        elsif type_input == "X" || type_input == "x"
            puts "Exiting out...".blue + "Gotta catch 'em all!".yellow
            puts ""
            exit  
        else
            puts "Sorry! You entered a non-existant number or I don't understand that command!".magenta
            puts "Please, try again!".magenta  
            type_options
        end
    end
    
    def  match_type(match_type_input) # pulls indexed list of cards with that type
        @tt = []
        @tt << @ten_types[match_type_input]
        puts "These are all #{@ten_types[match_type_input]} types of Pokemon:"
        alpha_pokemon.each.with_index(1) do |p, ind|
            if @tt == p.type
                puts "#{ind}. #{p.name.light_blue}"
            end
        end
        pokemon_options
    end

end