# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chargeback, type: :model do
  it_behaves_like 'a movement'
end
