class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :update, :destroy]

  # GET /notices
  def index
    @notices = Notice.all
    render json: @notices
  end

  # GET /notices/1
  def show
    render json: @notice
  end

  # POST /notices
  def create
    @notice = Notice.new(notice_params)

    if @notice.save
      render json: @notice, status: :created, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # Patach/PUT /notices/1
  def update
    if @nottice.update(notice_params)
      render json: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notices/1
  def destroy
    @notice.destroy
  end

  private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:title, :content)
  end
end
