class Link < ApplicationRecord
  has_many :user_links
  has_many :users, through: :user_links
  before_validation :check_whether_the_url_already_exists
  validates_presence_of :link_name,:encoded_link
  validates_uniqueness_of :encoded_link
  
  def check_whether_the_url_already_exists
    url_link = Link.find_by_link_name(self.link_name)
    binding.pry
    if !(url_link.nil?)
       binding.pry
       self.errors.add(:link_name,"name already exists")  
       self.link_click_count = 0
    end  
  end  
  def self.random_link_generator
     encoded_link = ""
     4.times do
       encoded_link+=(48..57).to_a.sample.chr
     end
     4.times do 
     	 encoded_link+=(97..122).to_a.sample.chr
     end	  
     encoded_link = encoded_link.split("")
     encoded_link=encoded_link.permutation.to_a(encoded_link.length).sample.join("")
     return encoded_link
  end

end