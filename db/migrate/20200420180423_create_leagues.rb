class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.references :sport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
