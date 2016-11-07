class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Project, user_id: user.id
      can :manage, Task do |task|
        task.project.user.id == user.id
      end
      can :manage, Comment do |comment|
        comment.task.project.user.id == user.id
      end
      can :manage, FileAttachment do |file|
        file.comment.task.project.user.id == user.id
      end
    end
  end
end
