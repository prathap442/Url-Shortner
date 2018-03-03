class OssController < ApplicationController
  def new
    @os = Os.new
  end

  def index
  	@oss = Os.all
  end
  
  def create
    @os = Os.new(os_params)
    respond_to do |format|
	    if(@os.save)
	        format.html{redirect_to oss_path,notice: "Welcome to the Oss that we deal"}
	    else
	        format.html{render action: "new"}
	    end
    end
  end 	
end
