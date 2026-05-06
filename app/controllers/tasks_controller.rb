class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update destroy ]

  # GET /tasks
  def index
    @tasks = Task.all

    # Permite filtrar por status
    @tasks = @tasks.where(status: params[:status]) if params[:status].present?

    # Permite filtrar por completed
    @tasks = @tasks.where(completed: params[:completed]) if params[:completed].present?

    # Ordena por prioridade e data de vencimento
    @tasks = @tasks.order(priority: :desc, due_date: :asc)

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_content
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :title, :description, :status, :priority, :due_date, :completed ])
    end
end
