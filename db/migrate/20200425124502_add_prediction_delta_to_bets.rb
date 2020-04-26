class AddPredictionDeltaToBets < ActiveRecord::Migration[6.0]
  def change
    add_column :bets, :prediction_delta, :decimal
  end
end
