class ChangeTaskList < ActiveRecord::Migration
  def change
    change_table :task_lists do |t|
      t.belongs_to :user
    end
  end
end
