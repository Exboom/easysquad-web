module LocationsHelper
  def admin_pan_location(location)
    if can? :edit, @location
      return (link_to edit_admin_location_path(location), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать место" do
        content_tag(:i, "", class: "fa fa-gears")
      end)
    end
  end
end
