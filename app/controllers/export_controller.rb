class ExportController < ApplicationController
  before_filter :authenticate_user!

  def export
    @user_todos = current_user.todos
    @public_todos = Todo.where("user_id != ? AND private=false", current_user)

    # Setup Axlsx (cuz it's cool)
    p = Axlsx::Package.new
    wb = p.workbook

    # Add some styles
    wb.styles do |s|
      heading = s.add_style bg_color: "33", fg_color: "FF", sz: 13, alignment: {horizontal: :center}
      todo_heading = s.add_style bg_color: "66", fg_color: "FF", sz: 12

      # Add the data
      wb.add_worksheet(name: "Todos") do |sheet|
        list_todos(@user_todos, heading, sheet, todo_heading)
        list_todos(@public_todos, heading, sheet, todo_heading)
      end
    end

    # Download the file
    p.serialize('tmp/todos.xlsx')
    send_file('tmp/todos.xlsx')
  end

  private

  def list_todos(todos_list, heading, sheet, todo_heading)
    todos_list.each do |todo|
      # Todos Title
      sheet.add_row ["Title", "User", "Private"], style: heading
      sheet.add_row [todo.title, todo.user.name, status?(todo.private)]

      spacer(sheet, 1) # add 1 empty row

      # Tasks
      sheet.add_row ["Content", "Finished?"], style: todo_heading
      todo.tasks.each do |task|
        sheet.add_row [task.content, status?(task.finished)]
      end

      spacer(sheet)
    end
  end

  def spacer(sheet, size=2)
    size.times do
      sheet.add_row [""] # Empty row
    end
  end

  def status?(status)
    status ? "Yes" : "No"
  end
end
