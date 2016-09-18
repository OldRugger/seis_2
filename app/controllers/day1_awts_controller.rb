class Day1AwtsController < ApplicationController
  before_action :set_day1_awt, only: [:show, :edit, :update, :destroy]

  # GET /day1_awts
  # GET /day1_awts.json
  def index
    @day1_awts = Day1Awt.all
  end

  # GET /day1_awts/1
  # GET /day1_awts/1.json
  def show
  end

  # GET /day1_awts/new
  def new
    @day1_awt = Day1Awt.new
  end

  # GET /day1_awts/1/edit
  def edit
  end

  # POST /day1_awts
  # POST /day1_awts.json
  def create
    @day1_awt = Day1Awt.new(day1_awt_params)

    respond_to do |format|
      if @day1_awt.save
        format.html { redirect_to @day1_awt, notice: 'Day1 awt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day1_awt }
      else
        format.html { render action: 'new' }
        format.json { render json: @day1_awt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /day1_awts/1
  # PATCH/PUT /day1_awts/1.json
  def update
    respond_to do |format|
      if @day1_awt.update(day1_awt_params)
        format.html { redirect_to @day1_awt, notice: 'Day1 awt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @day1_awt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day1_awts/1
  # DELETE /day1_awts/1.json
  def destroy
    @day1_awt.destroy
    respond_to do |format|
      format.html { redirect_to day1_awts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day1_awt
      @day1_awt = Day1Awt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day1_awt_params
      params.require(:day1_awt).permit(:runner1_float_time, :runner1_time, :runner1_id, :runner2_float_time, :runner2_time, :runner2_id, :runner3_float_time, :runner3_time, :runner3_id, :awt_float_time, :awt_time, :cat_float_time, :cat_time)
    end
end
