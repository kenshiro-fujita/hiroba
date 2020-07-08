require 'rails_helper'

RSpec.describe User, type: :model do
  describe '適切な条件であるため有効' do
    it '新規会員登録ができる。有効なメールアドレス・パスワードであること。' do
      user = User.new(
        name: 'sample_user',
        email: 'sample_adress@sample.com',
        password: '1234asdf00',
        password_confirmation: '1234asdf00'
        )
      expect(user).to be_valid
    end
  end
  
  describe 'メールアドレス関係の不備' do
    let(:params) { { name: 'sample_user',email: email, password: '1234asdf', password_confirmation: '1234asdf'} }
    let(:user) { User.new(params) }
    context '@がない' do
      let(:email) { 'sample123sample.com' }
      it '無効であること' do
        expect(user).to be_invalid
      end
    end
    context '@の後にカンマがない' do
      let(:email) { 'sample456@sample.com'}
      it '無効であること' do
        expect(user).to be_valid
      end
    end
  end
  
  describe 'パスワード関係の不備' do
    let(:params) { {name: 'sample_user',email: 'sample_passaddress@sample.com' } }
    let(:user) { User.new(params)}
    context '文字数の不備' do
      it '8文字に満たないため無効。' do
        params.merge!(password: '1234asd',password_confirmation: '1234asd')
        user = User.new(params)
        expect(user).to be_invalid
      end
      it '40文字より多いため無効。' do
        params.merge!(password: '1234asdfifaj498g9ath5t9e84yt98q4y98qt489r', password_confirmation: '1234asdfifaj498g9ath5t9e84yt98q4y98qt489r')
        user = User.new(params)
        expect(user).to be_invalid
      end
    end
    context '使用文字の不備' do
      it '数字のみのため無効。' do
        params.merge!(password: '123456789', password_confirmation: '123456789')
        expect(user).to be_invalid
      end
      it '英字のみのため無効。' do
        params.merge!(password: 'asdffdsaaa', password_confirmation: 'asdffdsaaa')
        expect(user).to be_invalid
      end
      it '_以外の記号を使用しているため無効。' do
        params.merge!(password: 'asdf1234@', password_confirmation: 'asdf1234@')
        expect(user).to be_invalid
      end
    end
  end
end