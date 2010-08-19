require File.dirname(__FILE__) + '/../spec_helper'
 
describe ServicesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Service.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Service.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Service.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(service_url(assigns[:service]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Service.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Service.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Service.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Service.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Service.first
    response.should redirect_to(service_url(assigns[:service]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    service = Service.first
    delete :destroy, :id => service
    response.should redirect_to(services_url)
    Service.exists?(service.id).should be_false
  end
end
