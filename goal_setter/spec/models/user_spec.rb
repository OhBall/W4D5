require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  
  # it { should have_many(:goals) }
  subject(:user) {FactoryBot.create(:user)}
  before :each do
    user.save
  end
  
  describe '::find_by_credentials' do
    
    context 'with valid credentials' do
      it "finds the proper user" do
        expect(User.find_by_credentials(user.email, user.password)).to eq(user)
      end
    end
    
    context 'with invalid credentials' do
      it "returns nil" do
        expect(User.find_by_credentials('bob@aol.com', 'wrong_password')).to be_nil
      end
    end
  end
  
  describe '#is_password?' do
    context 'given the right password' do
      it "returns true" do
        expect(user.is_password?('passwurd')).to be(true)
      end
    end
    
    context 'given the wrong password' do
      it "returns false" do
        expect(user.is_password?('pa55wurd5')).to be(false)
      end
    end
  end
  
  describe '#password=' do
    it "sets @password" do
      user.password = 'new_password'
      expect(user.password).to eq('new_password')
    end
    
    it "sets a new password_digest" do
      prev_digest = user.password_digest
      user.password = 'new_password'
      expect(user.password_digest).not_to eq(prev_digest)
    end
  end
  
  describe '#reset_session_token!' do
    it "resets the session token" do
      prev_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(prev_session_token)
    end
  end
  # 
  # describe '#ensure_session_token' do
  #   context 'session_token is nil' do
  #     it "assigns a session token" do
  #       user.session_token = nil
  #       user.ensure_session_token
  #       expect(user.session_token).not_to be_nil
  #     end      
  #   end
  # 
  #   context 'session_token exists' do
  #     it "does not change the session_token" do
  #       token = user.session_token
  #       user.ensure_session_token
  #       expect(user.session_token).to eq(token)
  #     end
  #   end
  # 
  # end
end
