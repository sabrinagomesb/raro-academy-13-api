require 'rails_helper'

RSpec.describe Equipe, type: :model do
  it { should_not be_valid }
  it { should validate_presence_of :nome }
end
