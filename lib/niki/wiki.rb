# encoding:utf-8
require 'niki/page'

module Niki
  class Wiki
    attr_reader :pages

    def self.with(pages)
      new(pages)
    end

    def initialize(pages = [])
      @pages = pages
    end

    def publish(page)
      pages << page
    end

    def has_any_pages?
      pages.any?
    end

    def has_a_page_with?(data)
      page_with(data).found?
    end

    def page_with(data)
      find_page_with(data) || NullPage.new
    end

    private

    def find_page_with(data)
      pages.select(&Criteria.for(data)).first
    end

    class Criteria
      def self.for(page_info)
        new(page_info).build_proc
      end

      def initialize(page_info)
        @field = page_info.keys.first
        @value = page_info[@field].gsub("'", "\\'")
      end

      def build_proc
        Proc.new { |p| eval "p.#{@field} == '#{@value}'" }
      end
    end

  end
end
