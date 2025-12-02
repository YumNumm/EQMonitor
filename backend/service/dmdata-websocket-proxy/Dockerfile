FROM debian:12-slim AS core

RUN apt-get update  \
    && apt-get -y --no-install-recommends install  \
        # install any other dependencies you might need
        sudo curl git ca-certificates build-essential \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV MISE_DATA_DIR="/mise"
ENV MISE_CONFIG_DIR="/mise"
ENV MISE_CACHE_DIR="/mise/cache"
ENV MISE_INSTALL_PATH="/usr/local/bin/mise"
ENV PATH="/mise/shims:$PATH"

RUN curl https://mise.run | sh

RUN pnpm config set store-dir ~/.pnpm-store

# Prune projects
FROM base AS pruner
ARG PROJECT

WORKDIR /app
COPY . .
RUN turbo prune --scope=${PROJECT} --docker

# Build the project
FROM base AS builder
ARG PROJECT

WORKDIR /app

# Copy lockfile and package.json's of isolated subworkspace
COPY --from=pruner /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=pruner /app/out/pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY --from=pruner /app/out/json/ .

# First install the dependencies (as they change less often)
RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm install --frozen-lockfile

# Copy source code of isolated subworkspace
COPY --from=pruner /app/out/full/ .

RUN turbo build --filter=${PROJECT}
RUN --mount=type=cache,id=pnpm,target=~/.pnpm-store pnpm prune --prod --no-optional
RUN rm -rf ./**/*/src

# Final image
FROM core AS runner
ARG PROJECT

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs
USER nodejs

WORKDIR /app
COPY --from=builder --chown=nodejs:nodejs /app .
WORKDIR /app/services/${PROJECT}

ARG PORT=8080
ENV PORT=${PORT}
ENV NODE_ENV=production
EXPOSE ${PORT}

CMD ["node", "dist/index.js"]
