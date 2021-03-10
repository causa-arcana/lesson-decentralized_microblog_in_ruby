class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.timestamps
      t.string :first_name
      t.string :last_name
      t.string :description
    end
  end
end
