FROM kasmweb/ubuntu-jammy-desktop:1.14.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########




######### Install Google Chrome ###########
RUN apt-get update && apt-get install -y wget
# Download Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# Install Google Chrome
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install
# Clean up
RUN rm google-chrome-stable_current_amd64.deb
# Shortcut for google on desktop
RUN echo '[Desktop Entry]\nVersion=1.0\nName=Google Chrome\nExec=/usr/bin/google-chrome-stable %U\nTerminal=false\nIcon=google-chrome\nType=Application\nCategories=Network;WebBrowser;\nMimeType=text/html;text/xml;application/xhtml_xml;image/webp;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;' > /usr/share/applications/google-chrome.desktop


######### Install Visual Studio Code ###########
# Download Visual Studio Code
RUN wget -q https://packages.microsoft.com/repos/vscode/pool/main/c/code/code_1.63.2-1648564672_amd64.deb
# Install Visual Studio Code
RUN dpkg -i code_1.63.2-1648564672_amd64.deb; apt-get -fy install
# Clean up
RUN rm code_1.63.2-1648564672_amd64.deb
# Shortcut for vscode on desktop
RUN echo '[Desktop Entry]\nName=Visual Studio Code\nComment=Code Editing. Redefined.\nExec=/usr/bin/code --unity-launch %F\nIcon=code\nType=Application\nStartupNotify=false\nStartupWMClass=Code\nCategories=Utility;TextEditor;Development;IDE;\nMimeType=text/plain;inode/directory;\nActions=new-empty-window;\nKeywords=vscode;' > /usr/share/applications/vscode.desktop



######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000