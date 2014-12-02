class AddIdToTable < ActiveRecord::Migration
    def change
        change_table :image_thing do |t|
            t.integer :user_id
        end
    end
end
