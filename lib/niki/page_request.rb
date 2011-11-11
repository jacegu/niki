module Niki
  class PageRequest
    attr_reader :path

    ALL_PAGES_PATH = '/pages'
    DEFAULT_ACTION = :show

    def initialize(path)
      @path = path
    end

    def page_url
      return page_path unless all_pages?
      return ''
    end

    def action
      return :none if all_pages?
      return action_to_sym
    end

    def all_pages?
      ALL_PAGES_PATH == path
    end

    private
    def action_to_sym
      action = url_action[1..-1] || DEFAULT_ACTION
      return action.to_sym
    end

    def url_action
      path.gsub(/#{ALL_PAGES_PATH}\/#{page_url}/, '')
    end

    def url_with_action
      path.gsub("#{ALL_PAGES_PATH}/", '')
    end

    def page_path
      url_with_action.gsub(/\/.+$/,'')
    end
  end
end
