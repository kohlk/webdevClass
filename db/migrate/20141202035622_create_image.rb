class CreateImage < ActiveRecord::Migration
    def change
        create_table :image_thing do |t|
            t.string :description
            t.string :due
            t.string :image #image link
        end
    end
end
