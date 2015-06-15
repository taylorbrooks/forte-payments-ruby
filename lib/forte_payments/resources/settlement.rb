module FortePayments
  class Client
    module Settlement

      def list_settlements(options = {})
        get("/settlements/", options)
      end

      def find_settlement_by_transaction_id(transaction_id)
        get("/transactions/#{transaction_id}/settlements")
      end

    end
  end
end
