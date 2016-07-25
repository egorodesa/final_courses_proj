class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                                      default_url: "/images/:style/noimg.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :received_messages, class_name: 'Message', foreign_key: :receiver_id
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id

  def age
    now = Time.now.utc.to_date
    # binding.pry
    now.year - date_of_birth.year - (date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
