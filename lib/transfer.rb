##

class Transfer
  
  attr_accessor :status
  attr_reader :sender, :receiver, :amount 

  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end 

  def valid?
    self.sender.valid? && self.receiver.valid?
  end 

  def reject
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end 

  def execute_transaction
    if self.valid? && self.sender.balance > self.amount && self.status == "pending"
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
    else 
      reject
    end
  end

  def reverse_transfer
    if self.valid? && self.receiver.balance > self.amount && self.status == "complete"
      self.sender.balance += self.amount 
      self.receiver.balance -= self.amount
      self.status = "reversed"
    else 
      reject
    end 
  end 

end
