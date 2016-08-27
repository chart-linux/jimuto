class WindowsController < ApplicationController
  before_action :set_window, only: [:show, :edit, :update, :destroy, :init_timetable]

  # GET /windows
  # GET /windows.json
  def index
    @windows = Window.all
  end

  # GET /windows/1
  # GET /windows/1.json
  def show
    @shifts = Shift.where('window_id = ?', @window).group_by{|s| s.start.strftime("%Y-%m-%d")}
    @user_requests = []
    @shifts.each do |day, shift_by_day|
      shift_by_day.each do |shift|
        ur = current_user.requests.select {|r| r.shift == shift}
        if ur.count != 0 then
          ur = ur[0]
        else
          ur = false
        end
        @user_requests[shift.id] = ur
      end
    end
  end

  # GET /windows/new
  def new
    @window = Window.new
  end

  # GET /windows/1/edit
  def edit
  end

  def init_timetable
  end

  # POST /windows
  # POST /windows.json
  def create
    @window = Window.new(window_params)

    respond_to do |format|
      if @window.save
        format.html { redirect_to @window, notice: 'Window was successfully created.' }
        format.json { render :show, status: :created, location: @window }
      else
        format.html { render :new }
        format.json { render json: @window.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /windows/1
  # PATCH/PUT /windows/1.json
  def update
    respond_to do |format|
      if @window.update(window_params)
        format.html { redirect_to @window, notice: 'Window was successfully updated.' }
        format.json { render :show, status: :ok, location: @window }
      else
        format.html { render :edit }
        format.json { render json: @window.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /windows/1
  # DELETE /windows/1.json
  def destroy
    @window.destroy
    respond_to do |format|
      format.html { redirect_to windows_url, notice: 'Window was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_window
      @window = Window.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def window_params
      params.require(:window).permit(:message)
    end
end
