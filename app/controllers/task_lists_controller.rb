class TaskListsController < ApplicationController

  def index
    @task_lists = TaskList.where(user_id: current_user.id).order(:name)
  end

end