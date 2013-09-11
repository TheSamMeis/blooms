class RecurlyController < ApplicationController
  protect_from_forgery :except => :push


## for expired subscription
  def push
    notification = Hash.from_xml(request.body())
    render :text => "Request accepted."
    if notification.has_key?('expired_subscription_notification')
      account_code = notification['expired_subscription_notification']['account']['account_code']
      sub_code = notification['expired_subscription_notification']['subscription']['uuid']
      plan_code = notification['expired_subscription_notification']['subscription']['plan']['plan_code']
      logger.info "Recurly push notification: expired_subscription_notification for account #{account_code}"
      expired_subscription = Subscription.where(:user_id => account_code, :subscription_frequency => plan_code).first
      expired_subscription.expire unless expired_subscription.nil?
      # end
    end
  rescue Recurly::Resource::NotFound => e
    logger.error "Recurly: #{e.message}"
  rescue ActiveRecord::RecordNotFound => e
    logger.error "Customer record not found: #{e.message}"
  end

  def test
    xml = <<XML
<expired_subscription_notification>
  <account>
    <account_code>71</account_code>
    <username nil="true"></username>
    <email>verena@example.com</email>
    <first_name>Verena</first_name>
    <last_name>Example</last_name>
    <company_name nil="true"></company_name>
  </account>
  <subscription>
    <plan>
      <plan_code>2week</plan_code>
      <name>Subscription One</name>
    </plan>
    <uuid>d1b6d359a01ded71caed78eaa0fedf8e</uuid>
    <state>expired</state>
    <quantity type="integer">1</quantity>
    <total_amount_in_cents type="integer">200</total_amount_in_cents>
    <activated_at type="datetime">2010-09-23T22:05:03Z</activated_at>
    <canceled_at type="datetime">2010-09-23T22:05:43Z</canceled_at>
    <expires_at type="datetime">2010-09-24T22:05:03Z</expires_at>
    <current_period_started_at type="datetime">2010-09-23T22:05:03Z</current_period_started_at>
    <current_period_ends_at type="datetime">2010-09-24T22:05:03Z</current_period_ends_at>
    <trial_started_at nil="true" type="datetime">
    </trial_started_at><trial_ends_at nil="true" type="datetime"></trial_ends_at>
  </subscription>
</expired_subscription_notification>
XML
    test_request = HTTPI::Request.new(recurly_push_url)
    test_request.open_timeout = 1 # seconds
    test_request.read_timeout = 1
    test_request.headers = { "Content-Type" => "text/xml" }
    test_request.body = xml
    test_response = HTTPI.post(test_request)
    render :text => "Check server log for result of request to #{recurly_push_url}"
  rescue HTTPClient::ReceiveTimeoutError
    logger.info "Testing push notification listener: sent XML to #{recurly_push_url}"
    render :text => "Check server log for result of request to #{recurly_push_url}"
  end



# when a new subscription is created and verified by recurly the local subscription will get a status of active
def push_new_subscription
    notification = Hash.from_xml(request.body())
    render :text => "Request accepted."
    if notification.has_key?('new_subscription_notification')
      account_code = notification['new_subscription_notification']['account']['account_code']
      sub_code = notification['new_subscription_notification']['subscription']['uuid']
      plan_code = notification['new_subscription_notification']['subscription']['plan']['plan_code']
      @uuid = notification['new_subscription_notification']['subscription']['uuid']
      logger.info "Recurly push notification: new_subscription_notification for account #{account_code}"
      # because in the signup process the customer could technically make more than one subscription saved to the database
      # using .last to target the last one they created >> the subscription they intended to checkout with
      new_subscription = Subscription.where(:user_id => account_code, :subscription_frequency => plan_code).last
      new_subscription.active unless new_subscription.nil?
      new_subscription.uuid = @uuid
      new_subscription.save
      # end
    end
  rescue Recurly::Resource::NotFound => e
    logger.error "Recurly: #{e.message}"
  rescue ActiveRecord::RecordNotFound => e
    logger.error "Customer record not found: #{e.message}"
  end


def test_new_subscription
   xml = <<XML
<new_subscription_notification>
  <account>
    <account_code>123</account_code>
    <username nil="true">verena</username>
    <email>verena@example.com</email>
    <first_name>Verena</first_name>
    <last_name>Example</last_name>
    <company_name nil="true">Company, Inc.</company_name>
  </account>
  <subscription>
    <plan>
      <plan_code>2week</plan_code>
      <name>Bronze Plan</name>
      <version type="integer">2</version>
    </plan>
    <uuid>8047cb4fd5f874b14d713d785436ebd3</uuid>
    <state>active</state>
    <quantity type="integer">2</quantity>
    <total_amount_in_cents type="integer">2000</total_amount_in_cents>
    <activated_at type="datetime">2009-11-22T13:10:38Z</activated_at>
    <canceled_at type="datetime"></canceled_at>
    <expires_at type="datetime"></expires_at>
    <current_period_started_at type="datetime">2009-11-22T13:10:38Z</current_period_started_at>
    <current_period_ends_at type="datetime">2009-11-29T13:10:38Z</current_period_ends_at>
    <trial_started_at type="datetime">2009-11-22T13:10:38Z</trial_started_at>
    <trial_ends_at type="datetime">2009-11-29T13:10:38Z</trial_ends_at>
  </subscription>
