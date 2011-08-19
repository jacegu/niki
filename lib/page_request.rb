class PageRequest
  attr_reader :path

  ALL_PAGES_PATH = '/pages'

  def initialize(path)
    @path = path
  end

  def all_pages?
    ALL_PAGES_PATH == path
  end

  def page_url
    if all_pages?
      ''
    else
      path.gsub("#{ALL_PAGES_PATH}/", '')
    end
  end
end
