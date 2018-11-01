module Paginable
  def paginate(options)
    per_page = 3
    @products = options[:items].page(params[:page]).per(per_page)
    total_pages = (options[:items].count / per_page).ceil
    current_page = params[:page] ? params[:page].to_i : 1
    path_params = options[:params].nil? ? nil : options[:params].map { |key, value| "#{key}=#{value}" }.to_a.join('&')

    @pagination = {
        "current_page": current_page,
        "first_page": 1,
        "last_page": total_pages,
        "prev_page_url": current_page != 1 ? "#{options[:path]}?#{path_params}&page=#{current_page - 1}" : nil,
        "next_page_url": current_page != total_pages ? "#{options[:path]}?#{path_params}&page=#{current_page + 1}" : nil
    }
  end
end