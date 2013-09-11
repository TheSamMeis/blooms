require 'spec_helper'

describe 'subscriptions/index' do
  it 'renders the index template' do
    render
    expect(view).to render_template('index')
  end
end