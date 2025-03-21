# frozen_string_literal: true

module MenuHelper
  def tab_menu_ativo(campo, link, controller, action = "")
    if (action.blank? && params[:controller].include?(controller)) ||
       (params[:controller].include?(controller) && params[:action].include?(action))

      "<li class='nav-item'><a class='nav-link active'href='#{link}'>#{campo}</a></li>".html_safe
    else
      "<li class='nav-item'><a class='nav-link text-dark' href='#{link}'>#{campo}</a></li>".html_safe
    end
  end
end