require 'pry'

class Application
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # if path begins with /items/
    if req.path.match(/items/)
      #puts "DEBUG: /items/ path found"
      # get what comes after "/items/"
      item_name = req.path.split("/items/").last
      # see if it's contained in @@items

      item = @@items.find do |i|
        i.name == item_name
      end
      #binding.pry
      if item
        #binding.pry
        #puts "DEBUG: @@items: #{@@items} includes #{item}"
        
        resp.write "#{item.price}"
        resp.status = 200
      else
        #puts "DEBUG: @@items: #{@@items} does not include #{item}"
         
        resp.write "Item not found"
        resp.status = 400
      end
    else
      #puts "DEBUG: bad path"
      
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end