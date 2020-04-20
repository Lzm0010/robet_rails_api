class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :league, null: false, foreign_key: true
      t.integer :home_team_id
      t.integer :away_team_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :home_score
      t.integer :away_score
      t.string :status

      t.timestamps
    end
  end
end
