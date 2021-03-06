class User < ActiveRecord::Base

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  attr_reader :password

  after_initialize :ensure_session_token

  has_many(
    :posts,
    class_name: 'Post',
    primary_key: :id,
    foreign_key: :author_id,
    inverse_of: :author
  )

  has_many(
    :subs,
    class_name: 'Sub',
    primary_key: :id,
    foreign_key: :moderator_id,
    inverse_of: :moderator
  )

  has_many(
    :comments,
    class_name: 'Comment',
    foreign_key: :author_id,
    primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    update!(session_token: SecureRandom.urlsafe_base64)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64 unless session_token
  end


end
