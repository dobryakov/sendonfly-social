class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.belongs_to :profile, index: true
      t.string :type
      t.string :facebook_id

      t.timestamps null: false
    end
    add_foreign_key :messages, :profiles
  end
end
