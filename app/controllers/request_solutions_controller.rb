class RequestSolutionsController < ApplicationController
  before_action :set_request_solution, only: [:show, :edit, :update, :destroy]

  # GET /request_solutions
  # GET /request_solutions.json
  def index
    @request_solutions = RequestSolution.all
  end

  # GET /request_solutions/1
  # GET /request_solutions/1.json
  def show
  end

  # GET /request_solutions/new
  def new
    @request_solution = RequestSolution.new
  end

  # GET /request_solutions/1/edit
  def edit
  end

  # POST /request_solutions
  # POST /request_solutions.json
  def create
    @request_solution = RequestSolution.new(request_solution_params)

    respond_to do |format|
      if @request_solution.save
        format.html { redirect_to @request_solution, notice: 'Request solution was successfully created.' }
        format.json { render :show, status: :created, location: @request_solution }
      else
        format.html { render :new }
        format.json { render json: @request_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_solutions/1
  # PATCH/PUT /request_solutions/1.json
  def update
    respond_to do |format|
      if @request_solution.update(request_solution_params)
        format.html { redirect_to @request_solution, notice: 'Request solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @request_solution }
      else
        format.html { render :edit }
        format.json { render json: @request_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_solutions/1
  # DELETE /request_solutions/1.json
  def destroy
    @request_solution.destroy
    respond_to do |format|
      format.html { redirect_to request_solutions_url, notice: 'Request solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_solution
      @request_solution = RequestSolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_solution_params
      params.fetch(:request_solution, {})
    end
end
