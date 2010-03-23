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
    User.create(:name => "Donatello", :login => 'donatello', :email => "donatello@mailinator.com", :password => 'donatello', :password_confirmation => 'donatello', :active => true)
    User.create(:name => "Raphael", :login => 'raphael', :email => "raphael@mailinator.com", :password => 'raphael', :password_confirmation => 'raphael', :active => true)
    michaelangelo = User.create(:name => "Michaelangelo", :login => 'michaelangelo', :email => "michaelangelo@mailinator.com", :password => 'michaelangelo', :password_confirmation => 'michaelangelo', :active => true)
    michaelangelo.update_attribute(:can_deactivate, false)
    User.create(:name => "Leonardo", :login => 'leonardo', :email => "leonardo@mailinator.com", :password => 'leonardo', :password_confirmation => 'leonardo', :active => true)
    User.create(:name => "Shredder", :login => 'shredder', :email => "shredder@mailinator.com", :password => 'shredder', :password_confirmation => 'shredder', :active => true)
    User.create(:name => "Krang", :login => 'krang', :email => "krang@mailinator.com", :password => 'krang', :password_confirmation => 'krang', :active => true)
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
    Page.create(:title => 'Locations', :body => 'Locations', :meta_title => 'Locations', :permalink => 'locations', :status => 'visible', :can_delete => false, :can_edit_content => false, :parent_id => 1)
    Page.create(:title => 'Result', :body => 'Result', :meta_title => 'Result', :permalink => 'result', :status => 'hidden', :can_delete => false, :can_edit_content => false)

    regions = ["Buellton","Carpinteria","Gaviota","Goleta","Guadalupe","Hollister Ranch","Hope Ranch","Isla Vista","Lompoc","Los Alamos","Los Olivos","Mission Canyon","Mission Hills","Montecito","Orcutt","Santa Barbara","Santa Maria","Santa Ynez","Solvang","Summerland","Toro Canyon","Vandenberg Air Force Base"]
    regions.each { |region| Region.create(:name => region) }

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
        :introduction_banner_body => Populator.sentences(3..5) + ".",
        :introduction_banner_headline => Populator.sentences(1)
      )
    end

    materials_recycling = ['Paper','Document Shredding','Phone Books','Plastic','Number 1 PET','Number 2 HDPE','Number 3 PVC','Number 4 LDPE','Number 5 PP','Number 6 PS','Number 7','Glass','Metal']
    materials_recycling.each { |m| Material.create(:name => m, :material_category_id => 1, :introduction_banner_headline => Populator.sentences(1), :introduction_banner_body => (rand(5) == 0 ? Populator.sentences(1) : nil)) }

    materials_reuse = ['Asphalt','Bricks','Concreate','Drywall','Junk Mail','Flooring','Sand','Soil','Tiles (Ceiling)']
    materials_reuse.each { |m| Material.create(:name => m, :material_category_id => 2, :introduction_banner_headline => Populator.sentences(1), :introduction_banner_body => (rand(5) == 0 ? Populator.sentences(1) : nil)) }

    materials_hazard = ['Antifreeze','Asbestos','Batteries (Household)','Batteries (Vehicular)','Mercury','Motor Oil','Oil Filters','Paint','Latex','Oil','Pharmaceutical Waste (Medicines)','Photo Chemicals','Smoke Detectors','Sharps Collection']
    materials_hazard.each { |m| Material.create(:name => m, :material_category_id => 4, :introduction_banner_headline => Populator.sentences(1), :introduction_banner_body => (rand(5) == 0 ? Populator.sentences(1) : nil)) }

    materials_elec = ['Appliances','Cell Phones','CDs, DVDs, Floppy Disks','Electronic Equipment','Fluorescent Light Bulbs/Tubs','Medical Supplies and Equipment','Pagers','Personal Digital Assistants (PDA)']
    materials_elec.each { |m| Material.create(:name => m, :material_category_id => 5, :introduction_banner_headline => Populator.sentences(1), :introduction_banner_body => (rand(5) == 0 ? Populator.sentences(1) : nil)) }

    # Fill material descriptions
    for material in Material.all
      material.update_attribute :description, Populator.paragraphs(1..2) + "."
    end

    locations = [
      { :name => 'SuperDave\'s Supplies', :address => '410 w mitcheltorena', :zip => 93101, :description => "Home to many a fine things" },
      { :name => 'Kipper Inc.', :address => '24 w islay st', :zip => 93101, :description => "Get what you need here and so much more the products dont stop!" },
      { :name => 'Ameravant Web Studio', :address => '1224 e mason st', :zip => 93103 },
      { :name => "Jame's Joyce", :address => '513 state st', :zip => 93103 },
      { :name => "Ahi Sushi", :address => '3631 State St', :zip => 93101 },
      { :name => "Eric's Doom Factory", :address => '100 Bailard Ave', :zip => 93013 },
    ]
    materials = Material.all
    for l in locations
      l = Location.new(l)
      l.description = Populator.paragraphs(1..3) + "."
      l.save
      (rand(20)+20).times do
        this_material = materials[rand(materials.size)]
        l.materials << this_material unless l.materials.include?(this_material)
      end
    end
    ['Martial Arts','Spying','Espionage','Illusion','Clothing/Image','Weapons & Tactics'].each do |ac|
      c = ArticleCategory.create(:name => ac, :permalink => make_permalink(ac))
    end
    3.times do |i|
      user = $USERS.rand # pick random author for article

      a = Article.new
      a.title = Faker::Company.bs.titleize
      puts "- \"#{a.title}\" by #{user.name}" if (i % 10 == 0)
      a.permalink = make_permalink(a.title)
      a.published_at = 10.days.from_now - rand(400).days
      a.published = (rand(10) != 0)
      a.notify_author_of_comments = true
      a.body = generate_random_body_content
      a.blurb = $BLURB # defined in generate_random_body_content
      a.description = $DESCRIPTION
      a.social_share = true
      a.created_at = Time.now - rand(450).days
      a.updated_at = a.created_at
      a.user_id = user.id
      a.save

      if a.published_at <= Time.now
        rand(10).times do
          c = a.comments.build # new comment for this article
          if rand(10) == 0
            # comment is from author
            c.name = user.name
            c.email = user.email
            c.user_id = user.id
          else
            # comment from blog visitor
            c.name = (rand(3) == 0 ? Faker::Name.first_name : Faker::Name.name)
            if rand(5) < 2
              c.email = (rand(2) == 0 ? Faker::Internet.email : Faker::Internet.free_email)
            end
          end
          c.comment = random_pirate_paragraphs(1,1)
          c.created_at = Time.now - rand(((Time.now - a.published_at) / (60*60*24)).to_i.days)
          c.updated_at = c.created_at
          c.save
        end
      end
    end

    make_tags(Article.all)

    Article.reset_column_information
    for article in Article.all
      Article.update_counters article.id, :comments_count => article.comments.size
      (rand(2)+1).times do
        # assign article to 1-2 categories
        c = ArticleCategory.find(rand(ArticleCategory.count) + 1)
        article.article_categories << c unless article.article_categories.include?(c)
      end
    end

    # Relate articles to material categories
    material_categories = MaterialCategory.all
    for article in Article.all
      rand(2).times do
        material_category = material_categories.sort_by(&:rand).first
        article.material_categories << material_category unless article.material_categories.include?(material_category)
      end
    end

    Event.populate 100 do |e|
      e.name = Faker::Company.bs.titleize
      e.description = Populator.paragraphs(3..6)
      e.permalink = make_permalink(e.name)
      e.user_id = 1
      e.created_at = 3.years.ago..Time.now
      e.date_and_time = 3.months.ago..1.year.from_now
    end

    # Relate events to material categories
    for event in Event.all
      rand(2).times do
        material_category = material_categories.sort_by(&:rand).first
        event.material_categories << material_category unless event.material_categories.include?(material_category)
      end
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
     :introduction_banner_headline => Populator.sentences(1),
     :introduction_banner_body => Populator.sentences(3..5)
    )
  end
end

