module ApplicationHelper
  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass} alert-dismissible fade show") do
      concat content_tag(:a, '×', class: 'close', data: { dismiss: 'alert' })
      concat raw(message)
    end
  end

  def active?(path)
    "active" if current_page?(path)
  end

end
