module Niki
  class Page
    attr_accessor :title, :content

    def self.with(title, content)
      page = Page.new(title)
      page.content = content
      return page
    end

    def initialize(title)
      @title = title
      @content = ''
    end

    def url
      chunks = title.downcase.split(/\s/)
      alphanumeric_chunks = chunks.map{ |c| c.gsub(/\W|_/, '') }
      alphanumeric_chunks.join('-')
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
