require 'rails_helper'

feature 'Test' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let(:new_title) { "N" }

  scenario 'user can edit task title', :js do
    @task = FactoryGirl.create(:task, project: project)
    log_in_user user
    edit_task
    sleep 1
    expect((Task.find_by(id: @task.id)).title).to eq(new_title)
  end

  scenario 'user can create task', :js do
    log_in_user user
    expect(page).to have_css('button', text: 'Add task')
    fill_in_task_title_and_create
    sleep 1
    expect(Project.find_by(id: project.id).tasks).to be_any
  end

  scenario 'user can delete task', :js do
    @task = FactoryGirl.create(:task, project: project)
    log_in_user user
    delete_task
    wait_until_angular_ready
    expect(Project.find_by(id: project.id).tasks).not_to be_any
  end

  private

    def fill_in_task_title_and_create
      expect(page).to have_selector("input[id='new-task-title']")
      fill_in 'new-task-title', with: new_title
      expect(find("input[id='new-task-title']").value).to eq("N")
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