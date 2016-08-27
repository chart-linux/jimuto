class UpdateRequestController < ApplicationController
  skip_before_action :verify_authenticity_token
  def put
    respond_to do |format|
      req = Request.where('user_id = ? and shift_id = ?', current_user, params['shift']).first_or_create()
      req.eagerness = params['eagerness']
      req.shift_id  = params['shift']
      req.user = current_user
      req.save
      @request = req
      format.json { render :show, status: :ok }
    end
  end
end
