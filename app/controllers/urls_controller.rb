class UrlsController < ApplicationController
  def index
    @pagy, @urls = pagy(Url.order(created_at: :desc).all, items: 10)
  end

  def show
    render locals: { url: }
  end

  def create
    @url = Url.new(url_params)

    if @url.save
      redirect_to root_path, notice: 'Url was successfully created.'
    else
      redirect_to root_path, notice: 'Url was not created.'
    end
  end

  def redirect
    redirect_url.clicks.create(ip_address: request.remote_ip)
    redirect_to redirect_url.original, allow_other_host: true
  end

  private

  def url
    @url ||= Url.find_by(id: params[:id])
  end

  def redirect_url
    @redirect_url ||= Url.find_by!(shortened: params[:shortened])
  end

  def url_params
    params.require(:url).permit(:original)
  end
end
