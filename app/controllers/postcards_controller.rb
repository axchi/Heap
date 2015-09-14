class PostcardsController < ApplicationController
   LOB = Lob.load(api_key: ENV['LOB_ACCESS_KEY_ID'])
  def index
  end
  
  def create
    template_file = ERB.new(File.open(File.join(Rails.root, 'app', 'views', 'postcards', 'postcard_front.html.erb')).read)
        custom_html = template_file.result(binding)

        @results = LOB.postcards.create(
      
          description: "Demo Postcard job", 
          to: {
            name: params[:postcards][:to_name],
            address_line1: params[:postcards][:to_address_line1],
            address_city: params[:postcards][:to_city],
            address_state: params[:postcards][:to_state],
            address_zip: params[:postcards][:to_zip],
            address_country: "US",
          },
          from: {
            name: params[:postcards][:from_name],
            address_line1: params[:postcards][:from_address_line1],
            address_city: params[:postcards][:from_city],
            address_state: params[:postcards][:from_state],
            address_zip: params[:postcards][:from_zip],
            address_country: "US",
          },
          front: custom_html,
          back: "<html style='padding: 1in; font-size: 20;'>Back HTML for #{params[:postcards][:to_name]}</html>",
          data: {
            name:  params[:postcards][:to_name]
          }
        )
  end
end