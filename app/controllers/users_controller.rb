class UsersController < ApplicationController
  respond_to :html, :json_handler

  def profile
    if user_signed_in?
      render 'users/profile'
    else
      redirect_to root_path
    end
  end

  def todos
    @todos = current_user.todos.limit(10)
    @todos_source = user_todos_path

    respond_to do |format|
      format.html
      format.json { render json: json_handler }
    end
  end

  def json_handler
    todos = current_user.todos
    todos_total = todos.count

    todos = todos.limit(params[:iDisplayLength].to_i)
                 .offset(params[:iDisplayStart])

    json_helper(todos, todos_total)
  end

end

