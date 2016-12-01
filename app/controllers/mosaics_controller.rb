class MosaicsController < ApplicationController
  before_action :require_login

  def mosaic_params
    params.require(:mosaic).permit(:grid, :steps, :step_counter, :grid_array, :completed, :number_of_colors)
  end
  
  # Show the Mosaic Construction Test
  def index
    @all_colors = Mosaic.colors
    redirect_to :controller => :mosaics, :action => :new and return unless params[:mosaic_id]
    @mosaic = Mosaic.find params[:mosaic_id]
  end
  
  # Create before test and put id into session hash
  def new
    @width = 10
    @height = 8
    @time_total = 30
    render "new" and return if not (params[:width] and params[:height] and params[:time])
    
    @width = params[:width].to_i
    @height= params[:height].to_i
    @time_total = params[:time].to_i
    
    reason = ""
    if @width < 1
      reason = "Width must be positive"
    elsif @height < 1
      reason = "length must be positive"
    elsif @time_total < 1
      reason = "Time limit must be positive"
    end
    
    if reason != ""
      flash[:notice] = "Error: #{reason}"
      render "new" and return
    end
    @mosaic = Mosaic.new
    @mosaic.update_attributes!(:grid => ('transparent ' * @width * @height).strip!, :steps => Array.new, :step_counter => 0, :user => @current_user, :completed => false, :number_of_colors => "0", :width => @width, :height => @height, :time_total => @time_total, :time_left => 60 * @time_total, :time_taken => -1)
    redirect_to :controller => :mosaics, :action => :index, :mosaic_id => @mosaic.id
  end
  
  # Called every 5 seconds OR (hard limit) number of moves
  # used to save latest changes while taking test
  def autosave
    @mosaic = Mosaic.find params[:mosaic_id]
    return if @mosaic.time_taken > -1
    if params[:time_taken]
      @mosaic.update_attributes!({:time_taken => params[:time_taken].to_i, :time_left => -1, :time_submitted => Time.now})
      return
    end
    begin
      index = params[:index].to_i
      tileFrom = params[:tileFrom].to_i
      tileTo = params[:tileTo].to_i
      color = params[:color]
      time_left = params[:time_left].to_i
      @mosaic.steps[index] = {:tileFrom => tileFrom, :tileTo => tileTo, :color => color}
      @mosaic.update_attributes!({:steps => @mosaic.steps, :time_left => time_left})
      
      # Update grid
      if (tileTo >= @mosaic.width * @mosaic.height) || (tileTo < -1) || (tileFrom >= @mosaic.width * @mosaic.height) || (tileFrom < -1)
        flash[:notice] = "Invalid data values"
      else
        newGrid = @mosaic.grid.split
        newGrid[tileFrom] = 'transparent' if tileFrom >= 0
        newGrid[tileTo] = color if tileTo >= 0
        @mosaic.update_attributes!(:grid => newGrid.join(' '))
      end
    rescue
      flash[:notice] = "Invalid data format"
    end
    @mosaic.increment!(:step_counter, :by => 1)
    @mosaic.update_attributes!(:completed => @mosaic.grid.count('#') / @mosaic.width / @mosaic.height)
    @mosaic_colors_info = @mosaic.grid.split(" ").group_by{|e| e}.map{|k, v| [k, v.count]}.to_h
    @mosaic.update_attributes!(:number_of_colors => @mosaic_colors_info.count - 1)
    # @dominant = Hash[@mosaic_colors_info.except!("transparent")]
    # @mosaic.update_attributes!(:dominant_color => @dominant.select {|k,v| v == @dominant.values.max }.keys[0])
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
    
    # filter
    @completed  = convert(params[:completed]  || session[:completed]  || '80-100')
    @numcolors  = convert(params[:numcolors]  || session[:numcolors]  || '5-10')
    @nummoves   = convert(params[:nummoves]   || session[:nummoves]   || '60-120')
    @time_total = convert(params[:time_total] || session[:time_total] || '0-15')
    session[:completed]  = @completed 
    session[:numcolors]  = @numcolors 
    session[:nummoves]   = @nummoves  
    session[:time_total] = @time_total
    
    @APPDATA = {:complete_low => @completed.respond_to?(:first) ? @completed.first : @completed, :complete_high => @completed.respond_to?(:first) ? @completed.last : @completed, :colorcount_low => @numcolors.respond_to?(:first) ? @numcolors.first : @numcolors, :colorcount_high => @numcolors.respond_to?(:first) ? @numcolors.last : @numcolors, :movescount_low => @nummoves.respond_to?(:first) ? @nummoves.first : @nummoves, :movescount_high => @nummoves.respond_to?(:first) ? @nummoves.last : @nummoves, :timetaken_low => @time_total.respond_to?(:first) ? @time_total.first : @time_total, :timetaken_high => @time_total.respond_to?(:first) ? @time_total.last : @time_total}
    puts @APPDATA
    search_params = Hash.new
    search_params[:user_id]    = session[:user_id]
    search_params[:completed]  = @completed
    search_params[:number_of_colors]  = @numcolors
    search_params[:step_counter]   = @nummoves
    search_params[:time_total] = @time_total
    puts "complited range is #{search_params}"
    @mosaics = Mosaic.where(search_params)
    
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
    session.delete(:checked_mosaics)
  end
  
  def download_all
    @mosaics = Mosaic.all
    respond_to do |format|
      format.csv { send_data @mosaics.to_csv, filename: "All_Mosaics-#{Date.today}.csv" }
    end
  end
  
  private
  
  def convert(s)
    s = s.to_s
    @range = s.split('-')
    if not @range[1] or @range[0] == @range[1]
      @range[0].to_i
    elsif @range[1].end_with?('+')
      @range[0].to_i..Float::INFINITY
    else
      @range[0].to_i..@range[1].to_i
    end
  end

  def require_login
    redirect_to :login and return if not session[:user_id] and not Rails.env.test?
  end
end