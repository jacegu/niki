require 'niki/content'
require 'niki/page'

module Niki
  class PageHtml < Page
    attr_reader :page, :wiki

    def initialize(page_to_render, wiki)
      @page, @wiki = page_to_render, wiki
    end

    def title
      @page.title
    end

    def url
      @page.url
    end

    def content
      Content.to_html @page.content, wiki
    end
  end
end
