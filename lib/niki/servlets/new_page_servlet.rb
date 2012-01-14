module Niki
  module Servlets
    class NewPageServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        response.body = render :new_page
      end

      def do_POST(request, response)
        process_new_page(request)
        supply_new_page(response)
      end

      private

      def process_new_page(request)
        @wiki =  @options[0]
        @title, @content  = request.query['title'], request.query['content']
      end

      def supply_new_page(response)
        return create_the_page(response) if page_can_be_added?
        prompt_error(response)
      end

      def page_can_be_added?
        Page.is_valid_with?(@title) and
          not @wiki.has_a_page_with?(title: @title)
      end

      def create_the_page(response)
        page = Page.with(@title, @content)
        add_and_redirect_to(page, response)
      end

      def add_and_redirect_to(page, response)
        add page
        redirect_to(page, response)
      end

      def add(page)
        pages = @wiki.pages << page
        @server.handle Wiki.with pages
      end

      def prompt_error(response)
        @error_message = "every page must have a title and it must be different from other pages'"
        response.body = render :new_page
      end
    end
  end
end
