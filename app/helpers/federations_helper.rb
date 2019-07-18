module FederationsHelper
  def admin_panf(federation)
    if (@userrols.find_by role: 1).present?
      return (link_to edit_admin_federation_path(federation), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать федерацию" do
        content_tag(:i, "", class: "fa fa-gears")
      end),
          (link_to admin_federation_path(federation), :method => :delete, :class => "close-link",
                   "data-toggle" => "tooltip",
                   "data-placement" => "top",
                   :title => "",
                   "data-original-title" => "Удалить федерацию" do
            content_tag(:i, "", class: "fa fa-close")
          end)
    end
  end
end
