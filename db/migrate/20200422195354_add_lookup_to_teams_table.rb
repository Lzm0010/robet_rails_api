class AddLookupToTeamsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :lookup, :string
  end
end
