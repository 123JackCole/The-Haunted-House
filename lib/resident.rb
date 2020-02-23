class Resident < ActiveRecord::Base
    has_many :spooks
    has_many :ghosts, through: :spooks
    belongs_to :locations

    def self.list_family
        self.all.each_with_index do |resident, index|
            puts (index + 1).to_s.bold + ".\t#{resident.name}".red
        end
    end

    def self.where_am_i
        location = self.miranda_location.name
        puts "\nYou are currently in the #{location}".red
    end

    def self.sanity
        sanity = self.miranda.sanity
        puts "\nYour sanity is currently #{sanity}".red
        if sanity > 10 
            puts "\nYou're in a state of bliss. Have you done this before?".red
        elsif sanity < 10 && sanity > 3
            puts "\nYou're feeling great!".red
        elsif sanity == 3 
            puts "\nYou're calm and collected.".red
        elsif sanity == 2 
            puts "\nYour heart is pounding, you should hurry.".red
        elsif sanity == 1
            puts "\nYour vision is blurry and head is pounding.".red
            puts "Voices are whispering to you in a strange language.".red
        end
    end

    # helper method that returns the resident instance for miranda
    def self.miranda
        self.find_by(name: "Miranda")
    end

    # helper method that returns the location instance for miranda
    def self.miranda_location
        Location.find(self.miranda.location_id)
    end

    def self.move_all_residents
        self.all.map do |resident|
            if resident.name != "Miranda"
                resident.update(location_id: rand(Location.all[0].id..Location.all[4].id))
            end
        end        
    end

    def self.check_miranda_current_room
        if self.miranda_location.residents_no_miranda.count > 0
            self.miranda_location.residents_no_miranda.map do |resident|
                sleep(3)
                puts "\n#{resident.name} walks into the room. You try to approach each".red
                puts "other but a mysterious force doesn't let you touch. However, a".red
                puts "friendly face is a much needed respite during these trying times.".red
                puts "It appears that you need to do this alone.".red
                sleep(2)
                unless self.miranda_location.ghosts.count > 0
                    self.increment_counter(:sanity, self.miranda.id)
                    self.increment_counter(:sanity, resident.id)
                    puts "\nYou and #{resident.name} gain 1 sanity.".red
                end
            end
        end
    end

    def self.move_to(room)
        room = room.titleize
        if Location.find(self.miranda_location.id).name == room
            puts "\nYou're already in the #{room}. You don't have time for this!".red

        elsif Location.all.any? {|location| room == location.name} && self.miranda_location.name != room

            if room == "Attic" && Location.find_by(name: room).unlocked == false
                puts "\nYou need to find the entrance to the attic first!".red
                puts "Maybe try searching rooms for clues?".red
                return
            end

            if room == "Attic" && Location.find_by(name: room).unlocked == true
                puts "\nYou push open the hatch and a cloud of dust swirls past you.".red
                puts "All hairs on your body stand on end in unison and you pulse".red
                puts "skyrockets. After moments of silence you decide the coast is clear".red
                puts "and jump into the dark room.".red
                sleep(3)
                puts "\nYou're now in the #{room}".red
                puts "However, on your way you heard other footsteps.".red

                Location.find_by(name: room).move_miranda
                Location.update_locations
                Spook.interaction
                return
            end

            if room == "Basement" && Location.find_by(name: room).unlocked == false
                puts "\nAlthough the lock is rusty and old, it is still strong.".red
                puts "You need to find the key before you can open the door.".red
                puts "Maybe try searching rooms for clues?".red
                return
            end

            if room == "Basement" && Location.find_by(name: room).unlocked == true
                puts "\nThe key fits! Silence is broken by the tumbling of the deadbolt".red
                puts "and the door creaking open. You take a deep breath and descend".red
                puts "into the darkness.".red
                sleep(3)
                puts "\nYou're now in the #{room}".red
                puts "However, on your way you heard other footsteps.".red

                Location.find_by(name: room).move_miranda
                Location.update_locations
                Spook.interaction
                return
            end

            Location.find_by(name: room).move_miranda
            Location.update_locations

            puts "\nYou're now in the #{room}".red
            puts "However, on your way you heard other footsteps.".red

            Spook.interaction

        else
            puts "\nThat isn't a valid room! You don't have time for this!".red
            puts "Type 'help' to see a list of available commands"
        end
    end

    def self.search
        room = self.miranda_location.name
        case room
        when "Master Bedroom"
            puts "\nA king sized bed with fresh linnens. A wooden dresser, a bedside ".red
            print "table, a lamp, A STRANGE WOMA".red
            sleep(3)
            print " - nevermind thats a mirror.".red
            sleep(3)
            puts "\nThere's nothing out of the ordinary here.".red
        when "Olivia's Room"
            if Location.find_by(name: "Attic").unlocked == false
                Location.find_by(name: "Attic").update(unlocked: true)
            end
            puts "\nAfter meticulously examining the ceiling you notice an uneven crease".red
            puts "tucked under the layers of paint. You grab one of Olivia's dolls".red
            puts "and use it to peel it away layer by layer. An old hatch to the".red
            sleep(3)
            puts "attic is revealed.".red
            sleep(2)
            puts "\nYou gain 1 sanity.".red
            puts "\nYou can now move to the attic.".red
            sleep(2)
            puts "\nWhile working you heard footsteps.".red
            sleep(2)

            self.increment_counter(:sanity, self.miranda.id)
            Location.update_locations
            Spook.interaction

        when "Bathroom"
            puts "\nYou pull back the shower curtain in one swift motion.".red
            puts "There's nothing. You exhale and collect your thoughts.".red
            sleep(2)
            puts "There's nothing out of the ordinary here.".red
        when "Kitchen"
            puts "\nPots and pans bang, dishes and glasses crash. You find".red
            puts "nothing of note, but worry you've made too much of a ruccus.".red
            sleep(2)
            puts "There's nothing out of the ordinary here.".red
        when "Living Room"
            if Location.find_by(name: "Basement").unlocked == false
                Location.find_by(name: "Basement").update(unlocked: true)
            end
            puts "\nYou frantically search the room for anything that could be helpful".red
            puts "After tossing the cushions off of the couch you find an old and rusty".red
            puts "key.".red
            sleep(2)
            puts "\nYou gain 1 sanity.".red
            puts "\nYou can now move to the basement.".red
            sleep(2)
            puts "\nWhile working you heard footsteps.".red
            sleep(2)

            self.increment_counter(:sanity, self.miranda.id)
            Location.update_locations
            Spook.interaction

        when "Attic"
            if self.miranda.knowledge == false
                self.miranda.update(knowledge: true)
                self.increment_counter(:sanity, self.miranda.id)
            end

            puts "\nThe air is thick with dust and decay. As you look around the attic".red
            puts "you stumble upon a group of strange archaic symbols carved.".red
            puts "into the floor. As you look closer you notice a word is faintly".red
            puts "glowing with a redish hue.".red
            sleep(3)
            puts "\nBael".bold.red
            sleep(2)
            puts "\nNow you know it's name. You're getting closer.".red
        when "Basement"
            if self.miranda.book == false
                self.miranda.update(book: true)
                self.increment_counter(:sanity, self.miranda.id)
            end

            puts "\nAfter making your way down the creaky wooden stairs".red
            puts "you see a black fog spewing from the brick wall on the".red
            puts "other side of the room.".red
            sleep(3)
            puts "\nYou peel away some loose bricks and pull out a dusty".red
            puts "book. As you wipe your hand across the cover you feel".red
            puts "it pulse as if it's alive. You open it and examine the".red
            puts "pages. The text isn't in english yet you have no problem".red
            puts "reading it.".red
            sleep(7)
            puts "\nYou can now banish the spirit if you know its name.".red
        end
    end

    def dead
        puts "\nYou collapse on the floor, still awake but unable to move. What once was".red
        puts "your family stands above you motionless. You hear a cackling laughter as".red
        puts "your vision fades.".red
        sleep(8)
        puts "\nYou lose!".red
        sleep(1)
        exit
    end

end