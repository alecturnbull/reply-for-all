class DonorMailer < ActionMailer::Base
  default from: "reply-for-all@donorschoose.alecturnbull.com"

  def donated(email, body)
    mail(:to => email, :subject => "You just donated to Donor's Choose!", :body => body)
  end

  def test(email, headers)
    mail(:to => email, :subject => "Donors Choose received email", :body => headers)
  end
end
