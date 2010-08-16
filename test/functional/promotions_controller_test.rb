require 'test_helper'

class PromotionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Promotion.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Promotion.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Promotion.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to promotion_url(assigns(:promotion))
  end
  
  def test_edit
    get :edit, :id => Promotion.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Promotion.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Promotion.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Promotion.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Promotion.first
    assert_redirected_to promotion_url(assigns(:promotion))
  end
  
  def test_destroy
    promotion = Promotion.first
    delete :destroy, :id => promotion
    assert_redirected_to promotions_url
    assert !Promotion.exists?(promotion.id)
  end
end
