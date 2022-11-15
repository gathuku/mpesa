# frozen_string_literal: true

require 'ostruct'

module Mpesa
  class Object
    attr_reader :attributes

    def initialize(attributes)
      return unless attributes.is_a?(Hash)
      @attributes = OpenStruct.new(attributes)
    end

    def method_missing(method, *args, &block)
      attribute = @attributes.send(method, *args, &block)
      attribute.is_a?(Hash) ? Object.new(attribute) : attribute
    end

    def respond_to_missing?(_method, _include_private = false)
      true
    end

    def to_hash
      attributes.to_h
    end
  end
end
