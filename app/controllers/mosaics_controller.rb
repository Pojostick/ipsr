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
      flash[:notice] = "No ID detected! "
      flash.keep
      redirect_to :controller => :mosaics, :action => :new and return
    end
    @mosaic = Mosaic.find params[:mosaic_id]
  end
  
  # Create before test and put id into session hash
  def new
    @mosaic = Mosaic.new
    @mosaic.update_attributes!(:grid => ('transparent ' * 80).strip!, :steps => '')
    if flash[:notice]
      flash[:notice] += "Created test ##{@mosaic.id}"
    else
      flash[:notice] = "Created test ##{@mosaic.id}"
    end
    flash.keep
    redirect_to :controller => :mosaics, :action => :index, :mosaic_id => @mosaic.id
  end
  
  # Called every 5 seconds OR (hard limit) number of moves
  # used to save latest changes while taking test
  def autosave
    @mosaic = Mosaic.find params[:mosaic_id]
    timestamp = params[:time]
    tileId = params[:tileId]
    color = params[:color]
    # Append to steps
    @mosaic.update_attributes!(:steps => @mosaic.steps + "#{timestamp} #{tileId} #{color},")
    # Update grid
    if tileId && tileId.to_i < 80
      newGrid = @mosaic.grid.split
      newGrid[tileId.to_i] = color
      @mosaic.update_attributes!(:grid => newGrid.join(' '))
    end
    flash[:notice] = @mosaic.grid
    @all_colors = Mosaic.colors
    render "index"
  end
  
  def show
    @mosaic = Mosaic.find(params[:id])
  end
  
  def gallery
<<<<<<< HEAD
    # renders the collection of galleries to be viewed by researchers
  end
  
  def download
    # downloads the selected mosaic and stays on the same page
    redirect_to action: "show", id: params[:id]
=======
>>>>>>> master
  end
end
