class UpdateRequestController < ApplicationController
  skip_before_action :verify_authenticity_token
  def put
    respond_to do |format|
      req = Request.where('user_id = ? and shift_id = ?', current_user, params['shift']).first_or_create()
        req.eagerness = params['eagerness']
        req.shift_id  = params['shift']
      if req.shift.window.requesting? then
        req.user = current_user
        req.save
        @request = req
        format.json { render :show, status: :ok }
      else
        format.json { render json: {
          error: 'window status is not REQUESTING',
          status: 403 },
          status: 403 }
      end
    end
  end
end
