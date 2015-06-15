module FortePayments
  class Client
    module Transaction

      def create_transaction(customer_id, options = {})
        post("/transactions/#{customer_id}/addresses", options)
      end

      def list_transaction(customer_id, options = {})
        get("/transactions/#{customer_id}/addresses", options)
      end

      def find_transaction(transaction_id, options = {})
        get("/transactions/#{transaction_id}", options)
      end

      def update_transaction(transaction_id, options = {})
        put("/transactions/#{transaction_id}", options)
      end

    end
  end
end
