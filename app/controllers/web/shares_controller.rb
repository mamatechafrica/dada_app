module Web
  class SharesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :index, :show, :report ]
    before_action :set_share, only: [ :edit, :update, :destroy ]
    before_action :authenticate_user!, only: [ :new, :create, :report ]

    def index
      @content_type = params[:type] || "text"
      @tag = params[:tag]

      @shares = Share.published.public_shares
      @shares = @shares.where(share_type: @content_type) if @content_type.present?
      @shares = @shares.joins(:tags).where(tags: { name: @tag }) if @tag.present?
      @shares = @shares.order(created_at: :desc)

      @tags = Tag.all
    end

    def show
      @share = Share.find_by(id: params[:id])

      if @share.nil?
        redirect_to "/content", alert: "Share not found."
      elsif !@share.published? && (!user_signed_in? || @share.user != current_user)
        redirect_to "/content", alert: "This story is not available."
      elsif @share.private? && (!user_signed_in? || @share.user != current_user)
        redirect_to new_user_session_path, alert: "Please log in to view this content."
      end
    end

    def new
      @share = current_user.shares.build
    end

    def create
      @share = current_user.shares.build(share_params)
      @share.status = :published
      @share.published_at = Time.current if @share.visibility_public?

      if @share.save
        redirect_to web_profile_path, notice: "Share created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      unless @share.user == current_user
        redirect_to "/content", alert: "Not authorized."
      end
    end

    def update
      unless @share.user == current_user
        redirect_to "/content", alert: "Not authorized."
        return
      end

      if @share.update(share_params)
        @share.update(published_at: Time.current) if @share.published? && @share.published_at.nil?
        redirect_to web_profile_path, notice: "Share updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      unless @share.user == current_user || current_user.admin?
        redirect_to "/content", alert: "Not authorized."
        return
      end

      @share.destroy
      redirect_to web_profile_path, notice: "Share deleted."
    end

    def report
      @share = Share.find(params[:id])

      unless current_user
        redirect_to new_user_session_path, alert: "Please log in to report."
        return
      end

      existing_report = Report.find_by(user: current_user, share: @share)

      if existing_report
        redirect_to "/content/#{@share.id}", alert: "You already reported this."
        return
      end

      Report.create!(user: current_user, share: @share, reason: params[:reason])
      @share.flag_if_reported!

      redirect_to "/content/#{@share.id}", notice: "Report submitted. Thank you!"
    end

    private

    def set_share
      @share = Share.find_by(id: params[:id])
    end

    def share_params
      params.require(:share).permit(
        :share_type,
        :visibility,
        :anonymous,
        :title,
        :content,
        :image_urls,
        :video_url,
        tag_ids: []
      )
    end
  end
end
