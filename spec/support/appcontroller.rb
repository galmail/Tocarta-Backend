class ActionView::TestCase 
  class TestController
    def default_url_options(options={})
      { :locale => I18n.locale }
    end
  end
end
