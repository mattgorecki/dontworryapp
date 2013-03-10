module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Don't Worry"
    if page_title.empty?
      "#{base_title} - Let them know you're okay."
    else
      "#{base_title} | #{page_title}"
    end
  end

  def sub_title(sub_title)
    base_title = "Let them know you're okay."
    if sub_title.empty?
      base_title
    else
      sub_title
    end
  end

end
