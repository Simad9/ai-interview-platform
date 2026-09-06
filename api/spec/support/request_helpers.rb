# frozen_string_literal: true

module RequestHelpers
  def json_body
    JSON.parse(response.body)
  end

  # Default tenant header mirrors the seeded 'test-corp' organization. Override
  # via `headers` to test other schemes.
  def post_signup(attrs = {}, headers = {})
    post '/api/v1/auth/signup', params: attrs, headers: tenant_headers.merge(headers)
  end

  def post_login(attrs = {}, headers = {})
    post '/api/v1/auth/login', params: attrs, headers: tenant_headers.merge(headers)
  end

  private

  def tenant_headers
    { 'X-Tenant-Scheme' => 'test-corp' }
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
end
