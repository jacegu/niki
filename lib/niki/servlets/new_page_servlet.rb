module Niki
  module Servlets
    class NewPageServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        response.body = render :new_page
      end

      def do_POST(request, response)
        wiki =  @options[0]
        @title, @content  = request.query['title'], request.query['content']
        if Page.would_be_valid_with_title?(@title) and
           not wiki.has_a_page_with_title?(@title)
          create_the_page(wiki, response)
        else
          prompt_error(response)
        end
      end

      private

        def create_the_page(wiki, response)
          page = Page.with(@title, @content)
          wiki.add_page(page)
          redirect_to_page(page, response)
        end

        def prompt_error(response)
          @error_message = "every page must have a title and it must be different from other pages'"
          response.body = render :new_page
        end
    end
  end
end
