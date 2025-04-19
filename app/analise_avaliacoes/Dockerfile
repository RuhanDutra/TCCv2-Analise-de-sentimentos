# Fase base com a imagem Ruby
ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION-slim AS base

# Definir diretório de trabalho
WORKDIR /app

# Instalar pacotes necessários
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Definir variáveis de ambiente para o Rails
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production test"

# Fase de build: instalar dependências do Ruby (gems)
FROM base AS build

# Instalar pacotes de build necessários
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    pkg-config \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copiar os arquivos de Gemfile e Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar gems necessárias
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copiar o código do aplicativo
COPY . .

# Fase final para a imagem de produção
FROM base AS final

# Copiar gems e código para a imagem final
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /app /app

# Criar o usuário 'rails' para rodar a aplicação com menos privilégios
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /app/db /app/log /app/storage /app/tmp

# Definir o usuário como 'rails' para execução da aplicação
USER rails

# Definir ponto de entrada (entrypoint) para a preparação do banco de dados
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Expor a porta 3000 para acessar o servidor Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
