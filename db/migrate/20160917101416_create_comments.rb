class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.string :file
      t.references :task

      t.timestamps
    end
  end
end
