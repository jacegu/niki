#encoding: utf-8

module Niki
  class Page
    attr_accessor :title, :content

    def self.with(title, content)
      Page.new(title, content)
    end

    def initialize(title, content= '')
      @title, @content = title, content
    end

    def url
      transform_title_into_url_path
    end

    def found?
      true
    end

    def to_s
      title
    end

    def self.would_be_valid_with_title?(title)
      not title.nil? and not title.strip.empty?
    end

    private
    def transform_title_into_url_path
      split_title.map{ |chunk| chunk.gsub(/[^a-zñ0-9]/, '') }.join('-')
    end

    def split_title
      @title.downcase.gsub(/Ñ/, 'ñ').split(/\s/)
    end
  end

  class NullPage < Page
    def initialize
      @title = ''
    end

    def found?
      false
    end
  end
end
