require_relative 'logger_module'

class Bank
  def process_transactions(transactions)
    raise NotImplementedError, 'Subclasses must implement process_transactions'
  end
end

class CBABank < Bank
  include Logger

  def initialize(users)
    @users = users
  end

  def process_transactions(transactions, &callback)
    transaction_descriptions = transactions.map(&:to_s).join(', ')

    log_info("Processing Transactions #{transaction_descriptions}...")

    transactions.each do |transaction|
      user = transaction.user
      value = transaction.value

      unless @users.include?(user)
        message = "#{user.name} not exist in the bank!!"
        log_error("#{transaction} failed with message #{message}")
        puts "Call endpoint for failure of #{transaction} with reason #{message}"
        callback.call(:failure, transaction, message)
        next
      end

      begin
        new_balance = user.balance + value
        if new_balance < 0
          raise StandardError.new("Not enough balance")
        end

        user.balance = new_balance
        log_info("#{transaction} succeeded")
        puts "Call endpoint for success of #{transaction}"

        if user.balance == 0
          log_warning("#{user.name} has 0 balance")
        end

        callback.call(:success, transaction, nil)

      rescue StandardError => e
        log_error("#{transaction} failed with message #{e.message}")
        puts "Call endpoint for failure of #{transaction} with reason #{e.message}"
        callback.call(:failure, transaction, e.message)
      end
    end
  end
end
