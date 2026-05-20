# frozen_string_literal: true

class HelloController < ApplicationController
  def index
    # Читаємо секрет із захищених змінних середовища AWS
    secret_key = ENV['API_SECRET_KEY'] || 'Секрет не знайдено!'

    render json: {
      status: 'success',
      message: 'Hello from Ruby on Rails on AWS Elastic Beanstalk!',
      secret: secret_key
    }
  end
end
