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
      # I was told to do
      # Content.render @page.content, wiki
      # but I kind of like it better this way
      Content.html_for @page.content, wiki
    end
  end
end
