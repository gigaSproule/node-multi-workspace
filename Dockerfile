FROM node as builder
WORKDIR ./node-multi-workspace
ADD . ./
RUN yarn install
RUN yarn workspace workspace-a run webpack

FROM node
ARG APP=/opt/workspace-a
ENV PORT 7000
EXPOSE 7000
RUN mkdir -p ${APP}
COPY --from=builder /node-multi-workspace/workspace-a/dist ${APP}/dist
WORKDIR ${APP}

CMD ["node", "dist/index.js"]
