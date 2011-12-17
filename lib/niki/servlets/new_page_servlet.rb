module Niki
  module Servlets
    class NewPageServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        response.body = render :new_page
      end

      def do_POST(request, response)
        process_new_page(request)
        generate_new_page(response)
      end

      private

      def process_new_page(request)
        @wiki =  @options[0]
        @title, @content  = request.query['title'], request.query['content']
      end

      def generate_new_page(response)
        return create_the_page(response) if page_can_be_added?
        prompt_error(response)
      end

      def page_can_be_added?
        Page.is_valid_with?(@title) and
        not @wiki.has_a_page_entitled?(@title)
      end

      def create_the_page(response)
        page = Page.with(@title, @content)
        add_and_redirect_to(page, response)
      end

      def add_and_redirect_to(page, response)
        @wiki.publish(page)
        redirect_to_page(page, response)
      end

      def prompt_error(response)
        @error_message = "every page must have a title and it must be different from other pages'"
        response.body = render :new_page
      end
    end
  end
end
