class PledgesController < ApplicationController
  after_filter :set_access_control_headers
  
  def index
    @pledges = Pledge.all

    respond_to do |format|
      format.json { render :json => @pledges }
    end
  end

  def create
    @params = params[:pledge]

    @pledge = Pledge.new(@params)

    if @pledge.save
      status = true
    else
      status = false
    end

    respond_to do |format|

      format.json do
        render :json => { :saved => status, :pledge_id => @pledge.id }, :callback => params[:callback]
      end
    end
  end

  private
 
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end
