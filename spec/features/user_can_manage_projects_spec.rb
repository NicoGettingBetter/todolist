require 'rails_helper'

feature 'Project' do
  let(:user) { FactoryGirl.create(:user) }
  let(:new_title) { "N" }

  scenario 'user can edit project title', :js do
    @project = FactoryGirl.create(:project, user: user)
    log_in_user user
    edit_project
    wait_until_angular_ready
    expect((Project.find_by(id: @project.id)).title).to eq(new_title)
  end

  scenario 'user can delete project', :js do
    @project = FactoryGirl.create(:project, user: user)
    log_in_user user
    delete_project
    expect(page).not_to have_content('Add task')
  end

  scenario 'user can create project', :js do
    log_in_user user
    expect(page).to have_css('button', text: 'Add TODO list')
    fill_in_project_title_and_create
    expect(page).to have_content('Add task')
  end

  private

  def fill_in_project_title_and_create
    expect(page).to have_selector("input[id='new-project-title']")
    fill_in 'new-project-title', with: 'New project'
    expect(find("input[id='new-project-title']").value).to eq('New project')
    click_button('Add TODO list')
  end

  def edit_project
    expect(find("input[id='project.#{@project.id}']").value).to eq(@project.title)
    fill_in "project.#{@project.id}", with: new_title
  end

  def delete_project
    find('.project.glyphicon.glyphicon-remove').trigger('click')
  end
end