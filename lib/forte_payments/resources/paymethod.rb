module FortePayments
  class Client
    module Paymethod

      def create_paymethod(customer_id, options = {})
        post("/customers/#{customer_id}/paymethods", options)
      end

      def list_paymethods(customer_id, options = {})
        get("/customers/#{customer_id}/paymethods", options)
      end

      def find_paymethod(customer_id, paymethod_id, options = {})
        get("/customers/#{customer_id}/paymethods/#{paymethod_id}", options)
      end

      def update_paymethod(customer_id, paymethod_id, options = {})
        put("/customers/#{customer_id}/paymethods/#{paymethod_id}", options)
      end

      def delete_paymethod(paymethod_id)
        delete("/paymethods/#{paymethod_id}")
      end

    end
  end
end
