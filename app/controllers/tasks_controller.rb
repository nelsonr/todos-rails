class TasksController < ApplicationController
  def create
    todo = Todo.find(params[:todo_id])
    @task = todo.tasks.create(params[:task])

    if @task.save
      flash[:success] = 'New task added!'
      redirect_to @task.todo
    end
  end

  def update
    @todo = Todo.find(params[:todo_id])
    @task = Task.find(params[:id])
    @task.finished = !@task.finished

    @task.save

    redirect_to @todo
  end

  def destroy
    task = Task.find(params[:id])

    if task.todo.user == current_user
      task.destroy
    end

    redirect_to task.todo
  end
end
