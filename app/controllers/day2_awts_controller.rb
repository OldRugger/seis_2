class Day2AwtsController < ApplicationController
  before_action :set_day2_awt, only: [:show, :edit, :update, :destroy]

  # GET /day2_awts
  # GET /day2_awts.json
  def index
    @day2_awts = Day2Awt.all
  end

  # GET /day2_awts/1
  # GET /day2_awts/1.json
  def show
  end

  # GET /day2_awts/new
  def new
    @day2_awt = Day2Awt.new
  end

  # GET /day2_awts/1/edit
  def edit
  end

  # POST /day2_awts
  # POST /day2_awts.json
  def create
    @day2_awt = Day2Awt.new(day2_awt_params)

    respond_to do |format|
      if @day2_awt.save
        format.html { redirect_to @day2_awt, notice: 'Day2 awt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @day2_awt }
      else
        format.html { render action: 'new' }
        format.json { render json: @day2_awt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /day2_awts/1
  # PATCH/PUT /day2_awts/1.json
  def update
    respond_to do |format|
      if @day2_awt.update(day2_awt_params)
        format.html { redirect_to @day2_awt, notice: 'Day2 awt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @day2_awt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day2_awts/1
  # DELETE /day2_awts/1.json
  def destroy
    @day2_awt.destroy
    respond_to do |format|
      format.html { redirect_to day2_awts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day2_awt
      @day2_awt = Day2Awt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day2_awt_params
      params.require(:day2_awt).permit(:runner1_float_time, :runner1_time, :runner1_id, :runner2_float_time, :runner2_time, :runner2_id, :runner3_float_time, :runner3_time, :runner3_id, :awt_float_time, :awt_time, :cat_float_time, :cat_time)
    end
end
