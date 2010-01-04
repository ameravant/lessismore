# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Outputs a small tag
  def material_tag(material_category)
    content_tag(:div, h(material_category.short_name), :class => "material_tag #{material_category.css_class}")
  end
  def homepage?
    @page and @page.permalink == 'home'
  end
end
