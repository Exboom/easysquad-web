module TournamentsHelper
  def admin_pan_tourn(tournament)
    if (@userrols.find_by role: 1).present?
      return (link_to edit_admin_tournament_path(tournament), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать турнир" do
        content_tag(:i, "", class: "fa fa-gears")
      end)
    end
  end
end
