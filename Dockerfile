# Stage 1: Build Stage
FROM ghcr.io/msd-live/jupyter/datascience-notebook:latest as builder

USER root

RUN apt-get update

# Install cerf
RUN pip install --upgrade pip
RUN pip install cerf

# Stage 2: Final Stage
FROM ghcr.io/msd-live/jupyter/datascience-notebook:latest

USER root

RUN apt-get update

# Copy python packages installed/built from the builder stage
COPY --from=builder /opt/conda/lib/python3.11/site-packages /opt/conda/lib/python3.11/site-packages

# To test this container locally, run:
# docker build -t im3sfa/cerf-msdlive .
# docker run --rm -p 8888:8888 im3sfa/cerf-msdlive

# RUN mkdir -p /data
COPY notebooks /home/jovyan/notebooks
RUN rm -rf /opt/conda/lib/python3.11/site-packages/cerf/data
RUN ln -s /data /opt/conda/lib/python3.11/site-packages/cerf/data
