class LinksController < ApplicationController
  before_action :authenticate_user!,except: [:new]
  def new
  	 @link = Link.new
  end
  
  def index
    @links = current_user.links
  end

  def show
    @link  = Link.find_by_encoded_link(params[:encoded_link])
    @link.link_click_count+=1
    @link.update_attributes({link_click_count: @link.link_click_count})
    redirect_to @link.link_name
  end

  def create
    @link = Link.new(link_params)
    @link.encoded_link = Link.random_link_generator
    binding.pry
    respond_to do |format|
	    if((@link.save)&&(!current_user.links.pluck(:link_name).include?(@link.link_name)))
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
       @link.destroy{reditect_to links_path,notice: "the link was successfully destroyed"} 	
   end
# Custom Validation
   def go_to_the_link
       @link=Link.find(params[:encoded_link])
       redirect_to @link.encoded_link
   end	   
end
private 
  def link_params
      params.require(:link).permit(:link_name,:encoded_link)
  end  