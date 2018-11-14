module Exceptable
  def build
    if block_given?
      begin
        yield
        @status = response.status
        @result = true
        @error = nil

      rescue => ex
        @status = response.status
        @result = nil
        @error = ex.message
      end

      render 'layouts/response'
    end
  end

  def products(products)
    @products = products
  end

  def orders(orders)
    @orders = orders
  end

  def path(path)
    @path = path
  end

  def url_params(url_params = nil)
    @url_params = url_params
  end

  def message(message)
    @message = message
  end

  def view(view)
    @view = view
  end
end