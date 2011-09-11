require 'content'

module Niki
  class RenderedPage < Page
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
  end
end
