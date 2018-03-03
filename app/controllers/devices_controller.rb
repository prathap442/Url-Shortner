class DevicesController < ApplicationController

def new
  @device = Device.new
end

def index
  @devices = Device.all
end	

def create
   @device = Device.new(device_params) 
   respond_to do |format|
	   if @device.save  
	   	   format.json
	   	   format.html{redirect_to devices_path,notice: "the new device record is succesfylly created"}
	   else
	   	   format.json
	   	   format.html
	   	   render action: 'new'
	   end
   end
end

def edit
   @device = Device.find(params[:id])
end


def update
   @device = Device.new(device_params)
   @device = @device.update_attributes(device_params)
   respond_to do |format| 
    if(@device.save)
       format.json
       format.html{redirect_to devices_path,notice: "The devicce was successfully updated"}	 
   	   redirect_to device_path(@device.id)
   	else
   		format.json
   		format.html{render action: 'edit'}
   		render action: 'edit'
    end
end



def destroy
	@device = Device.find(params[:id])
	if(@device.destroy)
		  redirect_to links_path{notice: "the link was successfully destroyed"}
    end
end    		  
private 
   def device_params
      params.require(:device).permit(:name)
   end	