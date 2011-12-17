# encoding:utf-8
require 'niki/page'

module Niki
  class Wiki
    attr_reader :pages

    def initialize(pages = [])
      @pages = pages
    end

    def publish(page)
      pages << page
    end

    def has_any_pages?
      pages.any?
    end

    def has_a_page_entitled?(title)
      page_with_title(title).found?
    end

    def has_a_page_with_url?(url)
      page_with_url(url).found?
    end

    def page_with_url(url)
      find_page_by{ |p| p.url == url }
    end

    def page_with_title(title)
      find_page_by{ |p| p.title == title }
    end

    def find_page_by(&criteria)
      pages.select(&criteria).first || NullPage.new
    end
  end
end
