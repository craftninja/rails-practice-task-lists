class TasksController < ApplicationController

  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new
  end

  def create
    date = Date.new(params[:task]["due_date(1i)"].to_i,
                    params[:task]["due_date(2i)"].to_i,
                    params[:task]["due_date(3i)"].to_i,
    )
    @task = Task.new(:description => params[:task][:description], :due_date => date, :finished => false, :task_list_id => params[:task_list_id])
    if @task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      @task_list = TaskList.find(params[:task_list_id])
      render :new
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.finished = true
    task.save
    redirect_to root_path
  end

end
