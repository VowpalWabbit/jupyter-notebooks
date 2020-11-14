FROM python:3.7-slim

# Install jupyter, matplotlib and vowpalwabbit
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook==5.* matplotlib pandas vowpalwabbit==8.9.0 numpy sklearn

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
