class TasksController < ApplicationController
  def index
  	@task = Task.new
  	@tasks = Task.all
  end

  def create
  	# render :text => params.inspect
  	Task.create params[:task]
  	redirect_to :back, :notice => 'Task was created successfully'
  end

  def edit
  	@task = Task.find params[:id]
  end

  def update
  	task = Task.find params[:id].to_i

  	if task.update_attributes params[:task]
  		redirect_to tasks_path, :notice => 'Your task has been successfully updated.'
  	else	
  		redirect_to :back, :notice => 'There was an error updating task.'
  	end
  end

  def destroy
     Task.destroy params[:id]
     redirect_to :back, :notice => 'Task has been deleted successfully.' 
  end
end
