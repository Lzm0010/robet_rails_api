class AddDbLookupAndPyLookUpToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :db_lookup, :string
    add_column :teams, :py_lookup, :string
    remove_column :teams, :lookup
  end
end
