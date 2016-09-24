class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
    @day1_awts = Day1Awt.all
    @day1_hash = Hash.new
    @day2_awts = Day2Awt.all
    @day2_hash = Hash.new

    @isp = Team.where(entryclass: 'ISP').order(:sort_score, :day1_score, :name)
    @isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
    @isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
    @isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
    @jrotc = Team.where(entryclass: 'ISV').where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)

    @classes = { 'isp' => @isp, 
                 'isi' => @isi,
                 'isjv' => @isjv,
                 'isv' => @isv,
                 'jrotc' => @jrotc}
    @class_list = ['ISVM', 'ISVF', 'ISJVM', 'ISJVF', 'ISIM', 'ISIF', 'ISPM', 'ISPF']
  end

  def show
    query = "SELECT firstname, surname, runners.entryclass " + 
              "FROM team_members " +
              "JOIN runners " +
                "on runners.id = team_members.runner_id " +
              "LEFT JOIN day1_awts " +
                "on runners.entryclass = day1_awts.entryclass " +
              "LEFT JOIN day2_awts " +
                 "on runners.entryclass = day2_awts.entryclass " +
             "WHERE team_id = " + params[:id] +
             " ORDER BY runners.surname"
    @runners =  ActiveRecord::Base.connection.execute(query)
  end

  def import
    ActiveRecord::Base.transaction do
      clear_existing_teams
      @teams, @members = Team.import(params[:file])
    end
    redirect_to teams_url, notice: "#{@teams} teams imported, with #{@members} team members."

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
