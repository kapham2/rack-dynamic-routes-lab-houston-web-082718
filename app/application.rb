class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        # Your application should only accept the /items/<ITEM NAME> route.
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last

            item_instance = @@items.find do |item|
                item.name == item_name
            end

            # If a user requests /items/<Item Name> it should return the price of that item
            if item_instance != nil
                resp.write item_instance.price

            # IF a user requests an item that you don't have, then return a 400 and an error message
            else
                resp.status = 400
                resp.write "Item not found"
            end

        # Everything else should 404
        else
            resp.status = 404
            resp.write "Route not found"
        end

        resp.finish

    end

end