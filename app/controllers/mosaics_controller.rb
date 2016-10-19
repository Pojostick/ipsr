class MosaicsController < ApplicationController
  
  def mosaic_params
    params.require(:mosaic).permit(:grid, :steps)
  end
  
  # Show the Mosaic Construction Test
  def index
    # If cookie does not exist, then redirect to survey page
    # or create a modal dialogue with partial render
    @all_colors = Mosaic.colors
    unless params[:mosaic_id]
      # Create a new mosaic and retrieve id
      flash[:notice] = "No ID found"
      params[:mosaic_id] = 1
    end
    @mosaic = Mosaic.find params[:mosaic_id]
  end
  
  # Create before test and put id into session hash
  def new
    @mosaic = Mosaic.new
    @mosaic.update_attributes!(:grid => ('transparent ' * 80).strip!)
    redirect_to '/mosaics'
  end
  
  # Called every 5 seconds OR (hard limit) number of moves
  # used to save latest changes while taking test
  def autosave
    @id = params[:mosaic_id]
    # Append to steps
    # Update grid
    render :nothing
  end
  
  def show
    @mosaic = Mosaic.find(params[:id])
  end

end
