class TodosController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new]

  def index
    @todos = Todo.where private: false
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
end
