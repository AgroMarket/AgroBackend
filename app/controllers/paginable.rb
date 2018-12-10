module Paginable
  def paginate(items_all)
    # puts "items_all #{items_all.size}"
    per_page = 8
    # puts "per_pate #{per_page}"
    result = items_all.page(params[:page]).per(per_page)
    # puts "result #{result.size}"
    total_pages = (items_all.count.to_f / per_page.to_f).ceil
    # puts "total_pages #{total_pages}"
    current_page = params[:page] ? params[:page].to_i : 1
    url_params = @url_params.nil? ? nil : @url_params.map { |key, value| "#{key}=#{value}" }.to_a.join('&')

    @pagination =
      if items_all.size > per_page
        { "current_page": current_page,
          "first_page": 1,
          "last_page": total_pages,
          "prev_page_url": current_page <= 1 ? nil : "#{@path}?#{url_params}&page=#{current_page - 1}",
          "next_page_url": current_page >= total_pages ? nil : "#{@path}?#{url_params}&page=#{current_page + 1}" }
      else
        nil
      end
    result
  end
end