class CreateFileAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :file_attachments do |t|
      t.string :url
      t.references :comment

      t.timestamps
    end
  end
end
