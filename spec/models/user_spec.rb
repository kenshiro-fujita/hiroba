require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "新規会員登録ができる。有効なメールアドレス・パスワードであること。" do
    user = User.new(
      name: "sample",
      email: "sampleadress@sample.com",
      password: "1234asdf",
      password_confirmation: "1234asdf"
      )
    expect(user).to be_valid
  end
  it "メールアドレスの不備1。@が無いため登録できない" do
      user = User.new(
      name: "sample",
      email: "sampleadress.com",
      password: "1234asdf",
      password_confirmation: "1234asdf"
      )
    expect(user).to be_invalid
  end
  it "メールアドレスの不備2。@の後にカンマがないので登録できない" do
      user = User.new(
      name: "sample",
      email: "sampleadress@samplecom",
      password: "1234asdf",
      password_confirmation: "1234asdf"
      )
    expect(user).to be_invalid
  end
  it "パスワードの不備1。8文字に満たないため登録できない。" do
      user = User.new(
      name: "sample",
      email: "sampleadress@sample.com",
      password: "1234asd",
      password_confirmation: "1234asdfgh"
      )
    expect(user).to be_invalid
  end
  it "パスワードの不備2。40文字より多いため登録できない。" do
      user = User.new(
      name: "sample",
      email: "sampleadress@sample.com",
      password: "1234asd",
      password_confirmation: "1234asdfifaj498g9ath5t9e84yt98q4y98qt489r"
      )
    expect(user).to be_invalid
  end
  it "パスワードの不備3。数字のみのため登録できない。" do
      user = User.new(
      name: "sample",
      email: "sampleadress@sample.com",
      password: "1234asd",
      password_confirmation: "123412341234"
      )
    expect(user).to be_invalid
  end
  it "パスワードの不備4。英字のみのため登録できない。" do
      user = User.new(
      name: "sample",
      email: "sampleadress@sample.com",
      password: "1234asd",
      password_confirmation: "asdfasdfa"
      )
    expect(user).to be_invalid
  end
  it "パスワードの不備5。記号を使用しているため登録できない。" do
      user = User.new(
      name: "sample",
      email: "sampleadress@sample.com",
      password: "1234asd",
      password_confirmation: "1234asdf%%"
      )
    expect(user).to be_invalid
  end
end