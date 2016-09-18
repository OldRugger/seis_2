class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def show
  end

  def import
    clear_existing_teams
    teams, members = Team.import(params[:file])
    redirect_to teams_url, notice: "#{teams} teams imported, with #{members} team members."

  end

  private
    def clear_existing_teams
      TeamMember.delete_all
      Team.delete_all
    end

    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:team_name, :category, :JROTC_branch, :day1_score, :day2_score, :total_score, :sort_score, :school)
    end
end
