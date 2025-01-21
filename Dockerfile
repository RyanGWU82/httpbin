FROM ubuntu:jammy

LABEL name="httpbin"
LABEL description="A simple HTTP service."

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV HOME=/httpbin

WORKDIR /httpbin

RUN apt-get update -y && apt-get install python3-pip libssl-dev libffi-dev git libcap2-bin -y

ADD . .

ENV PATH="/httpbin/.local/bin:$PATH"

RUN pip3 install --no-cache-dir pipenv
RUN pipenv sync

CMD ["pipenv", "run", "gunicorn", "-b", "127.0.0.1:$PORT", "httpbin:app", "-k", "gevent"]
