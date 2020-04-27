class AddOutcomeToBetsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :bets, :outcome, :string
  end
end
