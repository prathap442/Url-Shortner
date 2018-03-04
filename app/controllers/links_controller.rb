class LinksController < ApplicationController
  before_action :authenticate_user!
  def new
  	 @link = Link.new
  end
  
  def index
    @links = current_user.links
  end

  def show
    @link = Link.find_by_encoded_link(params[:encoded_link])
    @link.link_click_count+=1
    @link.update_attributes({link_click_count: @link.link_click_count})
    logcreate
    redirect_to @link.link_name
  end

  def create
    @link = Link.new(link_params)
    @link.link_click_count = 0
    @link.encoded_link = Link.random_link_generator
    respond_to do |format|
	    if((@link.save)&&(current_user.links.pluck(:link_name).include?(@link.link_name)==false))
         UserLink.create({user_id: current_user.id,link_id: @link.id}) 
         format.js
         format.json
  	     format.html{redirect_to link_path(@link.encoded_link),notice: "The link was successfully created"}
	    else
         format.js
	       format.json
	       format.html{render action: "new"}
	    end
    end
  end

  def edit
  	 @link= Link.find(params[:id])
  end

  def update
  	if(@link.update(link_params))
	  	 respond_to do |format|
	  	   format.html{redirect_to links_path,notice: "the link was successfully updated"}
	  	   format.json
	  	 end
  	else
  	  respond_to do |format|
        format.html{render action: 'edit',notice: "the link can't be updated as there are some errrors involved"}
  	    format.json
  	  end
  	end
  end
   
   def destroy
       @link=Link.find(params[:id])
       respond_to {|format| format.js}
       @link.destroy{reditect_to links_path,notice: "the link was successfully destroyed"} 	
   end
# Custom Validation
   def go_to_the_link
       binding.pry
       @link=Link.find(params[:encoded_link])
       redirect_to @link.encoded_link
   end

   def get_my_links
       binding.pry
       @links=Link.where(user_id: current_user.id)
   end    	   
end
private 
  def link_params
      params.require(:link).permit(:link_name,:encoded_link)
  end  

  def logcreate
       dev = Device.find_by(device_name: current_user.email)
        os = OperatingSystem.find_by(name: browser.platform.name)
        if(dev == nil)
           dev = Device.create(device_name: current_user.email)
        end
        if(os == nil)
            os = OperatingSystem.create(name: browser.platform.name)
        end
      Log.create( user_id: current_user.id, operating_system_id: os.id, browser: browser.name, device_id: dev.id, link_id: @link.id )
  end  