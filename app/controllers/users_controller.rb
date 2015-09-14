class UsersController < ApplicationController
  
  require 'aws-sdk'
 
  def index
    @users = User.all
    
  end
  
  def new
    @user=User.new
    params[:name]='diana'
    params[:image]='larkspur-flowers-584816.jpg'
    puts "////////"
   
    
  end
  
  def images
    s3 =Aws::S3::Client.new(
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      region:'us-east-1')
      
      s3.list_objects(bucket:'afterschoolprogram').each do |response|
       @images = response.contents.map(&:key)
      end
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render "new"
    end
  end
  
  
  def html_template(size, params)
    render_to_string(:action => "users/template_#{size}", :layout => false)
  end
  
  def template(name, image)
    render_to_string(:action => "front_template.html.slim", :layout => false)
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :message)
  end
end