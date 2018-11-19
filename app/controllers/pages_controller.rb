class PagesController < ApplicationController
  include Exceptable
  
  before_action :set_page, only: :show

  # GET /api/pages
  def index
    build do
      message 'Список статических страниц'
      @pages = Page.all
      view 'pages/index'
    end
  end

  # GET /api/pages/1
  def show
    build do
      message 'Статическая страница'
      view 'pages/show'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end
end
