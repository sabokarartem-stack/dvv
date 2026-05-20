require "test_helper"

class HelloTest < ActionDispatch::IntegrationTest
  test "should get hello endpoint and return success" do
    get "/hello"

    # Перевіряємо, чи статус 200 OK
    assert_response :success

    # Перевіряємо, чи у відповіді є потрібний JSON
    assert_includes response.body, "status"
    assert_includes response.body, "success"
  end
end
