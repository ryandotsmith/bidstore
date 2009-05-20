class SettingsController < ApplicationController

  # since the restful routing likes to grab an id from the passing object
  # i.e. The edit_setting_path(@settings) method would call @settings.id
  # So this is why we give an arbitrary integer to the struct.
  
  # We also load up all of the definable settings for the system. 
  # If you add a new customizable settings table; say "AlienFleshTypes"
  # then you would need to update the settings controller. . . .right here! 
  def index
    @settings  = Struct.new(:id, :hash).new( 42, Hash.new )
    #@settings.hash[:trailer_types]    = TrailerTypes.find(:all)
    #@settings.hash[:price_mode_types] = PriceModeTypes.find(:all)
  end 
  
  def edit 
      
  end
  
  def update

  end


end
