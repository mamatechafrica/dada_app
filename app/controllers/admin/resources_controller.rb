class Admin::ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  layout "admin"

  def index
    @resources = Resource.order(created_at: :desc)
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.published_at = Time.current if params[:publish].present?

    if @resource.save
      redirect_to admin_resources_path, notice: "Resource created!"
    else
      render :new
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    @resource.published_at = Time.current if params[:publish].present? && @resource.published_at.nil?

    if @resource.update(resource_params)
      redirect_to admin_resources_path, notice: "Resource updated!"
    else
      render :edit
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to admin_resources_path, notice: "Resource deleted!"
  end

  private

  def authorize_admin!
    redirect_to "/" unless current_user.admin?
  end

  def resource_params
    params.require(:resource).permit(
      :title,
      :content,
      :resource_type,
      :access_level,
      :featured,
      :image_url,
      :video_url,
      tag_ids: []
    )
  end
end
