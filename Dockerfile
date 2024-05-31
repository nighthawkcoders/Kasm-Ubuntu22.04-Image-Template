FROM kasmweb/ubuntu-jammy-desktop:1.14.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

### Envrionment config
ENV DEBUG=false \
    DEBIAN_FRONTEND=noninteractive \
    SKIP_CLEAN=true \
    KASM_RX_HOME=$STARTUPDIR/kasmrx \
    DONT_PROMPT_WSL_INSTALL="No_Prompt_please" \
    INST_DIR=$STARTUPDIR/install \
    INST_SCRIPTS="/ubuntu/install/tools/install_tools.sh \
                  /ubuntu/install/chrome/install_chrome.sh \
                  /ubuntu/install/chromium/install_chromium.sh \
                  /ubuntu/install/sublime_text/install_sublime_text.sh \
                  /ubuntu/install/slack/install_slack.sh \
                  /ubuntu/install/vs_code/install_vs_code.sh \
                  /ubuntu/install/postman/install_postman.sh \
                  /ubuntu/install/cleanup/cleanup.sh"

# Copy install scripts
COPY ./src/ $INST_DIR
# Run installations
RUN \
  for SCRIPT in $INST_SCRIPTS; do \
    bash ${INST_DIR}${SCRIPT}; \
  done && \
  rm -f /etc/X11/xinit/Xclients && \
  rm -Rf ${INST_DIR}

# post install scripts
RUN echo "Running VSCode extension install scripts"
RUN code --install-extension github.vscode-github-actions \
    code --install-extension ms-python.python \
    code --install-extension ms-azuretools.vscode-docker \
    code --install-extension ms-vscode-remote.remote-containers \
    code --install-extension VisualStudioExptTeam.vscodeintellicode \
    code --install-extension ms-toolsai.jupyter \
    code --install-extension ms-toolsai.vscode-jupyter-cell-tags \
    code --install-extension ms-toolsai.jupyter-keymap \
    code --install-extension ms-python.vscode-pylance \
    code --install-extension ms-python.debugpy \
    code --install-extension yy0931.vscode-sqlite3-editor \
    code --install-extension alexcvzz.vscode-sqlite \
    code --install-extension eamodio.gitlens

########## End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000