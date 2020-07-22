class AddApiIdToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :api_id, :string
  end
end
