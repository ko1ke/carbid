module BidsHelper
  def sold_label(accepted)
    if accepted
      content_tag(:p,'SOLD!', class: 'sold-label')
    end
  end
end
