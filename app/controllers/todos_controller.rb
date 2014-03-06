class TodosController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :update]

  def index
    if user_signed_in?
      user_todos = current_user.todos
      public_todos = Todo.where("user_id != ? AND private=false", current_user)
      @todos = user_todos + public_todos
    else
      @todos = Todo.where private: false
    end
  end

  def new
    @todo = Todo.new
    @todo.tasks.build
  end

  def show
    @todo = Todo.find(params[:id])

    if user_signed_in?
      @task = Task.new
    end

    if @todo.user == current_user
      @todo_private_toggle_label = @todo.private ? 'Set public' : 'Set private'
    end

    if @todo.private? and @todo.user != current_user
      redirect_to root_path
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = current_user.todos.build(params[:todo])

    if @todo.save
      flash[:success] = "Todo created!"
      redirect_to @todo
    else
      render 'todos/new'
    end
  end

  def update
    todo = Todo.find(params[:id])
    todo.private = !todo.private
    todo.save

    redirect_to todo
  end

  def destroy
    todo = Todo.find(params[:id])

    if todo.user == current_user
      todo.destroy
    end

    redirect_to root_path
  end
end
