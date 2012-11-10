class DonorMailer < ActionMailer::Base
  default from: "reply-for-all@donorschoose.alecturnbull.com"

  def test(email, headers)
    mail(:to => email, :subject => "Donors Choose received email", :body => headers)
  end
end
