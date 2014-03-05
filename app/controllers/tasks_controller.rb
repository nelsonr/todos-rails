class TasksController < ApplicationController
  def create
    todo = Todo.find(params[:todo_id])
    @task = todo.tasks.create(params[:task])

    if @task.save
      flash[:success] = 'New task added!'
      redirect_to @task.todo
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to @task.todo
  end
end
