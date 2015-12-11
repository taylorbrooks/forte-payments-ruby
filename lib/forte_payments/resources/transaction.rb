module FortePayments
  class Client
    module Transaction

      def create_transaction(options = {})
        post("/transactions", options)
      end

      def list_transaction(options = {})
        get("/transactions", options)
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
