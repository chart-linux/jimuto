class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]

  # GET /solutions
  # GET /solutions.json
  def index
    @solutions = Solution.all
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
  end

  # GET /solutions/new
  def new
    @solution = Solution.new()
    @shifts = Shift.all.group_by{|s| s.start.strftime("%Y-%m-%d")}
  end

  # GET /solutions/1/edit
  def edit
  end

  # POST /solutions
  # POST /solutions.json
  def create
    s = Solution.new(user: current_user, window: Shift.find(params[:shifts].first.first.to_i).window)
    s.save!
    # params[:shifts]は、Shiftのid => Requestのid のハッシュ
    request_solutions = params[:shifts].map{|k, v| RequestSolution.new(solution_id: s.id ,request_id: v.to_i) }
    # boolだと思ったらboolじゃないようだ
    b = RequestSolution.import request_solutions
    if b
      redirect_to controller: :windows, action: 'index', notice: 'シフトの解決案を提出しました。'
    end
=begin
    respond_to do |format|
      if @solution.save
        format.html { redirect_to @solution, notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update
    respond_to do |format|
      if @solution.update(solution_params)
        format.html { redirect_to @solution, notice: 'Solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to solutions_url, notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.fetch(:solution, {})
    end
end
