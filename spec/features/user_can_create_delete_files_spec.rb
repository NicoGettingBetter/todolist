require 'rails_helper'

feature 'File attachment' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let!(:comment) { FactoryGirl.create(:comment, task: task) }
  let(:new_text) { "N" }

  scenario 'user can create file', js: true do
    log_in_user user
    show_comments
    wait_until_angular_ready
    expect(page).to have_css('button', text: 'Add comment')
    add_file_and_create
    expect(Comment.last).not_to be_nil
  end

  scenario 'user can delete file', js: true do
    log_in_user user
    show_comments
    wait_until_angular_ready
    expect(page).to have_css('button', text: 'Add comment')
    add_file_and_create
    delete_file
    expect(Comment.last).to be_nil
  end

  private

  def add_file_and_create
    attach_file 'attachment', "#{Rails.root}/spec/Armed_men.docx"
  end

  def delete_file
    find('.file.glyphicon.glyphicon-remove').trigger('click')
  end

  def show_comments
    find('.glyphicon.glyphicon-comment').trigger('click')
  end
end