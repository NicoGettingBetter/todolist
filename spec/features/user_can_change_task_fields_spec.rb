require 'rails_helper'

feature 'Test' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let!(:task){ FactoryGirl.create(:task, project: project, priority: 1) }
  let(:new_date) { "12/12/2020" }

  scenario 'user can edit task deadline', js: true do
    log_in_user user
    show_date
    wait_until_angular_ready
    edit_task_date
    wait_until_angular_ready
    expect((Task.find_by(id: task.id)).deadline).not_to be_nil
  end

  scenario 'user can edit task done field', js: true do
    log_in_user user
    make_done
    wait_until_angular_ready
    expect((Task.find_by(id: task.id)).done).to be true
  end

  scenario 'user can low task priority', js: true do
    log_in_user user
    make_lower
    wait_until_angular_ready
    expect(Task.find_by(id: task.id).priority).to eq(2)
  end

  scenario 'user can high task priority', js: true do
    log_in_user user
    make_higher
    wait_until_angular_ready
    expect(Task.find_by(id: task.id).priority).to eq(0)
  end


  private

    def edit_task_date
      expect(find("input[id='task.#{task.id}.date']").value).to eq('')
      fill_in "task.#{task.id}.date", with: new_date
    end

    def show_date
      expect(page).to have_css('.glyphicon.glyphicon-calendar')
      find('.glyphicon.glyphicon-calendar').trigger('click')
    end

    def make_done
      expect(page).to have_css("input[type='checkbox']")
      find("input[type='checkbox']").click     
    end

    def make_lower
      expect(page).to have_css('.glyphicon.glyphicon-chevron-down')
      find('.glyphicon.glyphicon-chevron-down').trigger('click')
    end

    def make_higher
      expect(page).to have_css('.glyphicon.glyphicon-chevron-up')
      find('.glyphicon.glyphicon-chevron-up').trigger('click')
    end
end