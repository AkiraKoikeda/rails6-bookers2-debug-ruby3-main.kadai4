class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group_user
end
