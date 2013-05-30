module DashboardsHelper
  def chart_tag(action, height, params = {})
    params[:format] ||= :json
    path = dashboards_path(action, params)
    content_tag(:div, :'data-chart' => path, :style => "height: #{height}px;") do
      # image_tag('spinner.gif', :size => '24x24', :class => 'spinner')
      content_tag(:i, '', class: 'icon-spinner icon-spin orange bigger-150')
    end
  end
end
