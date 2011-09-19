module Niki
  class PageRequest
    attr_reader :path

    ALL_PAGES_PATH = '/pages'
    DEFAULT_ACTION = :show

    def initialize(path)
      @path = path
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
        return :none
      else
        action = path.gsub(/#{ALL_PAGES_PATH}\/#{page_url}/, '')
        action = action[1..-1] || DEFAULT_ACTION
        return action.to_sym
      end
    end

    def all_pages?
      ALL_PAGES_PATH == path
    end
  end
end
