class Web::SuggestionsController < ApplicationController
  before_action :authenticate_user!

  def create
    title = params[:title]
    description = params[:description]
    circle_slug = params[:circle_slug]

    if circle_slug.present?
      @circle = Circle.find_by_slug(circle_slug) || Circle.find_by(id: circle_slug)
      @suggestion = @circle.suggestions.build(title: title, description: description)
      redirect_path = @circle ? circle_path(@circle) : circles_path
    else
      @suggestion = Suggestion.new(title: title, description: description)
      redirect_path = circles_path
    end

    @suggestion.user = current_user

    if @suggestion.save
      redirect_to redirect_path, notice: "Your suggestion has been submitted for review!"
    else
      redirect_to redirect_path, alert: "Could not submit suggestion. Please try again."
    end
  end
end
