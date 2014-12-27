require 'rails_helper'

RSpec.describe "trucs/show", :type => :view do
  before(:each) do
    @truc = assign(:truc, Truc.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
