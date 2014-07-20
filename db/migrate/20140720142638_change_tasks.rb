class ChangeTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.boolean :finished, :null => false
    end
  end
end
