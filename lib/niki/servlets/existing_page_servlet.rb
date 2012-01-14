require 'webrick'
require 'niki/page_request'
require 'niki/page_html'

module Niki
  module Servlets
    class ExistingPageServlet < HTTPServlet::AbstractServlet
      KNOWN_ACTIONS = [:edit, :show]

      def do_GET(request, response)
        requested = process_existing_page(request)
        supply_page(requested, response)
      end

      def do_POST(request, response)
        requested = process_existing_page(request)
        update_page(requested, request, response)
      end

      private

      def supply_page(requested, response)
        return render_all_pages(response) if requested.all_pages?
        render_page(requested, response)
      end

      def process_existing_page(request)
        @wiki = @options[0]
        return PageRequest.new(request.path)
      end

      def render_all_pages(response)
        response.body = render :index
      end

      def render_page(requested, response)
        render_action_for(page_with(requested.page_url), requested.action, response)
      end

      def page_with(url)
        return @wiki.page_with(url: url) if @wiki.has_a_page_with?(url: url)
        render_not_found
      end

      def render_action_for(page, action, response)
        return send action, page, response if KNOWN_ACTIONS.include? action
        render_not_found
      end

      def edit(page, response)
        @page, @title, @content = page, page.title, page.content
        response.body = render :edit_page
      end

      def show(page, response)
        @page = page.to_html @wiki
        response.body = render :page
      end

      #will this be needed with immutable wiki?
      #it won't and thats why its longer than two lines of code
      def update_page(requested, request, response)
        @page = page_with(requested.page_url)
        @title, @content  = request.query['title'], request.query['content']
        if page_can_be_updated?
          render_updated_page(response)
        else
          prompt_error(response)
        end
      end

      def page_can_be_updated?
        Page.is_valid_with?(@title) and
          there_is_no_other_page_with?(@title, @page)
      end

      def there_is_no_other_page_with?(title, page)
        @wiki.page_with(title: title) == page or
          not @wiki.has_a_page_with?(title: title)
      end

      def render_updated_page(response)
        @page.title, @page.content = @title, @content
        redirect_to(@page, response)
      end

      def prompt_error(response)
        @error_message = "every page must have a title and it must be different from other pages'"
        response.body = render :edit_page
      end
    end

  end
end
