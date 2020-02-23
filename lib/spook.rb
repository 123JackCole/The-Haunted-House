class Spook <ActiveRecord::Base
    belongs_to :ghosts
    belongs_to :residents

    def self.interaction
        Resident.check_miranda_current_room
        Ghost.ghosts_attack
    end

end