require 'active_support/inflector'
require 'json'

module Ssllabs
  class ApiObject

    class << self;
      attr_accessor :all_attributes
      attr_accessor :fields
      attr_accessor :lists
      attr_accessor :refs
    end

    def self.inherited(base)
      base.all_attributes = []
      base.fields = []
      base.lists = {}
      base.refs = {}
    end

    def self.to_api_name(name)
      name.to_s.gsub(/\?$/,'').camelize(:lower)
    end

    def self.to_attr_name(name)
      name.to_s.gsub(/\?$/,'').underscore
    end

    def self.field_methods(name)
      is_bool = name.to_s.end_with?('?')
      attr_name = to_attr_name(name)
      api_name = to_api_name(name)
      class_eval <<-EOF, __FILE__, __LINE__
        def #{attr_name}#{'?' if is_bool}
          @#{api_name}
        end
        def #{attr_name}=(value)
          @#{api_name} = value
        end
      EOF
    end

    def self.has_fields(*names)
      names.each do |name|
        @all_attributes << to_api_name(name)
        @fields << to_api_name(name)
        field_methods(name)
      end
    end

    def self.has_objects_list(name, klass)
      @all_attributes << to_api_name(name)
      @lists[to_api_name(name)] = klass
      field_methods(name)
    end

    def self.has_object_ref(name, klass)
      @all_attributes << to_api_name(name)
      @refs[to_api_name(name)] = klass
      field_methods(name)
    end

    def self.load(attributes = {})
      obj = self.new
      attributes.each do |name,value|
        if @fields.include?(name)
          obj.instance_variable_set("@#{name}", value)
        elsif @lists.key?(name)
          obj.instance_variable_set("@#{name}", value.map { |v| @lists[name].load(v) }) unless value.nil?
        elsif @refs.key?(name)
          obj.instance_variable_set("@#{name}", @refs[name].load(value)) unless value.nil?
        else
          raise ArgumentError, "#{name} is not an attribute of object #{self.name}"
        end
      end
      obj
    end

    def to_json(opts={})
      obj = {}
      self.class.all_attributes.each do |api_name|
        v = instance_variable_get("@#{api_name}")
        obj[api_name] = v
      end
      obj.to_json
    end
  end
end
