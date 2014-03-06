class TodosController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :update]

  def index
    @todos_source = todos_json_path
    @todos = Todo.where private: false

    respond_to do |format|
      format.html
      format.json { render json: json_handler }
    end
  end

  def json_handler
    todos = Todo.where(private: false)
    todos_total = todos.count

    todos = todos.limit(params[:iDisplayLength].to_i)
                 .offset(params[:iDisplayStart])

    json_helper(todos, todos_total)
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
