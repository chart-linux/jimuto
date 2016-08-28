class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    windows = Window.all
    @achievements = {}
    @achievements['手配師志願者'] = (@user.solutions.count >= 1)
    @achievements['新米手配師'] = (@user.accepted_solutions.count >= 1)
    @achievements['ブローカー'] = (@user.accepted_solutions.count >= 10)
    @achievements['リジェンダリ・ブローカー'] = (@user.accepted_solutions.count >= 100)
    @achievements['良き隣人'] = windows.any? {|w| w.shifts.select{|s| s.requests.any? {|r| r.user == @user }}.count >= 10}
    @achievements['有閑階級'] = windows.any? {|w| w.shifts.select{|s| s.requests.any? {|r| r.user == @user }}.count >= 20}
  end
end
