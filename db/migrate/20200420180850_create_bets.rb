class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.references :event, null: false, foreign_key: true
      t.string :bet_type
      t.string :position
      t.integer :odds
      t.decimal :line
      t.boolean :active

      t.timestamps
    end
  end
end
