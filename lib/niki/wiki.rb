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
      page_with(title: title).found?
    end

    def has_a_page_with_url?(url)
      page_with(url: url).found?
    end

    def page_with_title(title)
      page_with(title: title)
    end

    def page_with(data)
      pages.select(&Criteria.with(data)).first || NullPage.new
    end

  end

  class Criteria
    attr_reader :field, :value

    def self.with(page_info)
      new(page_info).build_proc
    end

    def initialize(page_info)
      @field = page_info.keys.first
      @value = page_info[field].gsub("'", "\\'")
    end

    def build_proc
      Proc.new { |p| eval "p.#{@field} == '#{@value}'" }
    end
  end
end
