class CreatePayloads < ActiveRecord::Migration[5.1]
  def change
    create_table :payloads do |t|
      t.integer :kind, null: false
      t.string :content
      t.belongs_to :parsing, foreign_key: true, index: true

      t.timestamps
    end
  end
end
