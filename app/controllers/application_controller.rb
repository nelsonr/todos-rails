class ApplicationController < ActionController::Base
  protect_from_forgery

  def json_helper(todos, total_todos)
    if params[:sSearch].present?
      todos = todos_search(todos)
    end

    todos = todos.joins(:user).order("#{sort_column} #{sort_order}")

    render_json(todos, total_todos)
  end

  def todos_search(todos)
    todos.where('LOWER(todos.title) LIKE :search OR LOWER(users.name) LIKE :search', search: "%#{params[:sSearch]}%".downcase)
  end

  def render_json(todos, total_todos)
    todos_json = {}
    todos_json[:sEcho] = params[:sEcho].to_i
    todos_json[:iTotalRecords] = todos.count
    todos_json[:iTotalDisplayRecords] = total_todos

    todos_json[:aaData] = todos.map do |todo|
      [todo.title, todo.user.name, todo.created_at.strftime("%d %b %Y"), todo_path(todo)]
    end

    todos_json
  end

  def sort_column
    columns = %w[todos.title users.name todos.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_order
    params[:sSortDir_0] == "desc" ? "DESC" : "ASC"
  end
end
