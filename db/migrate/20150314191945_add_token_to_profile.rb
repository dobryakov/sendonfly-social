class AddTokenToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :token, :string
  end
end
