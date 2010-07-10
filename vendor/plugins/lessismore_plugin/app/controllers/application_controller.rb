class ApplicationController < ActionController::Base
  unloadable
  before_filter :material_categories_for_menu, :except => [ :destroy, :restore, :reorder ]
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  helper :all
  protect_from_forgery
  include AuthenticatedSystem
  filter_parameter_logging :password

  before_filter :get_siteninja_config
  before_filter :cms_for_layout, :only => [ :index, :show, :new, :create, :edit, :update, :comment ]

   $USA_STATES_ARRAY = [['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'], ['California', 'CA'], ['Colorado', 'CO'], ['Connecticut', 'CT'], ['Delaware', 'DE'], ['District of Columbia', 'DC'], ['Florida', 'FL'], ['Georgia', 'GA'], ['Hawaii', 'HI'], ['Idaho', 'ID'], ['Illinois', 'IL'], ['Indiana', 'IN'], ['Iowa', 'IA'], ['Kansas', 'KS'], ['Kentucky', 'KY'], ['Louisiana', 'LA'], ['Maine', 'ME'], ['Maryland', 'MD'], ['Massachusetts', 'MA'], ['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'], ['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], ['New Hampshire', 'NH'], ['New Jersey', 'NJ'], ['New Mexico', 'NM'], ['New York', 'NY'], ['North Carolina', 'NC'], ['North Dakota', 'ND'], ['Ohio', 'OH'], ['Oklahoma', 'OK'], ['Oregon', 'OR'], ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'], ['South Carolina', 'SC'], ['South Dakota', 'SD'], ['Tennessee', 'TN'], ['Texas', 'TX'], ['Utah', 'UT'], ['Vermont', 'VT'], ['Virginia', 'VA'], ['Washington', 'WA'], ['Wisconsin', 'WI'], ['West Virginia', 'WV'], ['Wyoming', 'WY']] unless const_defined?('USA_STATES_ARRAY')

  protected

  def add_breadcrumb(name, url = '')
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end

  def self.add_breadcrumb(name, url, options = {})
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end

  private

  def cms_for_layout
    @menu = Page.visible
    @settings = Setting.first
  end

  def get_siteninja_config
    @renv = request.env["REQUEST_PATH"]
    @allre = request
    redirects = Redirect.all
    if !redirects.blank?
      redirects.each do |r|
        if request.env["REQUEST_PATH"] == r.from_url
          redirect_to "#{r.to_url}"
        end
      end
    end
    @cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
  end

  def material_categories_for_menu
    @material_categories_for_menu = MaterialCategory.all
  end
end

