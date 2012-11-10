class InboundEmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive

    @header_parse = params["headers"].match(/[>][;][\s](.*?)[)]/)[0].gsub(">; ", "")

    @sent_at = DateTime.parse(@header_parse)
    @sender = params["from"]
    @recipient = params["to"]
    @pledge_id = params["cc"] ? params["cc"].match(/([1-9][0-9]*)/)[0] : nil

    if @pledge_id
      @pledge = Pledge.find(@pledge_id)
      

      if @pledge.recipient == nil
        @pledge.recipient = @recipient
        @pledge.sender = @sender
        @pledge.sent_at = @sent_at
      else 
        @pledge.complete = true
        @pledge.success = true
      end

      @pledge.save!
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 404
    end


  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end
end
