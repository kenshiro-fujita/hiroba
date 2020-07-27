class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :publisher
      t.date :release_date

      t.timestamps

      t.index [:isbn], unique: true
    end
  end
end
