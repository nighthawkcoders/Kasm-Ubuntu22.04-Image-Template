FROM kasmweb/ubuntu-jammy-desktop:1.14.0-rolling
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME


# Set appropriate ownership
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

# Ensure that the correct home directory is set
ENV HOME=/home/kasm-user
WORKDIR $HOME

# Create and set permissions for the home directory if missing
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

# Switch to user 1000
USER 1000
