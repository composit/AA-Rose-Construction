class MainController < ApplicationController
  def index
    render :layout => "index"
  end

  def cost
  end

  def advantages
  end

  def lombard
    render :layout => 'floorplans'
  end

  def cantera
    render :layout => 'floorplans'
  end

  def cantera_floor_plan
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
    #send_file( "#{RAILS_ROOT}/public/images/#{params[:name]}.pdf", :type => "application/pdf", :disposition => "attachment" )
    redirect_to "/images/#{params[:name]}.pdf"
  end

  def more_info
  end
end
