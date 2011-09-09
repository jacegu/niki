module Niki
  class RenderedPage
    attr_reader :page, :wiki

    def initialize(page_to_render, wiki)
      @page = page_to_render
      @wiki = wiki
    end

    def title
      @page.title
    end

    def url
      @page.url
    end

    def content
      Content.new(@page.content, wiki).to_html
    end

    private

    class Content
      def initialize(content, wiki)
        @content, @wiki = content, wiki
      end

      def to_html
        @content.split("\n").map do |line|
          render_paragraph_in(render_links_in(line))
        end.join("\n")
      end

      def render_paragraph_in(line)
        "<p>#{line}</p>"
      end

      def render_links_in(line)
        matched_link = line.match(/\[([a-z]|[0-9]|\s)+\]/i)
        if matched_link
          link = LinkInContent.new(matched_link, @wiki)
          "#{line.gsub(matched_link.to_s, link.to_html)}#{render_links_in(matched_link.post_match)}"
        else
          line
        end
      end

      class LinkInContent
        def initialize(link, wiki)
          @link, @wiki = link.to_s, wiki
        end

        def title_of_linked_page
          @link.to_s[1..-2]
        end

        def to_html
          page = @wiki.page_with_title(title_of_linked_page)
          if page.found?
            "<a href=\"/pages/#{page.url}\">#{page.title}</a>"
          else
            @link
          end
        end
      end

    end
  end
end
