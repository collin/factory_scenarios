class FactoryScenarios::Mail::Preview
  def mailer_message
    mailer.send(message, *self.message_args)
  end

  def render
    message
  end

  def login_as(&block)
    if block_given?
      @login_as = block
    elsif @login_as
      @login_as.call *self.message_args
    end
  end

  def name(name=nil)
    if name
      @name = name
    else
      @name
    end
  end

  def mailer(mailer=nil)
    if mailer
      @mailer = mailer
    else
      @mailer
    end
  end

  def message(message=nil)
    if message
      @message = message
    else
      @message
    end
  end

  def message_args(&block)
    if block_given?
      @message_args = block
    else
      @_args ||= @message_args.call
    end
  end
end