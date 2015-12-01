require 'spec_helper'
require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "update method in UsersController" do
    before(:each) do
      users(:one).groups << groups(:one)
      users(:one).groups << groups(:two)

    end
    let(:attr) do  { :group_ids => ["1"] , :current_user => {:current_user => ["2"]}} end

    fixtures :groups
    fixtures :users

    it "should return true because current user groups are contain in user_param" do
      controller = UsersController.new
      #Empty string because helper collection_check_boxes returns one hidden empty param
      user_params = {"current_user"=>"2", "group_ids"=>["1",""]}
      get_groups_from_param = controller.send(:get_groups_from_param,user_params)

      controller.send(:check_user_grups,get_groups_from_param, users(:one)).should be(true)
    end

    it "should return false because current user groups are not contain in user_param" do
      controller = UsersController.new
      #Empty string because helper collection_check_boxes returns one hidden empty param
      user_params = {"current_user"=>"2", "group_ids"=>["1", "5", ""]}
      get_groups_from_param = controller.send(:get_groups_from_param,user_params)
      controller.send(:check_user_grups,get_groups_from_param, users(:one)).should be(false)
    end

    it 'should return current user with id 2 from user_params' do
      controller = UsersController.new
      user_params = {"current_user"=>"2", "group_ids"=>["1", "2", ""]}
      expect(controller.send(:get_current_user_from_form, user_params).id == users(:two).id).to eq(true)
    end

    it 'should update user groups and increment from 2 to 3' do
      controller = UsersController.new
      controller.save_group_to_user(["1","2","3"],users(:one))
      expect(users(:one).groups.count).to eq (3)
      binding.pry
    end

    it "asdsa" do 


    end
  end
end