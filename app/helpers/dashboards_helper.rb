module DashboardsHelper
  def chart_tag(action, height, params = {})
    params[:format] ||= :json
    path = dashboards_path(action, params)
    content_tag(:div, :'data-chart' => path, :style => "height: #{height}px;") do
      content_tag(:i, '', class: 'icon-spinner icon-spin orange bigger-150')
    end
  end

  # Use first chain logo as avatar
  def user_avatar_tag
    img = current_user.chains.first.logo if current_user.chains.present?
    img ||= "/assets/avatars/avatar2.png"
    image_tag(img, alt: "logo", class: 'nav-user-photo')
  end

  def label_tag(title,comment_id)
    if title == 'approved'
      content_tag(:span, title, class: 'label label-success arrowed arrowed-in-right ' + comment_id.to_s)
    else title == 'rejected'
      content_tag(:span, title, class: 'label label-important ' + comment_id.to_s)
    end
  end
end
