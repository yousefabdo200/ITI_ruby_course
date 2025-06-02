require_relative 'user'
require_relative 'transaction'
require_relative 'bank'

# Users inside the bank
users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

# Users outside the bank
outside_bank_users = [
  User.new("Menna", 400),
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(outside_bank_users[0], -100)
]

bank = CBABank.new(users)

bank.process_transactions(transactions) do |status, transaction, reason|
  # Callback for success or failure - no extra handling needed here as output already printed
end
