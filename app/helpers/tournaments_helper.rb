module TournamentsHelper
  def admin_pant(tournament)
    if (@userrols.find_by role: 1).present?
      return (link_to edit_admin_tournament_path(tournament), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать турнир" do
        content_tag(:i, "", class: "fa fa-gears")
      end),
          (link_to admin_tournament_path(tournament), :method => :delete, :class => "close-link",
                   "data-toggle" => "tooltip",
                   "data-placement" => "top",
                   :title => "",
                   "data-original-title" => "Удалить турнир" do
            content_tag(:i, "", class: "fa fa-close")
          end)
    end
  end
end
