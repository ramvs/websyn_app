require 'rails_helper'

describe Group do
  fixtures :groups
  fixtures :users
  it "should add two users to group" do
    groups(:one).users << users(:one)
    groups(:one).users <<  users(:two)
    expect(groups(:one).users.length) .to eq(2)
  end
end