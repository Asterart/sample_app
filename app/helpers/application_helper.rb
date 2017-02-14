module ApplicationHelper

	def full_title(page_title = '')
		base_title = " Let's get to know each other"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end

	end

end
