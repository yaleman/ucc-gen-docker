FROM python:3.9-slim

RUN apt-get update && \
    apt-get install -y \
        make \
        jq \
         && apt-get clean
RUN python3 -m venv /venv
RUN /venv/bin/python -m pip install \
    splunk-add-on-ucc-framework \
    splunk-packaging-toolkit
RUN apt-get -y install make

ENV PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/venv/bin"

WORKDIR /app
ENTRYPOINT ["/bin/bash"]