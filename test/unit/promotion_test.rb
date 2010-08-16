require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Promotion.new.valid?
  end
end
