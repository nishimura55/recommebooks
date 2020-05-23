module ApplicationHelper
    def full_title(page_title = '')
          base_title = "Recommebooks"
          base_title if page_title.empty?
      else
            page_title + " | " + base_title
      end
    end
end
