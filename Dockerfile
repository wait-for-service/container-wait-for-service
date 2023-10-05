FROM python:3.12.0-alpine3.18
ARG USER_NAME=ws
ARG USER_ID=10001
ARG GROUP_NAME=ws
ARG GROUP_ID=10001
ARG PROFILE
WORKDIR /opt/s3proxy

USER root
RUN mkdir /work;\
    addgroup --gid "${GROUP_ID}" "${GROUP_NAME}";\
    adduser --disabled-password --gecos "" --home "/work" --ingroup "$USER_NAME" --no-create-home --uid "$USER_ID" "$USER_NAME"
COPY requirements-${PROFILE}.txt /requirements.txt
RUN pip3 install --no-cache-dir -r /requirements.txt


USER ${USER_NAME}

#checkov:skip=CKV_DOCKER_2: Health check is external 
ENTRYPOINT ["wait-for-service"]