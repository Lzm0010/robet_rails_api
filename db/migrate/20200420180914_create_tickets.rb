class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bet, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
