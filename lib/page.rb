class Page
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def to_s
    title
  end
end
