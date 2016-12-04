module ApplicationHelper

  def firstuser
    if User.count == 1
      current_user.update_attribute :admin, true
    end
  end
end
