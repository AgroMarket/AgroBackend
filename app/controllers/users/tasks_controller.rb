class Users::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_user
  include Exceptable

  # GET /tasks
  # GET /tasks.json
  def index
    #if current_user.has_role? :transport
    @tasks = Task.all
    build do
      message "Список всех доставок"
      view 'user/tasks/index'
    end
    #end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # POST /tasks
  # POST /tasks.json
  # def create
  #  @task = Task.new(task_params)

  #  if @task.save
  #    render :show, status: :created, location: @task
  #  else
  #    render json: @task.errors, status: :unprocessable_entity
  #  end
  # end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if params[:task][:status] == 1
      @task.ask.status = 1
      @task.ask.save
      if @task.update(task_params)
        build do 
          message "Статус изменён"
          view 'user/tasks/show'
        end
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:ask_id, :user_id, :status)
  end
end
  