require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Resource.new.valid?
  end
end
