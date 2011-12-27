require 'erb'

module Niki
  class Content
    def self.html_for(content, wiki)
      new(content, wiki).html
    end

    def initialize(content, wiki)
      @content, @wiki = content, wiki
    end

    def html
      paragraphs.map{ |p| Paragraph.html_for p, @wiki }.join("\n")
    end

    def paragraphs
      lines_with_content
    end

    private

    def lines_with_content
      @content.split(/\n|\r/m).reject{ |line| line.strip.empty? }
    end
  end

  class Paragraph
    include ERB::Util

    def self.html_for(text, wiki)
      new(text, wiki).html
    end

    def initialize(text, wiki)
      @text, @wiki = text, wiki
    end

    def html
      "<p>#{replace_link_placeholder_in(html_escape(@text))}</p>"
    end

    private

    def replace_link_placeholder_in(text)
      return replace_link_in(text) if link_in(text)
      text
    end

    def link_in(text)
      text.match(Link::AS_REGEXP)
    end

    def replace_link_in(line)
      link = link_in(line)
      "#{link.pre_match}#{Link.new(link, @wiki)}#{replace_link_placeholder_in(link.post_match)}"
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
      @wiki.page_with(title: title_of_linked_page)
    end

    def title_of_linked_page
      @link.to_s[1..-2]
    end

    def html_link_to_linked_page
      "<a href=\"/pages/#{linked_page.url}\">#{linked_page.title}</a>"
    end
  end

end
