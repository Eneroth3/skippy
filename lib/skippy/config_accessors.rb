require 'json'
require 'pathname'

module Skippy::ConfigAccessors

  private

  def config_attr(*symbols, key: nil, type: nil)
    config_attr_reader(*symbols, key: key, type: type)
    config_attr_writer(*symbols, key: key, type: type)
    nil
  end

  def config_attr_reader(*symbols, key: nil, type: nil)
    class_eval do
      symbols.each do |symbol|
        raise TypeError unless symbol.is_a?(Symbol)
        define_method(symbol) do
          value = @config.get(key || symbol)
          value = type.new(value) if type && !value.is_a?(type)
          value
        end
      end
    end
    nil
  end

  def config_attr_writer(*symbols, key: nil, type: nil)
    class_eval do
      symbols.each do |symbol|
        raise TypeError unless symbol.is_a?(Symbol)
        symbol_set = "#{symbol}=".intern
        define_method(symbol_set) do |value|
          value = type.new(value) if type && !value.is_a?(type)
          @config.set(key || symbol, value)
          value
        end
      end
    end
    nil
  end

end
