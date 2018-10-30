module Exceptable
  def build
    if block_given?
      begin
        @page = Page.where(name: 'about').first

        @status = response.status
        @message = 'Страница "О нас"'
        @result = true
        @error = nil

      rescue => ex
        @result = nil
        @error = ex.message
      end

      @view = 'pages/about'
      render 'layouts/response'
    end
  end
end