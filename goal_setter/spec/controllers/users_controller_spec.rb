require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do 
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end
  
  describe 'POST #create' do 
    context "with invalid params" do
      it "renders the new template" do
        post :create, params:{user:{email: nil, password: "passwurd"}}
        expect(response).to render_template(:new)
      end
    end
    context "with valid params" do
      it "redirects to show template" do
        post :create, params:{user:{email: "generic@generic.com", password: "passwurd"}}
        expect(response).to redirect_to(user_url(User.find_by(email: "generic@generic.com")))
      end
    end
  end
  
  describe 'GET #show' do
    context 'if user exists' do
      it "shows the users page" do
        user = User.create!(email: "generic@generic.com", password: "passwurd")
        get :show, params: { id: user.id}
        expect(response).to render_template(:show)
      end      
    end
    
    context 'if user does not exist' do
      it "is not a success" do
        begin
          get :show, params: { id: -1 }
        rescue 
          ActiveRecord::RecordNotFound
        end
        
        expect(response).not_to render_template(:show)
      end
    end
  end
  
  # describe 'DELETE #destroy' do
  # 
  # end
  
end
