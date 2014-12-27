require 'rails_helper'

RSpec.describe "trucs/index", :type => :view do
  before(:each) do
    assign(:trucs, [
      Truc.create!(
        :name => "Name"
      ),
      Truc.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of trucs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
