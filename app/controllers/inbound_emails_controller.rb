class InboundEmailsController < ApplicationController

  def receive
    @pledge_id = params["cc"].match(/[1-9][0-9]*/)
    @recipient = params["to"]
    @sender = params["from"]
    @headers = params["headers"]

    @pledge = Pledge.find(@pledge_id)

    if @pledge.recipient = nil
      @pledge.recipient = @recipient
      @pledge.sender = @sender
      @pledge.save
      # first email being sent
      # save data to pledge
    else 
      # response
      # check time
      # donate
    end


    render :status => 200

  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end
end
