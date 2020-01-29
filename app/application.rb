class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.size == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |thing|
          resp.write "#{thing}\n"
        end
      end
    elsif req.path.match(/add/)
      thing = req.params["item"]
      if @@items.include?(thing)
        @@cart << thing
        resp.write "added #{thing}"
      else
        resp.write "We don't have that item."
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
