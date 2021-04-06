require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(name: 'Juan', email: 'juan@mail.com', password: '123456') }

  describe 'Validations' do
    it { should validate_length_of(:name).is_at_most(20) }

    it { should_not allow_value('').for(:name) }

    long_name = (0..20).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(long_name).for(:name) }

    it { should allow_value(user.name).for(:name) }

    it { should validate_presence_of(:email) }

    email = (0...30).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(email).for(:email) }

    it { should allow_value(user.email).for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }

    password = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(password).for(:password) }

    it { should_not allow_value('').for(:password) }

    it { should allow_value(user.password).for(:password) }
  end

  describe 'User' do
    it { should have_many(:posts) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships) }
  end
end