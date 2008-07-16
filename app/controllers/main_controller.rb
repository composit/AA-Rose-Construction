class MainController < ApplicationController

  def index
    render :layout => "index"
  end

  def why_own
  end

  def lombard
    render :layout => 'floorplans'
  end

  def cantera
    render :layout => 'floorplans'
  end

  def cantera_site_plan
    render :layout => 'floorplans'
  end

  def cantera_location_plan
    render :layout => 'floorplans'
  end

  def pricing
  end

  def developments
  end

  def tour
  end

  def sample_pricing
    @pricing_name = params[:name]
    render :layout => 'floorplans'
  end

  def send_pdf
    pdf = "#{RAILS_ROOT}/public/images/" + params[:name] + ".pdf"
    send_file pdf if pdf
  end

end
