class RenameTitleColumnToReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :title, :rev_title
  end
end
