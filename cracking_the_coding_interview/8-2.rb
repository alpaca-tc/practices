class Human
  def initialize
    close
  end

  def busy?
    @busy
  end

  def respond_to(request)
    @busy = true
    @request = request
  end

  def close
    @request = nil
    @busy = false
  end

  class Manager < Human
  end

  class Director < Human
    def respond_to(request)
      if @busy

      else
        super
      end
    end
  end

  class Responser < Human
  end
end

def dispatch_call
end
