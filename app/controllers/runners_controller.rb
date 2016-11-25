class RunnersController < ApplicationController
  before_action :set_runner, only: [:show, :edit, :update, :destroy]

  def index
    @runners = Runner.order(:entryclass, :surname, :firstname).load
  end

  def import
    if params[:file] == nil
      redirect_to runners_url, :flash => { :error => "No input file selected" }
      return
    end

    ActiveRecord::Base.transaction do
      clear_existing_data
      @added, @skipped = Runner.import(params[:file])
    end
    redirect_to runners_url, notice: "#{@added} runners imported, #{@skipped} runners skipped."
  end

  private
    def clear_existing_data
      TeamMember.delete_all
      Team.delete_all
      Day1Awt.delete_all
      Day2Awt.delete_all
      Runner.delete_all
    end

    def set_runner
      @runner = Runner.find(params[:id])
    end

    def runner_params
      params.require(:runner).permit(:database_id, :surname, :firstname, :gender, :school, :entryclass, :time1, :float_time1, :classifier1, :time2, :float_time2, :total_time, :float_total_time, :day1_score, :day2_score)
    end
end
