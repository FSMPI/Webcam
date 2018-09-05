FROM centos:centos7

WORKDIR /tmp
RUN yum install -y epel-release
RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
RUN yum install -y ffmpeg
#RUN ffmpeg -f mjpeg -i "http://webcam:fsmpi@olaf.fs.uni-bayreuth.de/video.cgi" -vcodec mpeg4 -b 1000000 -pix_fmt yuv420p /tmp/video_file.avi
#RUN 'lpadmin -p drucker_fsmpi -E -v socket://192.168.1.17:9100'

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

#RUN ./entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
