# Paperclip interpolation for all models

Paperclip.interpolates :chain_rest_id do |attachment, style|
  rest = nil
  case attachment.instance.class.to_s
    when "Dish"
      if !attachment.instance.sections.empty? and !attachment.instance.sections.first.menu.nil? and !attachment.instance.sections.first.menu.restaurant.nil?
        rest = attachment.instance.sections.first.menu.restaurant
      end
    when "Section"
      if !attachment.instance.menu.nil? and !attachment.instance.menu.restaurant.nil?
        rest = attachment.instance.menu.restaurant
      end
    when "Subsection"
      if !attachment.instance.section.nil? and !attachment.instance.section.menu.nil? and !attachment.instance.section.menu.restaurant.nil?
        rest = attachment.instance.section.menu.restaurant
      end
    when "RestaurantBanner"
      if !attachment.instance.restaurant.nil?
        rest = attachment.instance.restaurant
      end
    else
      # yay, else, then!
  end
  if !rest.nil?
    return "chain_#{rest.chain.id}/restaurant_#{rest.id}"
  else
    return "unknown"
  end
end








