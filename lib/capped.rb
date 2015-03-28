
module Capped

  class LimitExceededError < StandardError
    attr_reader :limit

    def initialize(msg, limit)
      super(msg)
      @limit = limit
    end
  end


  def capped_while(limit, condition_proc)
    countdown = limit
    while condition_proc.call
      countdown -= 1
      if countdown < 0
        raise LimitExceededError.new("Condition not met after #{limit} iterations", limit)
      end
      yield
    end
  end
  module_function :capped_while



  def capped_until(limit, condition_proc)
    countdown = limit
    until condition_proc.call
      countdown -= 1
      if countdown < 0
        raise LimitExceededError.new("Condition not met after #{limit} iterations", limit)
      end
      yield
    end
  end
  module_function :capped_until



  class << self
    alias_method :while, :capped_while
    alias_method :until, :capped_until
  end

end
