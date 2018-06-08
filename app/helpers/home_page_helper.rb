module HomePageHelper
  def draw_categories categories
    html = ""
    categories.each do |category|
      check_to_show_category(category, html)
    end
    html
  end

  def draw_subcategories category
    html = "<ul class='dropdown-menu multi-level'>"
    category.childs.each do |c|
      check_to_show_subcategory(c, html)
    end
    html << "</ul>"
    html
  end

  def has_child? category
    category.childs.any?
  end

  def check_to_show_category category, html
    if has_child?(category)
      html << "<li>"
      html << "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>
        #{category.name}<span class='caret'></span></a>"
      html << draw_subcategories(category)
      html << "</li>"
    else
      html << "<li><a href='#'>#{category.name}</a></li>"
    end
  end

  def check_to_show_subcategory category, html
    if has_child?(category)
      html << "<li class='dropdown-submenu'>"
      html << "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>
        #{category.name}</a>"
      html << draw_subcategories(category)
      html << "</li>"
    else
      html << "<li><a href='#'>#{category.name}</a></li>"
    end
  end
end
