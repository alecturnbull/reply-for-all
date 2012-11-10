class InboundEmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive

    @sender = params["from"]
    @recipient = params["to"]
    @pledge_id = params["cc"] ? params["cc"].match(/([1-9][0-9]*)/)[0] : nil

    if @pledge_id
      @pledge = Pledge.find(@pledge_id)
      
      if @pledge.recipient == nil
        @pledge.recipient = @recipient
        @pledge.sender = @sender
      else 
        @pledge.complete = true
        @pledge.success = true
      end

      @pledge.save
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 200
    end


  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end
end
