require 'niki/content'

module Niki
  class RenderedPage < Page
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
      Content.new(@page.content, wiki).to_html
    end
  end
end
