require 'spec_helper'
describe 'systemsetup' do

  context 'with defaults for all parameters' do
    it { should contain_class('systemsetup') }
  end
end
