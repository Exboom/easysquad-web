module FederationsHelper
  def admin_pan_federation(federation)
    if can? :edit, @federation
      return (link_to edit_admin_federation_path(federation), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать федерацию" do
        content_tag(:i, "", class: "fa fa-gears")
      end)
    end
  end
end
