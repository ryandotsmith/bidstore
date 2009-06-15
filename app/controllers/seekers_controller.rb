class SeekersController < ApplicationController

  def search
    klass   = params[:scope]
    id      = params[:scope_object]
    object  = klass.constantize.find(id) rescue nil
    object  = nil if params[:scoped] == "universal"
    @results  = Seeker.new( params[:search_q], params[:radius], object ).run()
  end
  
end

