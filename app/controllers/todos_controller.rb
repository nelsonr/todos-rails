class TodosController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :update]

  respond_to :html, :json

  def index
    if user_signed_in?
      public_todos = Todo.where("user_id != ? AND private=false", current_user)
      user_todos = current_user.todos

      @todos = public_todos + user_todos
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

  def json
    todos = to_json(get_datatables_todos)

    respond_with todos, :format => 'json'
  end

  private

  def get_datatables_todos
    todos = Todo.limit(params[:iDisplayLength]).offset(params[:iDisplayStart])

    if params[:sSearch].present?
      todos = todos.where('lower(title) LIKE :search', search: "%#{params[:sSearch]}%".downcase)
    end

    todos
  end

  def to_json(todos)
    todos_json = Hash.new
    todos_json[:sEcho] = params[:sEcho].to_i
    todos_json[:iTotalRecords] = todos.count
    todos_json[:iTotalDisplayRecords] = Todo.all.count

    todos_json[:aaData] = todos.map do |todo|
      [todo.title, todo.user.name, todo.created_at, todo_path(todo)]
    end

    todos_json
  end
end
