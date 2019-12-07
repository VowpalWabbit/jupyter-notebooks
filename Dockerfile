FROM python:3.7-slim

# Install dependencies for VowpalWabbit
RUN apt update && apt install -y libboost-dev libboost-program-options-dev libboost-system-dev \
 libboost-thread-dev libboost-math-dev libboost-test-dev zlib1g-dev cmake g++ libboost-python-dev \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}

# Install jupyter, matplotlib and vowpalwabbit
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook==5.* matplotlib pandas vowpalwabbit==8.8.0 numpy sklearn

# Create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Copy contents of repo to home
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR ${HOME}
USER ${USER}
