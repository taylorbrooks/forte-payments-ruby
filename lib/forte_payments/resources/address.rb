module FortePayments
  class Client
    module Address

      def create_address(customer_id, options = {})
        post("/customers/#{customer_id}/addresses", options)
      end

      def list_addresses(customer_id, options = {})
        get("/customers/#{customer_id}/addresses", options)
      end

      def find_address(customer_id, options = {})
        get("/customers/#{customer_id}/addresses", options)
      end

      def update_address(customer_id, options = {})
        put("/customers/#{customer_id}/addresses/#{address_id}", options)
      end

      def delete_address(customer_id, address_id)
        delete("/customers/#{customer_id}/addresses/#{address_id}")
      end

    end
  end
end
