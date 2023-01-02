require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'given all correct field inputs' do
      it 'will successfully save' do
        user = User.new(first_name: 'test', last_name: 'user', email:'test_email@hotmail.com', password:'12345', password_confirmation:'12345')

        expect(user).to be_valid
      end
    end

    context 'password and password_confrimation does not match' do
      it 'gives an error saying the fields must match' do
        user = User.new(first_name: 'test', last_name: 'user', email:'test_email@hotmail.com', password:'12345', password_confirmation:'12346')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context 'password not provided' do
      it "gives an error saying password can't be nil" do
        user = User.new(first_name: 'test', last_name: 'user', email:'test_email@hotmail.com')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
    end

    context 'password confirmation not provided' do
      it "gives an error saying password confirmation can't be nil" do
        user = User.new(first_name: 'test', last_name: 'user', email:'test_email@hotmail.com', password: '12345')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context 'email is not unique' do
      it 'gives error if email is already in database' do
        user = User.new(first_name: 'test', last_name: 'user', email:'test_email@hotmail.com', password:'12345', password_confirmation:'12345')
        user.save
  
        user1 = User.new(first_name: 'test', last_name: 'user', email:'TEST_EMAIL@HOTMAIL.COM', password:'12345', password_confirmation:'12345')
        user1.save
        
        expect(user1.errors.full_messages).to include("Email has already been taken")
      end
    end

    context 'email not provided' do
      it "gives an error saying email can't be nil" do
        user = User.new(first_name: 'test', last_name: 'user', password: '12345', password_confirmation: '12345')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Email can't be blank")
      end
    end

    context 'first name not provided' do
      it "gives an error saying first name can't be nil" do
        user = User.new(last_name: 'user', email:'test_email@hotmail.com', password: '12345', password_confirmation: '12345')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("First name can't be blank")
      end
    end

    context 'last name not provided' do
      it "gives an error saying last name can't be nil" do
        user = User.new(first_name: 'test', email:'test_email@hotmail.com', password: '12345', password_confirmation: '12345')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    context 'password does not reach minimum length requirements' do
      it "gives an error saying password is too short" do
        user = User.new(first_name: 'test', last_name: 'user', email:'test_email@hotmail.com', password: '1234', password_confirmation: '1234')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'login was successful' do
      it 'returns user' do
        user = User.new(first_name: 'test', last_name: 'user', email: 'test_email@hotmail.com', password: '12345', password_confirmation: '12345')
        user.save

        expect(User.authenticate_with_credentials('test_email@hotmail.com', '12345')[0]).to eq(User.find_by(email: 'test_email@hotmail.com'))
      end

      it 'returns user even with inputted whitespaces around the email' do
        user = User.new(first_name: 'test', last_name: 'user', email: 'test_email@hotmail.com', password: '12345', password_confirmation: '12345')
        user.save

        expect(User.authenticate_with_credentials('    test_email@hotmail.com    ', '12345')[0]).to eq(User.find_by(email: 'test_email@hotmail.com'))
      end

      it 'returns user even with incorrect casing in the inputted email' do
        user = User.new(first_name: 'test', last_name: 'user', email: 'test_email@hotmail.com', password: '12345', password_confirmation: '12345')
        user.save

        expect(User.authenticate_with_credentials('test_Email@hotmail.com', '12345')[0]).to eq(User.find_by(email: 'test_email@hotmail.com'))
      end
    end
  end
end

