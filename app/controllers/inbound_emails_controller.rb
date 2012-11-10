class InboundEmailsController < ApplicationController

  def receive
    @params = params

    @inbound_email = InboundEmail.new( :sender => clean_field(params["to"]),
                                       :recipient => clean_field(params["from"]),
                                     ) 


  end


  private

  def clean_field(input_string)
    input_string.gsub(/\n/,'') if input_string
  end
end
