require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  attr_reader :BankAccount

  def initialize(sender, receiver, status = "pending", amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end
  def valid?
    # self.new(sender, receier)
    receiver_acc = BankAccount.new(@receiver)
    sender_acc = BankAccount.new(@sender)
    (@receiver.valid? && @sender.valid?)? true : false
  end

  def execute_transaction
      if !self.sender.valid? || self.sender.balance < self.amount
        "Transaction rejected. Please check your account balance."
        self.status = "rejected"

      elsif self.valid? && self.status == "pending"
        # binding.pry
        self.receiver.balance += self.amount
        self.sender.balance -= self.amount
        self.status = "complete"
      #
      # elsif !self.sender.valid? || self.sender.balance < self.amount
      #   "Transaction rejected. Please check your account balance."
      #   self.status = "rejected"

      end
    end

    def reverse_transfer
      if self.status == "complete"
        self.sender.balance += self.amount
        self.receiver.balance -= self.amount
        self.status = "reversed"
      end
    end
end
