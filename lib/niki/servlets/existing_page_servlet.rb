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
        update page_with(requested.page_url), request, response
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

      def update(page, request, response)
        @page, @title, @content  = page, *page_data_in(request)
        validate_data_and_update page, response
      end

      def validate_data_and_update(page, response)
        return render_updated page, response if can_update? page
        prompt_error(response)
      end

      def can_update?(page)
        Page.is_valid_with?(@title) and
          there_is_no_other_page_with?(@title, page)
      end

      def there_is_no_other_page_with?(title, page)
        @wiki.page_with(title: title) == page or
          not @wiki.has_a_page_with?(title: title)
      end

      def render_updated(page, response)
        swap page, updated_page
        redirect_to updated_page, response
      end

      def updated_page
        @updated_page ||= Page.with(@title, @content)
      end

      def swap(page, new_page)
        @server.wiki.pages.delete page
        @server.handle_a_wiki_with(@server.wiki.pages << updated_page)
      end

      def prompt_error(response)
        @error_message = "every page must have a title and it must be different from other pages'"
        response.body = render :edit_page
      end

      def page_data_in(request)
        [request.query['title'], request.query['content']]
      end
    end

  end
end
