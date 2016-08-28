class WindowsController < ApplicationController
  before_action :set_window, only: [:show, :edit, :update, :destroy, :init_timetable]
  before_action :admin_user!, except: [:show, :index]
  YOUBI = %w[日 月 火 水 木 金 土]
  # GET /windows
  # GET /windows.json
  def index
    @windows = Window.all
  end

  # GET /windows/1
  # GET /windows/1.json
  def show
    @shifts = Shift.where('window_id = ?', @window).group_by{|s| s.start.strftime("%m/%d") + "(" + YOUBI[s.start.wday] + ")"}
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
    date_base = Date.today.next_week
    @dates = []
    for n in 0...8 do
      @dates << date_base.advance(days: 7*n)
      puts n
    end
    @dates = @dates.map{|date| [date.strftime("%m/%d") + " -> " + date.next_week.yesterday.strftime("%m/%d"), date.to_time.to_i] }
  end

  # GET /windows/1/edit
  def edit
    @dates = []
  end

  def init_timetable
  end

  # POST /windows
  # POST /windows.json
  def create
    @window = Window.new(window_params)
    @window.save!
    time = Time.at(start_date_params["start_date"].to_i)
    7.times do |week_num|
        [[[hour: 8], [hour: 10]], [[hour: 10], [hour: 12, minute: 30]],[ [hour: 12, minute: 30], [hour: 15]],[[hour: 15], [hour: 17, minute: 30]],[[hour: 17, minute: 30],[hour: 20]],[[hour: 20], [hour: 23]]].each do |options|
        Shift.create!(
          start: time.change(options[0][0]),
          end: time.change(options[1][0]),
          window: @window
        )
      end
        Shift.create!(
          start: time.change(hour: 23),
          end: time.tomorrow.change(hour: 8),
          window: @window
        )
      time = time.tomorrow
    end
    redirect_to @window
  end

  # PATCH/PUT /windows/1
  # PATCH/PUT /windows/1.json
  def update
    respond_to do |format|
      if @window.update(window_params)
        if window_params[:status] == "confirmed"
          fix_shift(format)
        else
          format.html { redirect_to windows_path, notice: 'Window was successfully updated.' }
        end
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
      params.require(:window).permit(:message, :status)
    end

    def start_date_params
      params.permit(:start_date)
    end

    def fix_shift(format)
      format.html { redirect_to windows_path, notice: 'シフトを確定しました。(未実装)' }
    end
end
