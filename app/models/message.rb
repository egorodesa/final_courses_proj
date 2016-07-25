class Message < ActiveRecord::Base
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  acts_as_paranoid
  paginates_per 5

end
