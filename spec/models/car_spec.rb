require 'spec_helper'

describe Car do
  it { should validate_presence_of(:make) }
  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:year) }

  it { should validate_numericality_of(:price).
                is_greater_than(0).
                is_less_than(1_000_000) }

  it { should belong_to(:user) }
end
