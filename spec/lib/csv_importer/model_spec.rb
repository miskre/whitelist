require 'rails_helper'

class TestModel < CsvImporter::Model
  attribute :test1, Integer
  attribute :test2, Integer
  attribute :test3, Integer
  attribute :test4, Integer

  validates :test1, :test2,
    presence: true
  validates :test3, :test4,
    numericality: { greater_than: 0 }
end

describe CsvImporter::Model do
  subject { TestModel }

  describe '.validate_presence_attributes' do
    it 'PresenceValidatorが指定されたカラムを返すこと' do
      expect(subject.validate_presence_attributes).to contain_exactly(:test1, :test2)
    end
  end
end
