namespace :db do
  task :populate_less => :environment do

    require 'populator'
    require 'faker'
    require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_core/lib/tasks/populate_urls.rb"
    require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_core/lib/tasks/populate_methods.rb"
    def make_permalink(x)
      x.gsub(/\W/, ' ').strip.downcase.gsub(/\ +/, '-')
    end

    puts "Running populator..."

    User.create(:name => "admin", :login => 'admin', :email => "admin@mailinator.com", :password => 'admin', :password_confirmation => 'admin', :active => true)
    $USERS = User.all

    Page.create(:title => 'Home', :body => 'Home', :meta_title => 'Home', :permalink => 'home', :can_delete => false)
    Page.create(:title => 'Recycle', :body => 'Recycle', :meta_title => 'Recycle', :permalink => 'recycle', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Reduce & Reuse', :body => 'Reduce & Reuse', :meta_title => 'Reduce & Reuse', :permalink => 'reduce-reuse', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Yard Waste', :body => 'Yard Waste', :meta_title => 'Yard Waste', :permalink => 'yard-waste', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Hazardous Waste', :body => 'Hazardous Waste', :meta_title => 'Hazardous Waste', :permalink => 'hazardous-waste', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Electronics', :body => 'Electronics', :meta_title => 'Electronics', :permalink => 'electronics', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Trash', :body => 'Trash', :meta_title => 'Trash', :permalink => 'trash', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Events', :body => 'Events', :meta_title => 'Events', :permalink => 'events', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Blog', :body => 'Blog', :meta_title => 'Blog', :permalink => 'blog', :status => 'hidden', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Locations', :body => 'Locations', :meta_title => 'Locations', :permalink => 'locations', :status => 'visible', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Result', :body => 'Result', :meta_title => 'Result', :permalink => 'result', :status => 'hidden', :can_delete => false, :can_edit_content => false)
    Page.create(:title => 'Inquire', :body => 'Inquire', :meta_title => 'Inquire', :permalink => 'inquire', :status => 'visible', :can_delete => false, :can_edit_content => true)
    Page.create(:title => 'Inquiries', :body => 'Inquiries', :meta_title => 'Inquiries', :permalink => 'inquiries', :status => 'visible', :can_delete => false, :can_edit_content => true)
    
    material_categories = [
      ['Recycle','Recycle'],
      ['Reduce & Reuse','Reduce/Reuse'],
      ['Yard Waste','Yard Waste'],
      ['Hazardous Waste','Hazardous'],
      ['Electronics','Electronics'],
      ['Trash','Trash']
    ]
    for material_category in material_categories
      MaterialCategory.create(
        :name => material_category.first,
        :short_name => material_category.last,
        :css_class => material_category.first.downcase.gsub(/\s+/,'_').gsub(/\W/,'').gsub('__','_'),
        :introduction_banner_body => "",
        :introduction_banner_headline => ""
      )
    end

    Setting.create(
      :footer_text => '<p style="text-align: center;">&copy; 2008-#YEAR# Site-Ninja.com</p>
<p style="text-align: center;"><a href="/" class="icon"><img title="SiteNinja Homepage" src="/system/files/1/thumb/ninja_black.png" alt="Black Ninja" width="48" height="45" border="0" /></a></p>',
      :inquiry_notification_email => "contact@ameravant.com",
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
} catch(err) {}</script>',
     :introduction_banner_headline => "",
     :introduction_banner_body => ""
    )
  end
end

