# frozen_string_literal: true

RSpec.shared_context 'with authenticated user' do
  let(:admin_user) { create(:user) }
  let(:default_headers) do
    {
      'x-authorization' => JWT.encode(
        { data: { user_id: admin_user.id, user_email: admin_user.email } },
        nil,
        'none'
      )
    }
  end
end
