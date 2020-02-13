class Ghost < ActiveRecord::Base
    has_many :spooks
    has_many :residents, through: :spooks
    belongs_to :locations

    def bael
        Ghost.find_by(name: "Bael")
    end

    def name_reminder
        puts "\n#{self.name}".red
    end

    def self.move_all_ghosts
        Ghost.all.map do |ghost|
            ghost.update(location_id: rand(Location.all[0].id..Location.all[6].id))
        end
    end

    def self.ghosts_attack
        Ghost.all.map do |ghost|
            if Resident.residents_in_room(ghost.location_id)
                Resident.residents_in_room(ghost.location_id).map do |resident|
                    if resident.name == "Miranda"
                        if ghost.name == "Bael"
                            sleep(3)
                            puts "\nA grotesque figure is standing in a corner of the room. Part".red
                            puts "man, part frog, part, cat. Yet always changing, always shifting.".red
                            puts "Petrified with fear, you can only watch as it approaches. ".red
                            puts "Your vision fades and you lose consciousness.".red
                            sleep (8)
                            puts "\nYou wake up with a pounding head. You should probably".red
                            puts "check your sanity.".red
                        else
                            sleep(3)
                            puts "\nIt's #{ghost.name}! But something is off. Their eyes".red
                            puts "are bloodshot and they look oddly pale. Before you have time to".red
                            puts "to react #{ghost.name} lets out a growl and lunges at you".red
                            sleep (8)
                            puts "\nYou wake up with a pounding head. You should probably".red
                            puts "check your sanity.".red
                        end
                    end
                    ghost.power.times do
                        Resident.decrement_counter(:sanity, resident.id)
                    end
                    Spook.create(ghost_id: ghost.id, resident_id: resident.id)
                end

                if Resident.residents_in_room(ghost.location_id).any? { |resident| resident.sanity < 1}
                    Resident.where("sanity < ?", 1).map do |resident|
                        if resident.name == "Miranda"
                            resident.destroy
                            Resident.dead
                        else
                            Ghost.create(name: resident.name, location_id: resident.location_id)
                            resident.destroy
                            sleep(3)
                            puts "\nYou hear a horrible screech that sounds like it".red
                            puts "came from #{resident.name}, followed by a loud thud.".red
                            puts "After several seconds of silence the house rumbles.".red
                            puts "#{resident.name} gleefully calls to you, but".red 
                            puts "something about their voice sounds off.".red
                        end
                    end
                    Ghost.increment_counter(:power, Ghost.find_by(name: "Bael").id)
                end
            end
        end
    end

    def banish
        puts "\nAs you chant the strange words the entire house begins to".red
        puts "shake. What begins as a soft murmur transforms to an ear piercing".red
        puts "shriek. Bael appears before you. His body rapidly morphs from".red
        puts "the shape of a cat, a toad, a man, and various mixes of each.".red
        puts "A ghostly hand reaches out from the book, grabs Bael, and".red
        puts "pulls him into the pages. The book crumbles to ashes and a".red
        puts "silence falls over the house.".red
        sleep(10)
        puts "\nLife continues. You win!".cyan
    end

end