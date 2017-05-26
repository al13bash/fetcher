class CreateParsings < ActiveRecord::Migration[5.1]
  def change
    create_table :parsings do |t|
      t.integer :status, default: 0, null: false
      t.string :url
      t.string :success_callback_url
      t.string :failure_callback_url

      t.timestamps
    end
  end
end
