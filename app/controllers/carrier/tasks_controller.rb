class Carrier::TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :update]
  include Paginable
  include Exceptable

  # GET /tasks
  # GET /tasks.json
  def index
    build do
      message 'Список задач перевозчика'
      path carrier_tasks_path
      @tasks = paginate current_user.tasks.order('created_at DESC')
      view 'carrier/tasks/index'
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    build do
      message 'Задача детально'
      view 'carrier/tasks/show'
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    build do
      @task.update!(task_params)
      message 'Задача детально'
      view 'carrier/tasks/show'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:status)
    end
end
