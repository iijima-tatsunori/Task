class TasksController < ApplicationController
  
  before_action :set_user
  before_action :logged_in_user
  before_action :correct_user, only: [:new]
  before_action :correct_user_edit, only: [:edit]

  
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
    @tasks = @user.tasks.order(id: :desc)
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
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def correct_user_edit
    unless @user == current_user
      redirect_to user_tasks_url current_user
      flash[:danger] = "権限がありません。"
    end
  end
 
  
end
