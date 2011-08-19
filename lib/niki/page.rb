module Niki
  class Page
    attr_reader :title
    attr_accessor :content

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

    def to_s
      title
    end
  end
end