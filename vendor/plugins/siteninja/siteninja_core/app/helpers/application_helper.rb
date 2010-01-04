# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # include TagsHelper
  include NinjaParseHelper # methods for parsing page content for auto-embed
  include ImagePathsHelper # holds long paths to often-used images
  include IconHelper # methods for outputting icons or trash links

  # Displays an "optional" label in gray
  def optional
    content_tag :span, "optional", :class => "small gray"
  end

  # Simple div clear tag for formatting.
  def clear
    content_tag("div", nil, :class => "clear")
  end

  # Outputs div with notice or error ID for flash information.
  def flash_div
    if flash[:notice]
      content_tag("div", h(flash[:notice]), :id => "notice")
    elsif flash[:error]
      content_tag("div", h(flash[:error]), :id => "error")
    end
  end
  
  # Creates div for submit button with automatic click feedback with a spinner icon.
  def fancy_submit(cancel_link=nil)
    concat('<div class="submit">')
      yield # submit button
      concat(content_tag('span', spinner + ' ', { :style => 'display: none;', :id => 'submit_spinner' }))
      concat(content_tag('span', 'or ' + link_to('cancel', cancel_link, :confirm => 'Are you sure you want to cancel?'), :id => 'submit_cancel')) unless cancel_link.nil?
      concat(content_tag('span', nil, :id => 'submit_message'))
    concat('</div>')
  end
    
  def month_name(month_number)  
    Date::MONTHNAMES[month_number] if month_number  
  end

end
