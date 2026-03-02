class Admin::SuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @suggestions = Suggestion.pending.order(created_at: :desc)
  end

  def approve
    @suggestion = Suggestion.find(params[:id])

    circle = @suggestion.circle
    if circle.nil?
      circle = Circle.create!(
        name: @suggestion.title,
        description: @suggestion.description.presence || "Circle for #{@suggestion.title}"
      )
    end

    @suggestion.approved!

    Topic.create!(
      title: @suggestion.title,
      content: @suggestion.description,
      circle: circle,
      user: @suggestion.user
    )

    redirect_to circles_path, notice: "Approved! Circle '#{circle.name}' created with the topic."
  end

  def reject
    @suggestion = Suggestion.find(params[:id])
    @suggestion.rejected!
    redirect_to admin_suggestions_path, notice: "Suggestion rejected."
  end

  def create_circle
    @suggestion = Suggestion.find(params[:id])
    circle_name = params[:circle_name]

    if circle_name.blank?
      redirect_to admin_suggestions_path, alert: "Please provide a circle name."
      return
    end

    circle = Circle.create!(name: circle_name, description: "Circle for #{circle_name}")

    @suggestion.approved!

    Topic.create!(
      title: @suggestion.title,
      content: @suggestion.description,
      circle: circle,
      user: @suggestion.user
    )

    redirect_to circles_path, notice: "Circle '#{circle_name}' created and topic added!"
  end

  private

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
