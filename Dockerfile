# Етап 1: Збірка (Builder stage)
FROM ruby:3.2.2-slim AS builder

# Встановлюємо системні залежності для збірки gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential pkg-config

WORKDIR /app

# Копіюємо файли конфігурації залежностей
COPY Gemfile Gemfile.lock ./

# Встановлюємо gems
RUN bundle install --jobs 4 --retry 3

# Етап 2: Фінальний мінімальний образ (Production stage)
FROM ruby:3.2.2-slim

WORKDIR /app

# Встановлюємо мінімальні системні бібліотеки (за потреби тут можна додати клієнт для БД, напр. libsqlite3-0)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y tzdata && \
    rm -rf /var/lib/apt/lists/*

# Копіюємо встановлені залежності з першого етапу
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Копіюємо весь код застосунку
COPY . .

# Копіюємо та робимо виконуваним скрипт entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Вказуємо порт
EXPOSE 3000

# Налаштовуємо entrypoint 
ENTRYPOINT ["entrypoint.sh"]

# Команда за замовчуванням для запуску сервера
CMD ["rails", "server", "-b", "0.0.0.0"]
