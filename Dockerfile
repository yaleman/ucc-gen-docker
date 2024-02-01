FROM python:3.9-slim

ARG UCC_PACKAGE=splunk-add-on-ucc-framework
ENV UCC_PACKAGE=${UCC_PACKAGE}

COPY install_package.sh /install_package.sh
COPY parse_package_ref.py /parse_package_ref.py
RUN chmod +x /install_package.sh /parse_package_ref.py

RUN python3 -m venv /venv
RUN echo "Installing ${UCC_PACKAGE}"

RUN /venv/bin/python -m pip install splunk-packaging-toolkit
RUN ./install_package.sh "${UCC_PACKAGE}"

RUN echo "${UCC_PACKAGE}" > /ucc_package.txt

RUN apt-get -y install make

# clean up apt cache
RUN apt-get clean
# clean up yarn cache
RUN rm -rf /usr/local/share/.cache/
ENV PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/venv/bin"

WORKDIR /app
ENTRYPOINT ["/bin/bash"]