require 'webrick'
require 'niki/page_request'
require 'niki/rendered_page'

module Niki
  module Servlets
    class ExistingPageServlet < HTTPServlet::AbstractServlet

      def do_GET(request, response)
        @wiki, @response = @options[0], response
        requested = PageRequest.new(request.path)
        if requested.all_pages?
          render_all_pages
        else
          render_page_with_url(requested.page_url, requested.action)
        end
      end

      def do_POST(request, response)
        @wiki, @request, @response = @options[0], request, response
        requested = PageRequest.new(request.path)
        update_page_with_url(requested.page_url)
      end

      private

      def render_all_pages
        @response.body = render :index
      end

      def render_page_with_url(url, action)
        @page = @wiki.page_with_url(url)
        if @page.found?
          render_action_for(@page, action)
        else
          render_not_found
        end
      end

      def render_action_for(page, action)
        case action
        when :edit then
          @title, @content = @page.title, @page.content
          @response.body = render :edit_page
        when :show then
          @page = RenderedPage.new(@page, @wiki)
          @response.body = render :page
        else render_not_found
        end
      end

      def update_page_with_url(url)
        @page = @wiki.page_with_url(url)
        @title, @content  = @request.query['title'], @request.query['content']
        if Page.would_be_valid_with_title?(@title) and
           there_is_no_other_page_entitled?(@title, @page)
          update_page
        else
          prompt_error
        end
      end

      private

      def there_is_no_other_page_entitled?(title, page)
        (not @wiki.has_a_page_entitled?(title)) or @wiki.page_with_title(title) == page
      end

      def update_page
        @page.title = @title
        @page.content = @content
        redirect_to_page(@page, @response)
      end

      def prompt_error
        @error_message = "every page must have a title and it must be different from other pages'"
        @response.body = render :edit_page
      end
    end

  end
end
