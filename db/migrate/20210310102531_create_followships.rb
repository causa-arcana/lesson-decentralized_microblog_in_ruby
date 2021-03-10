class CreateFollowships < ActiveRecord::Migration[6.1]
  def change
    create_table :followships do |t|
      t.timestamps
      t.references :subject_profile,
                   null: false,
                   foreign_key: { to_table: :profiles }
      t.references :object_profile,
                   null: false,
                   foreign_key: { to_table: :profiles }

      t.index %i[subject_profile_id object_profile_id], unique: true
    end
  end
end
