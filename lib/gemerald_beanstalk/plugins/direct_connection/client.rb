module GemeraldBeanstalk::Plugin::DirectConnection
  class Client

    def close_connection
      return unless @connection.alive?
      @connection.close_connection
      @beanstalk.disconnect(self)
    end


    def initialize(beanstalk)
      @beanstalk = beanstalk
      @connection = beanstalk.connect(self)
      @async_response = nil
    end


    def transmit(message)
      @connection.execute(message)
      while (async_response = @async_response).nil?
        sleep 0.1
      end
      @async_response = nil
      return async_response
    end


    def send_data(message)
      @async_response = message
    end

  end

end

