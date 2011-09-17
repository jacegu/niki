require 'erb'

module Niki
  class Content
    include ERB::Util

    def initialize(content, wiki)
      @content, @wiki = content, wiki
    end

    def to_html
      @content.split("\n").map do |line|
        render_paragraph_in(render_links_in(html_escape(line)))
      end.join("\n")
    end

    private

    def render_paragraph_in(line)
      if line.empty?
        ""
      else
        "<p>#{line}</p>"
      end
    end

    def render_links_in(line)
      if link = line.match(Link::AS_REGEXP)
        "#{link.pre_match}#{Link.new(link, @wiki)}#{render_links_in(link.post_match)}"
      else
        line
      end
    end
  end

  class Link
    AS_REGEXP = /\[([a-z]|[0-9]|\s)+\]/i

    def initialize(link, wiki)
      @link, @wiki = link.to_s, wiki
    end

    def title_of_linked_page
      @link.to_s[1..-2]
    end

    def to_s
      page = @wiki.page_with_title(title_of_linked_page)
      if page.found?
        "<a href=\"/pages/#{page.url}\">#{page.title}</a>"
      else
        @link
      end
    end
  end

end
