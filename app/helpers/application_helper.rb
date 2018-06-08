module ApplicationHelper
  def alert_msg alert_type
    case alert_type
    when "success"
      "alert alert-success"
    when "danger"
      "alert alert-danger"
    when "warning"
      "alert alert-warning"
    else
      "alert"
    end
  end

  def link_to_update_status booking, arg
    link_to admin_booking_path(booking, booking: {status: "#{arg[:param]}"}),
      method: :patch, data: {confirm: I18n.t("alert.confirm")},
      class: "btn #{arg[:btn]}" do
      "<span class='glyphicon #{arg[:icon]}' aria-hidden='true'></span>#{arg[:text]}".html_safe
    end
  end
end
