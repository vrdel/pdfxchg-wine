FROM debian:wheezy
RUN dpkg --add-architecture i386
ENV DISPLAY :0
RUN apt-get update
RUN apt-get install --assume-yes wine vim
RUN apt-cache search libwine | awk '{print $1}' | tr '\n' '\0' | xargs -0 apt-get -y install
ADD fonts.tar.bz2 /root/windows_fonts/
ADD pdfxchange_2.5.213.tar.bz /root/
COPY pdfxcview.sh /root/
CMD ["/bin/bash"]