</new_subscription_notification>
XML

  test_request = HTTPI::Request.new(recurly_push_new_subscription_url)
    test_request.open_timeout = 1 # seconds
    test_request.read_timeout = 1
    test_request.headers = { "Content-Type" => "text/xml" }
    test_request.body = xml
    test_response = HTTPI.post(test_request)
    render :text => "Check server log for result of request to #{recurly_push_url}"
  rescue HTTPClient::ReceiveTimeoutError
    logger.info "Testing push notification listener: sent XML to #{recurly_push_url}"
    render :text => "Check server log for result of request to #{recurly_push_url}"
  end


def push_declined_payment
    notification = Hash.from_xml(request.body())
    render :text => "Request accepted."
    if notification.has_key?('failed_payment_notification')
      @uuid = notification['failed_payment_notification']['transaction']['subscription_id']
 
      #now we can search by uuid because the account has been created
      declined_subscription = Subscription.where(:uuid => @uuid).last
      declined_subscription.declined unless declined_subscription.nil?

    end
  rescue Recurly::Resource::NotFound => e
    logger.error "Recurly: #{e.message}"
  rescue ActiveRecord::RecordNotFound => e
    logger.error "Customer record not found: #{e.message}"
  end

def test_declined_payment
     xml = <<XML
<failed_payment_notification>
  <account>
    <account_code>1</account_code>
    <username nil="true">verena</username>
    <email>verena@example.com</email>
    <first_name>Verena</first_name>
    <last_name>Example</last_name>
    <company_name nil="true">Company, Inc.</company_name>
  </account>
  <transaction>
    <id>a5143c1d3a6f4a8287d0e2cc1d4c0427</id>
    <invoice_id>8fjk3sd7j90s0789dsf099798jkliy65</invoice_id>
    <invoice_number type="integer">2059</invoice_number>
    <subscription_id>8047cb4fd5f874b14d713d785436ebd3</subscription_id>
    <invoice_number type="integer">2059</invoice_number>
    <subscription_id>1974a098jhlkjasdfljkha898326881c</subscription_id>
    <action>purchase</action>
    <date type="datetime">2009-11-22T13:10:38Z</date>
    <amount_in_cents type="integer">1000</amount_in_cents>
    <status>Declined</status>
    <message>This transaction has been declined</message>
    <reference></reference>
    <cvv_result code=""></cvv_result>
    <avs_result code=""></avs_result>
    <avs_result_street></avs_result_street>
    <avs_result_postal></avs_result_postal>
    <test type="boolean">true</test>
    <voidable type="boolean">false</voidable>
    <refundable type="boolean">false</refundable>
  </transaction>
</failed_payment_notification>
XML

  test_request = HTTPI::Request.new(recurly_push_declined_payment_url)
    test_request.open_timeout = 1 # seconds
    test_request.read_timeout = 1
    test_request.headers = { "Content-Type" => "text/xml" }
    test_request.body = xml
    test_response = HTTPI.post(test_request)
    render :text => "Check server log for result of request to #{recurly_push_url}"
  rescue HTTPClient::ReceiveTimeoutError
    logger.info "Testing push notification listener: sent XML to #{recurly_push_url}"
    render :text => "Check server log for result of request to #{recurly_push_url}"
end



def push_successful_payment
    notification = Hash.from_xml(request.body())
    render :text => "Request accepted."
    if notification.has_key?('successful_payment_notification')
      @uuid = notification['successful_payment_notification']['transaction']['subscription_id']
 
      #now we can search by uuid because the account has been created
      successful_subscription = Subscription.where(:uuid => @uuid).last
      successful_subscription.active unless successful_subscription.nil?

    end
  rescue Recurly::Resource::NotFound => e
    logger.error "Recurly: #{e.message}"
  rescue ActiveRecord::RecordNotFound => e
    logger.error "Customer record not found: #{e.message}"
  end

  def test_successful_payment
    xml = <<XML
<successful_payment_notification>
  <account>
    <account_code>1</account_code>
    <username nil="true">verena</username>
    <email>verena@example.com</email>
    <first_name>Verena</first_name>
    <last_name>Example</last_name>
    <company_name nil="true">Company, Inc.</company_name>
  </account>
  <transaction>
    <id>a5143c1d3a6f4a8287d0e2cc1d4c0427</id>
    <invoice_id>1974a09kj90s0789dsf099798326881c</invoice_id>
    <invoice_number type="integer">2059</invoice_number>
    <subscription_id>8047cb4fd5f874b14d713d785436ebd3</subscription_id>
    <action>purchase</action>
    <date type="datetime">2009-11-22T13:10:38Z</date>
    <amount_in_cents type="integer">1000</amount_in_cents>
    <status>success</status>
    <message>Bogus Gateway: Forced success</message>
    <reference></reference>
    <cvv_result code=""></cvv_result>
    <avs_result code=""></avs_result>
    <avs_result_street></avs_result_street>
    <avs_result_postal></avs_result_postal>
    <test type="boolean">true</test>
    <voidable type="boolean">true</voidable>
    <refundable type="boolean">true</refundable>
  </transaction>
</successful_payment_notification>
XML


  test_request = HTTPI::Request.new(recurly_push_successful_payment_url)
    test_request.open_timeout = 1 # seconds
    test_request.read_timeout = 1
    test_request.headers = { "Content-Type" => "text/xml" }
    test_request.body = xml
    test_response = HTTPI.post(test_request)
    render :text => "Check server log for result of request to #{recurly_push_url}"
  rescue HTTPClient::ReceiveTimeoutError
    logger.info "Testing push notification listener: sent XML to #{recurly_push_url}"
    render :text => "Check server log for result of request to #{recurly_push_url}"
  end

end