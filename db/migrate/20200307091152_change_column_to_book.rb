class ChangeColumnToBook < ActiveRecord::Migration[5.2]
  def change
     change_column_null :books, :isbn, false
  end
end
