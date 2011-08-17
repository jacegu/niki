class PageRequest
  attr_reader :path

  ALL_PAGES_PATH = '/pages'

  def initialize(path)
    @path = path
  end

  def all_pages?
    path == ALL_PAGES_PATH or path == "#{ALL_PAGES_PATH}/"
  end
end
