class MosaicsController < ApplicationController
  
  def mosaic_params
    params.require(:mosaic).permit(:grid, :steps, :step_counter, :grid_array, :completed, :number_of_colors, :dominant_color)
  end
  
  # Show the Mosaic Construction Test
  def index
    # If cookie does not exist, then redirect to survey page
    # or create a modal dialogue with partial render
    if !current_user && !Rails.env.test?
      redirect_to :login and return
    end
    @all_colors = Mosaic.colors
    unless params[:mosaic_id]
      # Create a new mosaic and retrieve id
      flash[:notice] = "No ID detected! "
      flash.keep
      redirect_to :controller => :mosaics, :action => :new and return
    end
    @mosaic = Mosaic.find params[:mosaic_id]
    # @scratchpad = ('transparent ' * 16)
  end
  
  # Create before test and put id into session hash
  def new
    @mosaic = Mosaic.new
    @mosaic.update_attributes!(:grid => ('transparent ' * 80).strip!, :steps => Array.new, :step_counter => 0, :grids => Array.new, :user_id => session[:user_id], :completed => false, :number_of_colors => "0", :dominant_color => "transparent")
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
    if @mosaic.time_taken
      return
    end
    time_taken = params[:time_taken]
    if time_taken
      @mosaic.update_attributes!({:time_taken => time_taken, :time_left => 0, :time_submitted => Time.now})
      return
    end
    begin
      index = params[:index].to_i
      tileFrom = params[:tileFrom]
      tileTo = params[:tileTo]
      color = params[:color]
      @mosaic.steps[index] = {:tileFrom => tileFrom, :tileTo => tileTo, :color => color}
      @mosaic.update_attributes!(:steps => @mosaic.steps)
      # Update grid
      if (tileTo && tileTo.to_i < 80) && (tileTo && tileTo.to_i >= 0)
        newGrid = @mosaic.grid.split
        newGrid[tileTo.to_i] = color
        @mosaic.update_attributes!(:grid => newGrid.join(' '))
        @mosaic.update_attributes!(:grids => @mosaic.grids.push(newGrid.join(' ')))
      end
      flash[:notice] = @mosaic.grid
    rescue
      flash[:notice] = "Invalid data"
    end
    @mosaic.increment!(:step_counter, by = 1)
    if @mosaic.grid.exclude?("transparent")
      @mosaic.update_attributes!(:completed => true)
    end
    @mosaic_colors_info = @mosaic.grid.split(" ").group_by{|e| e}.map{|k, v| [k, v.count]}.to_h
    @mosaic.update_attributes!(:number_of_colors => @mosaic_colors_info.count - 1)
    @dominant = Hash[@mosaic_colors_info.except!("transparent")]
    @mosaic.update_attributes!(:dominant_color => @dominant.select {|k,v| v == @dominant.values.max }.keys[0])
    @all_colors = Mosaic.colors
    render "index"
  end
  
  def show
    @mosaic = Mosaic.find(params[:id])
    if @mosaic.user_id != session[:user_id]
      render :text => "<html>You do not have permissions to view this mosaic.</html>".html_safe
    end
  end
  
  def gallery
    # renders the collection of galleries to be viewed by researchers
    if !params[:checked].nil?
      # @checked_mosaics = params[:checked].split(" ").map { |s| s.to_i }
      @checked_mosaics = params[:checked]
    else
      @checked_mosaics = " "
    end
    if params[:completed]
      if params[:completed] == 'true'
        @check = true
      else
        @check = false
      end
      @mosaics = Mosaic.where(completed: @check, :user =>  session[:user_id])
    elsif params[:numcolors]
      @mosaics = Mosaic.where(step_counter: params[:numcolors], :user =>  session[:user_id])
    elsif params[:nummoves]
      @movenum = params[:nummoves]
      if @movenum.length == 1
        @mosaics = Mosaic.where(step_counter: 0, :user => session[:user_id])
      elsif @movenum.length == 3
        @mosaics = Mosaic.where("step_counter > ?", 100, :user => session[:user_id])
      else
        @range = @movenum.split(' - ')
        @mosaics = Mosaic.where(:step_counter => @range[0]..@range[1], :user => session[:user_id])
      end
    elsif params[:dominant]
      @mosaics = Mosaic.where(dominant_color: params[:dominant], :user => session[:user_id])
    else
    @mosaics = Mosaic.where(:user => session[:user_id])
    end
    session[:checked_mosaics] = @checked_mosaics.split(" ").map { |s| s.to_i }.uniq
    @mosaics = @mosaics.paginate(:page => params[:page], per_page: 9)
  end
  
  def download_gallery
    if params[:mosaics].nil?
      redirect_to gallery_path
      return
    end
    # @mosaics = Mosaic.where(id: params[:mosaics].keys)
    # puts "this is checked id : #{session[:checked_mosaics]}"
    @mosaics = Mosaic.where(id: session[:checked_mosaics] + params[:mosaics].keys)
    respond_to do |format|
      format.csv { send_data @mosaics.to_csv, filename: "Mosaics-#{Date.today}.csv" }
    end
    session.clear
  end
  
  def download_all
    @mosaics = Mosaic.all
    respond_to do |format|
      format.csv { send_data @mosaics.to_csv, filename: "All_Mosaics-#{Date.today}.csv" }
    end
  end
end

