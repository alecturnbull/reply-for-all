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
      
      if @pledge.complete == false

        if @pledge.recipient == nil
          @pledge.recipient = @recipient
          @pledge.sender = @sender
          @pledge.sent_at = @sent_at

        else 
          @pledge.complete = true
          if Time.now > @pledge.expiration
            # it expired, no donation
            @pledge.success = false
            subject = "Really?"
            body = "You couldn't just answer the email in time? We wanted to give $#{@pledge.amount} dollars to Donors Choose. But I guess that's not happening now, is it?"
            DonorMailer.failed(@pledge.recipient, subject, body).deliver
          else
            @pledge.success = true
            resp = donate(@pledge)
            body = "Congratulations! You just fought email laziness for good. We've put through your donation to Donors Choose for $#{@pledge.amount}. "
            DonorMailer.donated(@pledge.sender, body).deliver
          end

        end

        @pledge.save!
        render :nothing => true, :status => 200
      end
    else
      render :nothing => true, :status => 200
    end


    render :nothing => true, :status => 200
  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end

  def donate(pledge)
    uri = URI.parse('https://apisecureqa.donorschoose.org/common/json_api.html')
    params = { 
      hackathon: "true", 
      amount: pledge.amount.match(/[0-9]|\.+/), 
      proposalId: pledge.project_id, 
      email: pledge.sender_email, 
      first: pledge.first_name, 
      last:pledge.last_name, 
      action: "donate", 
      APIKey: "DONORSCHOOSE", 
      apipassword: "helpClassrooms!"
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    post = http.post(uri.path,params.to_query)
    return JSON.parse(post.body)
  end

end
