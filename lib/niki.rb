require 'page'

class Niki
  attr_reader :pages

  def initialize
    @pages = []
  end

  def add_page(page)
    pages << page
  end

  def has_pages?
    pages.any?
  end

  def page_entitled(title)
    pages.select{ |p| p.title == title }.first
  end
end
