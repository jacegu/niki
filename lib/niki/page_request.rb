module Niki
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
        return ''
      else
        url_and_action = path.gsub("#{ALL_PAGES_PATH}/", '')
        url_only = url_and_action.gsub(/\/.+$/,'')
        return url_only
      end
    end

    def action
      if all_pages?
        :none
      else
        path.gsub(/#{ALL_PAGES_PATH}\/#{page_url}\//, '').to_sym
      end
    end
  end
end
