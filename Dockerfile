FROM python:3.11.6-alpine3.18
ARG USER_NAME=ws
ARG USER_ID=10001
ARG GROUP_NAME=ws
ARG GROUP_ID=10001
ARG PROFILE

USER root
COPY requirements-${PROFILE}.txt /requirements.txt
RUN mkdir /work;\
    addgroup --gid "${GROUP_ID}" "${GROUP_NAME}";\
    adduser --disabled-password --gecos "" --home "/work" --ingroup "$USER_NAME" --no-create-home --uid "$USER_ID" "$USER_NAME" ;\
    pip3 install --no-cache-dir -r /requirements.txt

WORKDIR /work
USER 10001

#checkov:skip=CKV_DOCKER_2: Health check is external 
ENTRYPOINT ["wait-for-service"]