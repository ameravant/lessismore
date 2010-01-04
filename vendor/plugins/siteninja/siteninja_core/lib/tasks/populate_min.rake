 ###################################################################
#
# description:   database populator task for development use
# author:        Kip
# dependencies:  Populator and Faker gems (use `sudo gem install`)
# usage:         `rake db:populate` from your application's root
#
###################################################################

namespace :db do
  desc "Populate database with minimum data for new site."
  task :populate_min => :environment do
    @cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    require 'populator'
    require 'faker'
    
    if Rails.env.production?
      $DOMAIN_PATH = "http://#{@cms_config['website']['domain']}"
    else
      $DOMAIN_PATH = "http://localhost:3000"
    end
    
    def fake_assets
      puts "Adding assets..."
      # THESE MUST STAY IN THE SAME ORDER!
      Asset.create(:name => "Black Ninja", :file_file_name => "ninja_black.png", :file_file_size => 37860)
      Asset.create(:name => "Blue Ninja", :file_file_name => "ninja_blue.png", :file_file_size => 29432)
    end
    
    def fake_events
      puts 'Faking events...'
      Event.populate 4 do |e|
        e.name = Populator.words(2..5)
        e.address = "#{rand(1400)+100} State St, Santa Barbara, CA"
        e.description = generate_random_body_content
        e.event_date_and_time = 1.month.ago..3.months.from_now
        e.user_id = $USERS.rand.id
        if rand(2) == 0
          e.registration = true
          e.allow_cash = [true, false]
          e.allow_card = [true, false]
          e.allow_check = [true, false]
          e.check_instructions = Populator.paragraphs(1) if e.allow_check
          if rand(2) == 0
            e.registration_limit = [10, 50, 100, 200, 500]
            e.registration_closed_text = Populator.paragraphs(1)
          end
        end
      end
      
      puts 'Making permalinks...'
      Event.all.each { |event| event.update_attribute(:permalink, make_permalink(event.name)) }
    end
    
    def fake_pages
      puts "Creating pages..."
      
      home = Page.create(:title => 'Home', :body => 'home',
        :meta_title => "Home", :permalink => "home", :can_delete => false, :position => 1)
        Page.create(:title => 'About Us', :body => 'About', :meta_title => "About Yoursite.com")
        Page.create(:title => 'Blog', :meta_title => 'Blog', :body => "blog", :permalink => "blog", :can_delete => false) if @cms_config['modules']['blog'] 
        Page.create(:title => 'Images', :meta_title => 'Galleries', :body => "galleries", :permalink => "galleries", :can_delete => false) if @cms_config['modules']['galleries'] 
        Page.create(:title => 'Store', :meta_title => 'Store', :body => "Store", :permalink => "store", :can_delete => false) if @cms_config['modules']['store'] 
        contact = Page.create( :title => 'Contact Us', :body => "<h1>Contact #{@cms_config['website']['name']}</h1>", :meta_title => "Contact #{@cms_config['website']['name']}", :permalink => "inquire")
        Page.create(:parent_id => contact.id, :title => 'Contact Us - Thank You', :body => '<h1>Message sent!</h1><p>Thank you for submitting an inquiry. We usually respond within 2 business days by email.', :meta_title => "Message sent", :permalink => "inquiry_received", :status => 'hidden', :show_in_footer => false)
    end
    
    User.create(:name => "admin", :login => 'admin', :email => "admin@mailinator.com", :password => '123Mail', :password_confirmation => '123Mail')
    
     Setting.create(
      :footer_text => "<p >&copy; #YEAR# #{@cms_config['website']['name']}</p>",
      :inquiry_notification_email => "contact@#{@cms_config['website']['domain']}",
      :comment_profanity_filter => true,
      :events_range => 3,
      :tracking_code => '<script type="text/javascript"> 
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src=\'" + gaJsHost + "google-analytics.com/ga.js\' type=\'text/javascript\'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-7311013-1");
pageTracker._trackPageview();
} catch(err) {}</script>'
    )

    fake_assets # keep this line first
    fake_pages
    
  end
end
