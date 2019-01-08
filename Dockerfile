FROM ubuntu:xenial
MAINTAINER K <l0rda@l0rda.biz>

RUN apt-get update && apt-get install -y s3cmd cron ssh tzdata rsync

ADD /scripts /dockup/
RUN chmod 755 /dockup/*.sh

ENV TZ 'UTC'

ENV S3_BACKUP false
ENV SCP_BACKUP false
ENV RSYNC_BACKUP false
# rsync run over ssh and use same vars

ENV S3_BUCKET_NAME container-backup
ENV AWS_ACCESS_KEY_ID **DefineMe**
ENV AWS_SECRET_ACCESS_KEY **DefineMe**
ENV S3_HOST s3.amazonaws.com
ENV S3_HOST_BUCKET %(bucket)s.s3.amazonaws.com
ENV AWS_DEFAULT_REGION us-east-1
ENV S3_SSL true
ENV PATHS_TO_BACKUP auto
ENV BACKUP_NAME backup
ENV RESTORE false
ENV RESTORE_TAR_OPTION --preserve-permissions
ENV NOTIFY_BACKUP_SUCCESS false
ENV NOTIFY_BACKUP_FAILURE false
ENV BACKUP_TAR_TRIES 5
ENV BACKUP_TAR_RETRY_SLEEP 30
ENV SSH_HOST rsync.example.com
ENV SSH_USER user
ENV SSH_PORT 22
# you need to mount ssh private key file to /mnt/dockup/ssh.key
#ENV SSH_PASSWORD ""
ENV SSH_TARGET /path/where/store/backup
ENV VERBOSE false

WORKDIR /dockup
CMD ["./run.sh"]
