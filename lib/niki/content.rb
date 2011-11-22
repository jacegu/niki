require 'erb'

module Niki
  class Content

    def initialize(content, wiki)
      @content, @wiki = content, wiki
    end

    def to_html
      non_empty_lines.map{ |line| Paragraph.new(line, @wiki).render }.join("\n")
    end

    def non_empty_lines
      @content.split(/\n|\r/m).reject{ |line| line.strip.empty? }
    end
  end

  class Paragraph
    include ERB::Util

    def initialize(text, wiki)
      @text, @wiki = text, wiki
    end

    def render
      "<p>#{render_links_in(html_escape(@text))}</p>"
    end

    def render_links_in(paragraph)
      return replace_link_in(paragraph) if link_in(paragraph)
      paragraph
    end

    def link_in(paragraph)
      paragraph.match(Link::AS_REGEXP)
    end

    def replace_link_in(line)
      link = link_in(line)
      "#{link.pre_match}#{Link.new(link, @wiki)}#{render_links_in(link.post_match)}"
    end
  end

  class Link
    AS_REGEXP = /\[([a-z]|[0-9]|\s)+\]/i

    def initialize(link, wiki)
      @link, @wiki = link.to_s, wiki
    end

    def to_s
      return html_link_to_linked_page if linked_page.found?
      @link
    end

    private

    def linked_page
      @wiki.page_with_title(title_of_linked_page)
    end

    def title_of_linked_page
      @link.to_s[1..-2]
    end

    def html_link_to_linked_page
      "<a href=\"/pages/#{linked_page.url}\">#{linked_page.title}</a>"
    end
  end

end
