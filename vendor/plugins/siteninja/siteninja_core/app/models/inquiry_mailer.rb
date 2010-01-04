class InquiryMailer < ActionMailer::Base

  def notification_to_admin(inquiry)
    setup_email(Setting.first.inquiry_notification_email, "New inquiry received (\##{inquiry.id})")
    body :inquiry => inquiry
  end

  
  private
  
  def setup_email(email, subject)
    cms_config ||= YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    recipients   email.strip
    from         "#{cms_config['website']['name']} <mailer@#{cms_config['website']['domain']}>"
    headers      'Reply-to' => "mailer@#{cms_config['website']['domain']}"
    subject      subject.strip
    sent_on      Time.now
  end

end
