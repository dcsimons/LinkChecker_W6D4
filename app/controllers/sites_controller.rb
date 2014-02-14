class SitesController < ApplicationController
  def new
    @site = Site.new
    respond_to do |f|
      f.html
      f.json { render :json => @site, status: "404" }
    end
  end

  def create
    url = params.require(:site)[:url]
    @site = Site.create(url: url)
    LinksWorker.perform_async(@site.id)
    respond_to do |f|
      f.html { redirect_to site_path(@site) }
      f.json { render :json => @site }
    end
  end

  def show
    @site = Site.find(params[:id])

    @links = @site.links
    respond_to do |f|
      f.html
      f.json { render :json => @site.as_json(include: :links) }
    end
  end

  def linkfarm
    @sites = Site.all

    respond_to do |f|
      f.html
      f.json { render :json => @sites.as_json(include: :links) }
    end
  end

  def edit
    @site = Site.find(params[:id])
    respond_to do |f|
      f.html
      f.json { render :json => @site.as_json(include: :links), status: "404" }
    end
  end

  def update

  end

  def destroy
    site = Site.find(params[:id])
    site.destroy
    respond_to do |f|
      f.html { redirect_to new_site_path }
      f.json { render :json => site, status: "200" }
    end
  end

  rescue_from ActionController::ParameterMissing, :only => :create do |err|
    respond_to do |f|
      f.html do 
        redirect_to new_site_path
      end
      f.json {render :json  => {:error => err.message}, :status => 422}
    end
  end

  # rescue_from ActionController::ParameterMissing, :handle_create_param_missing :only => :create
  #
  # def handle_create_param_missing
  #    respond_to do |f|
  #     f.html do 
  #       redirect_to new_site_path
  #     end
  #     f.json {render :json  => {:error => err.message}, :status => 422}
  #   end
  # #
end
