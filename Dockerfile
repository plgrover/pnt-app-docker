# Using the Jupyter Notebook Scientific Python Stack
# FROM jupyter/scipy-notebook

FROM python:3.6.8

# https://grasswiki.osgeo.org/wiki/Compile_and_Install_Ubuntu#Quick_instructions
RUN apt-get update && apt-get install -y \
  python3-setuptools \
  python-setuptools \
  libproj-dev \
  proj-data \
  proj-bin \
  libgeos-dev \
  libgdal-dev \
  python-gdal \
  gdal-bin 

# https://stackoverflow.com/questions/22531360/no-module-named-setuptools
RUN pip install --upgrade setuptools
RUN pip install pyinstaller



COPY requirements.txt ./
RUN pip install -r requirements.txt

# Geopandas
RUN git clone https://github.com/geopandas/geopandas.git
WORKDIR "/geopandas"
RUN pip install .

# A fix https://github.com/jupyter/jupyter/issues/370
RUN pip uninstall -y ipykernel
RUN pip install ipykernel==4.8.0

WORKDIR "/"
RUN git clone https://github.com/plgrover/lmoments3.git
WORKDIR "/lmoments3"
RUN python setup.py install

WORKDIR "/"
RUN git clone https://github.com/plgrover/l-moment_tools.git

#COPY ..

