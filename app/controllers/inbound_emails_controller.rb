class InboundEmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive

    @recipient = params["to"]
    @sender = params["from"]
    @headers = params["headers"]

    # @pledge = Pledge.find(@pledge_id)

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

    DonorMailer.test(@sender, @headers).deliver

    render :status => 200

  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end
end
