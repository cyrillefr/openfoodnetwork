# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Preference do
  it "should require a key" do
    @preference = Spree::Preference.new
    @preference.key = :test
    @preference.value_type = :boolean
    @preference.value = true
    expect(@preference).to be_valid
  end

  describe "type conversion for values" do
    def round_trip_preference(key, value, value_type)
      p = Spree::Preference.new
      p.value = value
      p.value_type = value_type
      p.key = key
      p.save

      Spree::Preference.find_by(key:)
    end

    it ":boolean" do
      value_type = :boolean
      value = true
      key = "boolean_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it "false :boolean" do
      value_type = :boolean
      value = false
      key = "boolean_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it ":integer" do
      value_type = :integer
      value = 10
      key = "integer_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it ":decimal" do
      value_type = :decimal
      value = 1.5
      key = "decimal_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it "incovertible :decimal" do
      value_type = :decimal
      value = "invalid"
      key = "decimal_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it ":string" do
      value_type = :string
      value = "This is a string"
      key = "string_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it ":text" do
      value_type = :text
      value = "This is a string stored as text"
      key = "text_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it ":password" do
      value_type = :password
      value = "This is a password"
      key = "password_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end

    it ":any" do
      value_type = :any
      value = [1, 2]
      key = "any_key"
      pref = round_trip_preference(key, value, value_type)
      expect(pref.value).to eq value
      expect(pref.value_type).to eq value_type.to_s
    end
  end
end
