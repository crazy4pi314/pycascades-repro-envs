FROM "ubuntu" as canadian
# get it? it curls!

USER root
RUN apt update && apt install -y curl
RUN curl -L https://nixos.org/nix/install -o /root/nix-install

FROM "alpine"

ENV USER=devcontainer

USER root
RUN adduser -D -s /bin/sh ${USER} && mkdir /nix && chown ${USER} /nix
RUN apk update && apk add sudo shadow xz git

USER ${USER}
COPY --from=canadian /root/nix-install /home/${USER}/nix-install
RUN /bin/sh /home/${USER}/nix-install --no-daemon && rm /home/${USER}/nix-install

ENV PATH=$PATH:/home/${USER}/.local/state/nix/profiles/profile/bin
ADD default.nix /home/${USER}/default.nix

# Cache default environment
WORKDIR /home/${USER}
RUN nix-build /home/${USER}/default.nix

# Make a symlink for vscode to find python
RUN ln -s $(nix-shell /home/${USER}/default.nix --command "which python") /home/${USER}/nix-python

ENTRYPOINT [ "/bin/sh", "-c", "nix-shell /home/devcontainer/default.nix" ]
