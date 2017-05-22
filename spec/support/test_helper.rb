module TestHelper
  def log_in user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
    @request.headers.merge!('Authorization' => JWT.encode({user_id: user.id}, '1a5b356e56c96ad'))
  end

  def ability
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)    
  end

  def project_ability
    @ability.can :manage, Project, user_id: user.id
  end

  def task_ability
    project_ability
    @ability.can :manage, Task, project: project
  end

  def comment_ability
    task_ability
    @ability.can :manage, Comment, task: task
  end

  def file_ability
    comment_ability
    @ability.can :manage, FileAttachment, comment: comment
  end

  def log_in_user user
    visit '/'
    click_link('Log In')
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button('Log In')
  end

  def log_out
    visit '/'
    click_link('Log Out')
  end
end
