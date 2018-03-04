module LinksHelper
	def logcreate
	   binding.pry	
       dev = Device.find_by(device_name: browser.device.name)
       os = OperatingSystem.find_by(name: browser.platform.name)
       binding.pry
       if(dev == nil)
          dev = Device.create(device_name: browser.device.name)
       end
       if(os == nil)
           os = OperatingSystem.create(name: os.name)
       end
     binding.pry  
     Log.create(user_id: current_user.id,operating_system_id: os.id,browser: browser.name, device: dev.id )
     binding.pry		
    end 
end
