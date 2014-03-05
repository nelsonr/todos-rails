class TodosController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new]

  def index
    @todos = Todo.all
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
      redirect_to root_url
    end
  end
end
