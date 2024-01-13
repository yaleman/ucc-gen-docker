FROM python:3.9-slim

ARG UCC_PACKAGE=splunk-add-on-ucc-framework
ENV UCC_PACKAGE=${UCC_PACKAGE}

RUN apt-get update && \
    apt-get install -y \
        make \
        jq \
        git \
         && apt-get clean
RUN python3 -m venv /venv
RUN echo "Installing ${UCC_PACKAGE}"
RUN /venv/bin/python -m pip install \
    ${UCC_PACKAGE} \
    splunk-packaging-toolkit
RUN apt-get -y install make

ENV PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/venv/bin"

WORKDIR /app
ENTRYPOINT ["/bin/bash"]