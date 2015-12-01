require 'rails_helper'

describe User do
  fixtures :groups
  fixtures :users
  it "should add two groups to user" do
    users(:one)<< groups(:one)
    users(:one) << groups(:two)
    expect(user.groups.length) .to eq(2)
  end
end