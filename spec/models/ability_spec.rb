require 'cancan/matchers'
require 'rails_helper'
 
describe Ability do
  describe "abilities of loggined user" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:user) }
    let(:project){ FactoryGirl.create(:project, user: user) }
    let(:task){ FactoryGirl.create(:task, project: project) }
    let(:comment){ FactoryGirl.create(:comment, task: task) }
    let(:file_attachment){ FactoryGirl.create(:file_attachment, comment: comment) }

    context 'for projects' do
      it { expect(ability).to be_able_to(:manage, project) }
    end

    context 'for tasks' do
      it { expect(ability).to be_able_to(:manage, task) }
    end

    context 'for comments' do
      it { expect(ability).to be_able_to(:manage, comment) }
    end

    context 'for files' do
      it { expect(ability).to be_able_to(:manage, file_attachment) }
    end
  end
end