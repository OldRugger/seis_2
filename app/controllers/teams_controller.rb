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

    @classes = { 'isv'   => @isv,
                 'isjv'  => @isjv,
                 'isi'   => @isi,
                 'isp'   => @isp, 
                 'jrotc' => @jrotc }
                 
    @class_list = ['ISVM', 'ISVF', 'ISJVM', 'ISJVF', 'ISIM', 'ISIF', 'ISPM', 'ISPF']
    
    isday1 = TeamMember.joins(:runner)
      .select("team_members.team_id,runners.id as runner_id,
              runners.day1_score as day1_score,
              runners.surname")
      .order("team_members.team_id, runners.day1_score")
      .all
    team_id = 0
    results_str = nil
    isday1.each do |d| 
      if team_id != d.team_id
        if team_id != 0
          puts "new team #{d.team_id}"
          @day1_hash[team_id] = results_str if team_id !=0
        end
        team_id = d.team_id
        results_str = nil
      end
      if d.day1_score 
        if results_str != nil
          results_str.concat(", #{d.surname} (#{d.day1_score.round(3)})")
        else 
          results_str = "#{d.surname} (#{d.day1_score.round(3)})"
        end
      end
    end
    @day1_hash[team_id] = results_str

    isday2 = TeamMember.joins(:runner)
      .select("team_members.team_id,runners.id as runner_id,
              runners.day2_score as day2_score,
              runners.surname")
      .order("team_members.team_id, runners.day2_score")
      .all
    team_id = 0
    results_str = nil
    isday2.each do |d| 
      if team_id != d.team_id
        if team_id != 0
          puts "new team #{d.team_id}"
          @day2_hash[team_id] = results_str if team_id !=0
        end
        team_id = d.team_id
        results_str = nil
      end
      if d.day2_score 
        if results_str != nil
          results_str.concat(", #{d.surname} (#{d.day2_score.round(3)})")
        else 
          results_str = "#{d.surname} (#{d.day2_score.round(3)})"
        end
      end
    end
    @day2_hash[team_id] = results_str
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
