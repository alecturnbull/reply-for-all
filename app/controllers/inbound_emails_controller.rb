class InboundEmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive

    @sender = params["from"]
    @headers = params["headers"]

    DonorMailer.test(@sender, @headers).deliver

    render :status => 200

  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end
end
