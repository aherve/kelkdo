require 'rails_helper'

RSpec.describe "trucs/new", :type => :view do
  before(:each) do
    assign(:truc, Truc.new(
      :name => "MyString"
    ))
  end

  it "renders new truc form" do
    render

    assert_select "form[action=?][method=?]", trucs_path, "post" do

      assert_select "input#truc_name[name=?]", "truc[name]"
    end
  end
end
