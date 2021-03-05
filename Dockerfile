FROM dinghao188/rcore-tutorial:latest
LABEL Name=dockerfile Version=0.0.1


# ENV http_proxy="$PROXY_HTTP"\
# 	&&HTTP_PROXY="$PROXY_HTTP"\
# 	&&https_proxy="$PROXY_HTTPS"\
	# &&HTTPS_proxy="$PROXY_HTTPS"

COPY ./sources.list /etc/apt/sources.list

RUN cat /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/*
RUN apt-get update

RUN apt install -y zsh vim
# RUN git config --global http.proxy "$PROXY_HTTP" \
	# && git config --global https.proxy "$PROXY_HTTPS" \
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
	&& git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime\
	&& cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
	&& sh ~/.vim_runtime/install_awesome_vimrc.sh
# RUN git config --global http.proxy "$PROXY_HTTP" \
	# && git config --global https.proxy "$PROXY_HTTPS" \
RUN cd /root/.oh-my-zsh/plugins\
	&& git clone https://github.com/zsh-users/zsh-autosuggestions\
	&& git clone https://github.com/zsh-users/zsh-syntax-highlighting

SHELL [ "/bin/zsh", "-c"]
COPY .zshrc /root/.zshrc
RUN source /root/.zshrc
RUN export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
RUN export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
RUN curl https://sh.rustup.rs -sSf -y | sh
RUN source /root/.cargo/env
ENV PATH="/root/.cargo/bin:${PATH}"
COPY config /root/.cargo/config
# RUN git config --global http.proxy "$PROXY_HTTP" \
	# && git config --global https.proxy "$PROXY_HTTPS" \
RUN cd /root/rCore-Tutorial-v3/os \
	&& make build
CMD ["zsh"]