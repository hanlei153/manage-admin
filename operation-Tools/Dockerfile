FROM python:3.9-alpine3.17
MAINTAINER HANLEI
WORKDIR /opt/operation-tools
COPY . /opt/operation-tools
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
	cd /opt/operation-tools && pip3 install gunicorn && pip3 install -r requirements.txt && pip3 install flask
ENV WORKER=4 SERVER_PORT=8889
CMD ["sh", "-c", "cd /opt/operation-tools/bin && gunicorn start:server -w $WORKER -b 0.0.0.0:$SERVER_PORT"]