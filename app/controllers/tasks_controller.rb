class TasksController < ApplicationController
  
  before_action :set_user
  
  def new
    @task = Task.new
  end
  
  def create
     @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def index 
    @tasks = @user.tasks
  end
  
  def show
    @task = @user.tasks.find(params[:id])
  end
  
  def edit
   @task = @user.tasks.find(params[:id])
  end
  
  def update
     @task = @user.tasks.find(params[:id])
     
    if @task.update_attributes(task_params)
      flash[:success] = "タスク情報を更新しました。"
      redirect_to user_task_url @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.tasks.find(params[:id]).destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def task_params
    params.require(:task).permit(:name, :discription, :user_id)
  end
  
end
