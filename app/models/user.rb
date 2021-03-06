class User < ActiveRecord::Base

has_many :ship_addresses, dependent: :destroy
has_many :subscriptions, dependent: :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessor :password, :password_confirmation, :remember_me, :card_token, :customer_id
  attr_accessor :card_token
  
  before_save :set_encrypted_password
  before_create :check_recurly
  before_destroy :cancel_subscription





  def authenticate(email,password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end


  def set_encrypted_password
    unless (password.blank?)
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end


  def check_recurly
    customer = Recurly::Account.find(customer_id) unless customer_id.nil?
  rescue Recurly::Resource::NotFound => e
    logger.error e.message
    errors.add :base, "Unable to create your subscription. #{e.message}"
    false
  end

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    customer = Recurly::Account.find(customer_id) unless customer_id.nil?
    unless customer.nil?
      subscription = customer.subscriptions.first
      subscription.update_attributes! :timeframe => 'now', :plan_code => role.name
    end
    true
  rescue Recurly::Resource::Invalid => e
    logger.error e.message
    errors.add :base, "Unable to update your subscription. #{e.message}"
    false
  end

  def update_recurly
    customer = Recurly::Account.find(customer_id) unless customer_id.nil?
    unless customer.nil?
      customer.email = email
      customer.first_name = first_name
      customer.last_name = last_name
      customer.save!
    end
  rescue Recurly::Resource::NotFound => e
    logger.error e.message
    errors.add :base, "Unable to update your subscription. #{e.message}"
    false
  end

  def cancel_subscription
    unless customer_id.nil?
      customer = Recurly::Account.find(customer_id)
      subscription = customer.subscriptions.first unless customer.nil?
      if (!subscription.nil?) && (subscription.state == 'active')
        subscription.cancel
      end
    end
  rescue Recurly::Resource::NotFound => e
    logger.error e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}"
    false
  end

 

end