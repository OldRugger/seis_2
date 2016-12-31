class Teams2Controller < ApplicationController
  def index
    @class_list = CLASS_LIST

    @awt = get_awt_with_runners

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

    @runners = TeamMember.joins(:runner)
      .select("team_members.team_id, runners.id as runner_id,
              runners.firstname   as firstname,
              runners.surname     as surname,
              runners.time1       as time1,
              runners.time2       as time2,
              runners.float_time1 as float_time1,
              runners.float_time2 as float_time2,
              runners.classifier1 as classifier1,
              runners.classifier2 as classifier2,
              runners.day1_score  as day1_score,
              runners.day2_score  as day2_score,
              runners.entryclass  as entryclass ")
      .order("team_members.team_id, runners.surname").load

  end
end
