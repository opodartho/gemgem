class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :weight
      t.belongs_to :thing
      t.belongs_to :user

      t.timestamps
    end
  end
end
