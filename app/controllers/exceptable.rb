module Exceptable
  def build
    if block_given?
      begin
        yield
        @status = response.status
        @result ||= true
        @error ||= nil

      rescue => ex
        @status = response.status
        @result = nil
        @error = ex.message
      end

      render "layouts/response", formats: :json
    end
  end

  def result(result)
    @result = result
  end

  def error(error)
    @error = error
  end

  def products(products)
    @products = products
  end

  def orders(orders)
    @orders = orders
  end

  def order(order)
    @order = order
  end

  def producers(producers)
    @producers = producers
  end

  def consumers(consumers)
    @consumers = consumers
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