module Niki
  module Servlets
    class NewPageServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        response.body = render :new_page
      end

      def do_POST(request, response)
        niki = @options[0]
        @title = request.query['title']
        @content = request.query['content']
        if Page.would_be_valid_with_title?(@title)
          page = Page.with(@title, @content)
          niki.add_page(page)
          redirect_to_page(page, response)
        else
          @error_message = 'every niki must have a title'
          response.body = render :new_page
        end
      end
    end
  end
end
