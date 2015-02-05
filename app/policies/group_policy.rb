class GroupPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def show?
    scope.where(:slug => group.slug).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    scope.where(:slug => group.slug).exists?
  end

  def edit?
    update?
  end
  
  def join?
    true
  end

  def create_membership?
    true
  end

  def activate_membership?
    update?
  end

  def activate_invitation?
    true
  end

  def scope
    Pundit.policy_scope!(user, group.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.groups.active
    end
  end
end
