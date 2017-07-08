FROM debian:stretch-slim

MAINTAINER Eric Goller

RUN apt-get update -qq
RUN apt-get install --no-install-recommends -y git python-setuptools python-pip python-dev python3-dev build-essential python-wheel xvfb xauth curl locales
RUN locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

WORKDIR /hamster-gtk
RUN apt-get install --no-install-recommends -y gir1.2-pango-1.0 gir1.2-gtk-3.0 libglib2.0-dev libgtk-3-dev python-gi python3-gi python-cairo python-gi-cairo
RUN git clone https://github.com/projecthamster/hamster-gtk.git
WORKDIR /hamster-gtk/hamster-gtk
RUN git checkout feature/activate_unit_tests_on_travis
RUN pip install --upgrade pip
RUN pip install -r requirements/test.pip
RUN python setup.py install
RUN make resources

