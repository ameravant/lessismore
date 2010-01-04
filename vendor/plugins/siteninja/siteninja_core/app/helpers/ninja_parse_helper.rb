# This helper module is for helpers that parse content of page body text and do things like
# automatically replace specific formatted text with more advanced HTML, like 
# a YouTube video automatically embedding into a page instead of a simple link.

module NinjaParseHelper

  # Performs different replacements for things like automatic embedding of videos, images, etc.
  def ninja_parse(content)
    # Youtube video
    content.gsub!(/\bhttp:\/\/(www\.)?youtube\.com\/watch\?v\=([a-zA-Z0-9_\-]+)\b/, render(:partial => "/shared/embed_youtube", :locals => { :video_id => '\2' }))

    # Vimeo video
    content.gsub!(/\bhttp:\/\/(www\.)?vimeo\.com\/(\d+)\b/, render(:partial => "/shared/embed_vimeo", :locals => { :video_id => '\2' }))    

    # Image
    content.gsub!(/\b(http[s]?:\/\/[^\/]+\/\S*\.)(jpg|jpeg|gif|png)\b/, render(:partial => "/shared/embed_image", :locals => { :image_src => '\1\2'}))
    # .scan(/[^\/]+/).last[/[^\.]+/].humanize.titleize
    
    # Gallery Image
    content.gsub!(/\b(image_tag)(_small:)(\/\S*)(\Ssmall)(\S*\.)(jpg|jpeg|gif|png)\b/, render(:partial => "/shared/embed_image", :locals => { :image_src => '\3\4\5\6', :type => 'small', :image_lrg => '\3/slide\5\6'}))
    content.gsub!(/\b(image_tag)(_medium:)(\/\S*)(\Smedium)(\S*\.)(jpg|jpeg|gif|png)\b/, render(:partial => "/shared/embed_image", :locals => { :image_src => '\3\4\5\6', :type => 'medium', :image_lrg => '\3/slide\5\6'}))
    content.gsub!(/\b(image_tag)(_large:)(\/\S*\.)(jpg|jpeg|gif|png)\b/, render(:partial => "/shared/embed_image", :locals => { :image_src => '\3\4', :type => 'large'}))
    
    # Slideshow Replacement
    content.gsub!("#slideshow#", render(:partial => "/shared/embed_slideshow"))
    
    # Return the new content
    content
  end  

end
