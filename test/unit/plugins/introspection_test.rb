require 'test_helper'

class IntrospectionTest < GemeraldBeanstalkTest

  context 'autoload' do

    should 'automatically load plugin' do
      GemeraldBeanstalk::Beanstalk.expects(:load_plugin).with(:Introspection)
      load 'gemerald_beanstalk/plugins/introspection.rb'
    end

  end


  context 'instance methods' do

    setup do
      @beanstalk = GemeraldBeanstalk::Beanstalk.new('localhost:11300')
      @beanstalk.extend(GemeraldBeanstalk::Plugin::Introspection)
    end


    context '#connections' do

      should 'return the beanstalk instance connections object' do
        assert_equal @beanstalk.instance_variable_get(:@connections), @beanstalk.connections
      end

    end


    context '#jobs' do

      should 'return the compacted beanstalk instance jobs object' do
        assert_equal @beanstalk.instance_variable_get(:@jobs).compact, @beanstalk.jobs
      end

    end


    context '#tubes' do

      should 'return the beanstalk instance active_tubes' do
        @beanstalk.expects(:active_tubes).once.returns({})
        @beanstalk.tubes
      end

    end

  end

end
