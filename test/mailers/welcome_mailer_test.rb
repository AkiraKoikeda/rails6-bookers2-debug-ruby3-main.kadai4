require "test_helper"

class WelcomeMailerTest < ActionMailer::TestCase
  test "send_up_signup" do
    mail = WelcomeMailer.send_up_signup
    assert_equal "Send up signup", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
