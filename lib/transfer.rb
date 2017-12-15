class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = 50
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    binding.pry
    if valid? && sender.balance > amount && status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transfer
    end
  end

  def reverse_transfer
    if valid? && receiver.balance > amount && self.status == "completed"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "pending"
    else
      reject_transfer
    end
  end

  def reject_transfer
    self.status = "Transaction rejected. Please check your account balance."
    "Transaction rejected. Please check your account balance."
  end
end
