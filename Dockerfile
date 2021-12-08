# Use the miminal-notebook as base container
ARG BASE_CONTAINER=jupyter/minimal-notebook:33add21fab64
FROM $BASE_CONTAINER

# Add permanent apt-get installs and other root commands here
# e.g., RUN apt-get install --yes --no-install-recommends npm nodejs

USER root
RUN apt update && apt install graphviz graphviz-dev python3-dev libgraphviz-dev pkg-config -y

# Switch back to jovyan to avoid accidental container runs as root
# Add permanent mamba/pip/conda installs, data files, other user libs here
# e.g., RUN pip install --quiet --no-cache-dir flake8

USER ${NB_UID}
# Copy the requirements.txt file
COPY requirements.txt requirements.txt

# Install all Python dependencies
RUN conda install --file requirements.txt


# The base container takes care of the rest.