class Web::ResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @content_type = params[:type] || "article"
    @resources = Resource.order(created_at: :desc)
  end

  def show
    @resource = Resource.find(params[:id])
  end
end
