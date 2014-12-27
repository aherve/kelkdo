require 'rails_helper'

RSpec.describe "trucs/edit", :type => :view do
  before(:each) do
    @truc = assign(:truc, Truc.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit truc form" do
    render

    assert_select "form[action=?][method=?]", truc_path(@truc), "post" do

      assert_select "input#truc_name[name=?]", "truc[name]"
    end
  end
end
