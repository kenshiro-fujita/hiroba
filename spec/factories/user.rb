FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_name#{n}"}
    sequence(:email) { |n| "test_address#{n}@test.co.jp"}
    password { '1234asdf' }
    password_confirmation { '1234asdf' }
  end
  
  factory :kimika, class: User do
    name { 'kimika' }
    email { 'kimika@kimika.com' }
    password { 'kimika123' }
    password_confirmation { 'kimika123' }
  end
  
  factory :himura, class: User do
    name { 'himura' }
    email { 'himura@himura.com' }
    password { 'himura123' }
    password_confirmation { 'himura123' }
  end
  
  factory :fail_himura, class: User do
    name { 'fail_himura' }
    email { 'fail_himura@himura.com' }
    password { 'himurahimura' }
    password_confirmation { 'himurahimura' }
  end

end