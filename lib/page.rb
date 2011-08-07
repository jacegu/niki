class Page
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def to_s
    title
  end

  def url
    chunks = title.split(/\s/)
    cleaned_up_chunks = chunks.map{ |c| c.gsub(/\W|_/, '') }
    cleaned_up_chunks.join('-')
  end
end
