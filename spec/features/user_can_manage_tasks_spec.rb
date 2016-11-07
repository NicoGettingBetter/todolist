require 'rails_helper'

feature 'Test' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let(:new_title) { "N" }

  scenario 'user can edit task title', :js do
    @task = FactoryGirl.create(:task, project: project)
    log_in_user user
    edit_task
    wait_until_angular_ready
    expect((Task.find_by(id: @task.id)).title).to eq(new_title)
  end

  scenario 'user can create task', :js do
    log_in_user user
    expect(page).to have_css('button', text: 'Add task')
    fill_in_task_title_and_create
    expect(page).to have_selector("input[id='task.1']")
  end

  scenario 'user can delete task', :js do
    @task = FactoryGirl.create(:task, project: project)
    log_in_user user
    wait_until_angular_ready
    delete_task
    wait_until_angular_ready
    expect(page).not_to have_content('Add comment')
  end

  private

    def fill_in_task_title_and_create
      expect(page).to have_selector("input[id='new-task-title']")
      fill_in 'new-task-title', with: 'New task'
      expect(find("input[id='new-task-title']").value).to eq('New task')
      click_button('Add task')
    end

    def edit_task
      expect(find("input[id='task.#{@task.id}']").value).to eq(@task.title)
      fill_in "task.#{@task.id}", with: new_title
    end

    def delete_task
      find('.task.glyphicon.glyphicon-remove').trigger('click')
    end
end