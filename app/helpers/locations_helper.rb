module LocationsHelper
  def admin_panl(location)
    if (@userrols.find_by role: 1).present?
      return (link_to edit_admin_location_path(location), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать место" do
        content_tag(:i, "", class: "fa fa-gears")
      end),
          (link_to admin_location_path(location), :method => :delete, :class => "close-link",
                   "data-toggle" => "tooltip",
                   "data-placement" => "top",
                   :title => "",
                   "data-original-title" => "Удалить место" do
            content_tag(:i, "", class: "fa fa-close")
          end)
    end
  end
end
