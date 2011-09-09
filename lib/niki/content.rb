module Niki
  class RenderedPage
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
          link = Link.new(matched_link, @wiki)
          "#{line.gsub(matched_link.to_s, link.to_html)}#{render_links_in(matched_link.post_match)}"
        else
          line
        end
      end
    end

    class Link
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
