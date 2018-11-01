module Paginable
  def paginate(items_all)
    per_page = 3
    result = items_all.page(params[:page]).per(per_page)
    total_pages = (items_all.count / per_page).ceil
    current_page = params[:page] ? params[:page].to_i : 1
    url_params = @url_params.nil? ? nil : @url_params.map { |key, value| "#{key}=#{value}" }.to_a.join('&')

    @pagination = {
      "current_page": current_page,
      "first_page": 1,
      "last_page": total_pages,
      "prev_page_url": current_page != 1 ? "#{@path}?#{url_params}&page=#{current_page - 1}" : nil,
      "next_page_url": current_page != total_pages ? "#{@path}?#{url_params}&page=#{current_page + 1}" : nil
    }
    result
  end
end