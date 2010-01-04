class InquiryObserver < ActiveRecord::Observer

  def after_create(inquiry)
    InquiryMailer.deliver_notification_to_admin(inquiry) rescue nil
  end

end
