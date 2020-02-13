class CommandLineInterface

    def run
        intro

        while true
            puts "\nType 'help' to see the list of available commands. Type 'quit' to exit.".magenta
            print "Enter command: ".cyan
            input = gets.chomp.downcase

            break if input == "quit"

            if input.include?("move to ")
                room = input.split("move to ")
                Resident.move_to(room[1])
            else
                case input
                when "help"
                    help
                when "list rooms"
                    Location.list_rooms
                when "list family"
                    Resident.list_family
                when "where am i"
                    Resident.where_am_i
                when "check sanity"
                    Resident.sanity
                when "search"
                    Resident.search
                when "name reminder"
                    if Resident.miranda.knowledge
                        (Ghost.find_by name: "Bael").name_reminder
                    else
                        puts "\n  Invalid command, type 'help' to see a list of available commands"
                    end
                when "banish bael"
                    if Resident.miranda.knowledge && Resident.miranda.book
                        Ghost.find_by(name: "Bael").banish
                    else
                        puts "\n  Invalid command, type 'help' to see a list of available commands"
                    end
                    exit
                else
                    puts "\n  Invalid command, type 'help' to see a list of available commands"
                end
            end
        end
    end
    
    def intro1
        puts " \nIt's been a hard year but you've finally finished moving into your new home!".green
        puts "Your name is Miranda. You have a husband named Aaron, a daughter named Olivia,".green
        puts "a cat named Mittens, and a dog named Spot.".green
    end

    def intro2
        puts "\n"
        puts "Your beautiful home has a master bedroom where you and Aaron sleep, a".green
        puts "secondary bedroom where Olivia sleeps, a kitchen, a bathroom, and a".green
        puts "living room.".green
    end

    def intro3
        puts "\n"
        puts "The realtor mentioned something about an attic but you have yet to find the ".green
        puts "entrance. Olivia also lost the key to the basement last week. Although, ".green
        puts "it's probably for the best. There were some weird carvings on the walls down ".green
        puts "there that always gave you an ".green + "uneasy feeling.".red
    end

    def intro4
        puts "\n\n\n\n\n\n\n"
        puts "\nYou're jolted awake by Olivia violently shaking you. \n".red
        sleep(4)
        puts "Mom! There's something else in the house!".red
    end

    def intro
        intro1
        sleep(6)
        intro2
        sleep(6)
        intro3
        sleep(8)
        intro4
        sleep(3)
    end
    
    def help
        puts "Help".bold
        puts "  help\t\t\t\t:show this help menu".green
        puts "List".bold
        puts "  list rooms\t\t\t:lists all rooms in the house".green
        puts "  list family\t\t\t:lists all family members in the house".green
        puts "Control Miranda".bold
        puts "  where am i\t\t\t:tells you which room you are in".green
        puts "  check sanity\t\t\t:tells you your current sanity".green
        puts "  move to ____\t\t\t:attemps to move Miranda to a room".green
        puts "  search\t\t\t:searches the room for anything useful".green
        if Resident.miranda.knowledge == true
            puts "  name reminder\t\t\t:tells you the spirit's name".green
        end
        if Resident.miranda.knowledge && Resident.miranda.book == true
            puts "  banish bael\t\t\t:banishes bael!".green
        end
        puts "Quit".bold
        puts "  quit\t\t\t\t:quit the program".green
    end

    class CommandLineInterfaceError < StandardError
        def message
          "\n  Invalid range of input, type 'help' to see a list of available commands"
        end
    end
end