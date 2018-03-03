class LogsController < ApplicationController
  def new 
  	@log=Log.new
  end

  def index
    @logs = Log.all
  end

  def show
    @log = Log.find(params[:id])
  end

  def create 
  	@log = Log.find(params[:id])
  	respond_to do |format|
	  	if(@log.save)
	  	   format.json	
	  	   format.html{notice: "the log was successfully created"}
	  	else
	  		format.json
	  		format.html{render action: "new",notice: "there are some errors in the log creation"}
	  	end	
    end 
  end

  def edit
    @log=Log.find(params[:id])
  end

  def update
    if(@log.update(log_params))
	    respond_to do |format|
		    if(@log.save)
		      format.html{redirect_to logs_path,notice: "The log is successfully created"} 
		      format.json
		    else
		      format.json	
		      format.html{render action: "new"}
		    end
	    end
    end 	
  end

  def destroy
  	 @log=Log.find(params[:id])
     @log.destroy
     redirect_to logs_path
  end 
end
