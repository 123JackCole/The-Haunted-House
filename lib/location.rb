class Location < ActiveRecord::Base
    has_many :ghosts
    has_many :residents

    def self.list_rooms
        self.all.each_with_index do |location, index| 
            puts (index + 1).to_s.bold + ".\t#{location.name}".red
        end
    end

    def residents
        Resident.all.where(location_id: self.id)
    end

    def residents_no_miranda
        self.residents.where("name != 'Miranda'")
    end

    def ghosts
        Ghost.all.where(location_id: self.id)
    end

    def move_miranda
        Resident.miranda.update(location_id: self.id)
    end

    def self.update_locations
        Resident.move_all_residents
        Ghost.move_all_ghosts
    end

end