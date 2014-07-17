class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :task_list
      t.string :description
      t.date :due_date
    end
  end
end
