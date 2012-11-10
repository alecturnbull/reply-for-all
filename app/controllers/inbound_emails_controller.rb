require "uri"
require "net/http"

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
        if Time.now > @pledge.expiration
          # it expired, no donation
          @pledge.success = false
        else
          @pledge.success = true
          resp = donate(@pledge)
          DonorMailer.donated(@pledge.sender, resp)
        end

      end

      @pledge.save!
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 200
    end


  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end

  def donate(pledge)
    uri = URI.parse('https://apisecurqa.donorschoose.org/common/json_api.html')
    params = { 
      amount: pledge.amount.match(/[A-Za-z$-\s]/),
      proposalId: pledge.project_id,
      email: "alec.turnbull@gmail.com",
      first: "Alec",
      last:"Turnbull",
      action: "donate",
      APIKey: "DONORSCHOOSE",
      apipassword: "helpClassrooms!"
    }
    post = Net::HTTP.post_form(uri, params)
    return post.body
  end

end
