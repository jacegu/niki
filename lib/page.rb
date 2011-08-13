class Page
  include Comparable

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

  def to_s
    title
  end

  def url
    chunks = title.split(/\s/)
    cleaned_up_chunks = chunks.map{ |c| c.gsub(/\W|_/, '') }
    cleaned_up_chunks.join('-')
  end

  def <=>(other)
    title <=> other.title
  end
end
