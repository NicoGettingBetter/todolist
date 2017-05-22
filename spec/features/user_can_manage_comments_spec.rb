require 'rails_helper'

feature 'Comment' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let(:new_text) { "N" }

  scenario 'user can edit comment text', js: true do
    @comment = FactoryGirl.create(:comment, task: task)
    log_in_user user
    show_comments
    wait_until_angular_ready
    edit_comment
    sleep 1
    expect(Comment.last.text).to eq(new_text)
  end

  scenario 'user can create comment', js: true do
    log_in_user user
    show_comments
    wait_until_angular_ready
    expect(page).to have_css('button', text: 'Add comment')
    fill_in_comment_text_and_create
    wait_until_angular_ready
    expect(Comment.last).not_to be_nil
  end

  scenario 'user can delete comment', js: true do
    @comment = FactoryGirl.create(:comment, task: task)
    log_in_user user
    show_comments
    wait_until_angular_ready
    delete_comment
    wait_until_angular_ready
    expect(page).not_to have_selector("input[id='comment.1']")
  end

  private

  def fill_in_comment_text_and_create
    expect(page).to have_selector("input[id='new-comment-text']")
    fill_in 'new-comment-text', with: 'New comment'
    expect(find("input[id='new-comment-text']").value).to eq('New comment')
    click_button('Add comment')
  end

  def edit_comment
    fill_in "comment.#{@comment.id}", with: new_text
  end

  def delete_comment
    find('.comment.glyphicon.glyphicon-remove').trigger('click')
  end

  def show_comments
    find('.glyphicon.glyphicon-comment').trigger('click')
  end
end