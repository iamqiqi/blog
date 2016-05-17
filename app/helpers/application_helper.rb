module ApplicationHelper
	def resource_name
		:user
	end

	def resource
		@resource ||= current_user || User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
	
	def markdown(text)
		options = {
			escape_html: true,
			hard_wrap: true, 
			link_attributes: { rel: 'nofollow', target: "_blank" },
			fenced_code_blocks: true
		}

		extensions = {
			autolink: true,
			superscript: true,
			underline: true,
			disable_indented_code_blocks: true
		}

		renderer = Redcarpet::Render::HTML.new(options)
		markdown = Redcarpet::Markdown.new(renderer, extensions)

		markdown.render(text).html_safe
	end
end