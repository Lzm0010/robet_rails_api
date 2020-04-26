class CreatePredictions < ActiveRecord::Migration[6.0]
  def change
    create_table :predictions do |t|
      t.references :event, null: false, foreign_key: true
      t.decimal :home_score
      t.decimal :away_score
      t.decimal :home_confidence
      t.decimal :away_confidence

      t.timestamps
    end
  end
end
