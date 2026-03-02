class Admin::ModerationController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  layout "admin"

  def index
    @flagged_shares = Share.flagged.order(created_at: :desc)
    @pending_reports = Report.pending.order(created_at: :desc).includes(:share, :user)
    @all_shares = Share.order(created_at: :desc).limit(50)
  end

  def approve
    share = Share.find(params[:id])
    share.update(status: :published)
    redirect_to admin_moderation_path, notice: "Story approved!"
  end

  def unpublish
    share = Share.find(params[:id])
    share.update(status: :draft)
    redirect_to admin_moderation_path, notice: "Story unpublished!"
  end

  def destroy
    share = Share.find(params[:id])
    share.destroy
    redirect_to admin_moderation_path, notice: "Story deleted!"
  end

  def resolve_report
    report = Report.find(params[:id])
    report.update(status: :resolved)
    redirect_to admin_moderation_path, notice: "Report resolved!"
  end

  private

  def authorize_admin!
    redirect_to "/" unless current_user.admin?
  end
end
