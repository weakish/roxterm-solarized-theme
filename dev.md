# Dev Notes

## Virtual Linux Machine under macOS

Personally I use Orb and XQuartz to run roxterm in Ubuntu VM.

```sh
# Install Orb and XQuartz under macOS
brew install orbstack xquartz
# logout then login to allow `DISPLAY` for XQuartz to take effect.

orb create ubuntu
ssh orb

# Setup openssh since orb's built-in ssh does not support X11 forwarding.
user@ubuntu:~$ cat ~/.ssh/id_ed25519.pub > ~/.ssh/authorized_keys
user@ubuntu:~$ touch ~/.Xauthority
user@ubuntu:~$ sudo apt install openssh-server
# change port from 22 to 2222
user@ubuntu:~$ sudo mkdir -p /etc/systemd/system/ssh.socket.d/
user@ubuntu:~$ sudo tee -a /etc/systemd/system/ssh.socket.d/listen.conf >/dev/null <<EOF
[Socket]
ListenStream=
ListenStream=2222
EOF
user@ubuntu:~$ exit
# restart ubuntu
orb restart ubuntu

# Ensure ssh (remote login) is turned off in System Preferences -> Sharing.
# Otherwise, the following command will log into MacOS itself instead.
ssh -Y -p 2222 127.0.0.1

# Install roxterm from PPA
user@ubuntu:~$ sudo apt install -y software-properties-common
user@ubuntu:~$ sudo add-apt-repository ppa:h-realh/roxterm
user@ubuntu:~$ sudo apt install -y roxterm

# Use orb pull/push to copy roxterm-solarized-theme from macOS
user@ubuntu:~$ orb push /PATH/TO/roxterm-solarized-theme
user@ubuntu:~$ cd roxterm-solarized-theme
user@ubuntu:~/roxterm-solarized-theme$ make install
user@ubuntu:~/roxterm-solarized-theme$ roxterm
```

### Devuan

Systemd haters can use Devuan instead of Ubuntu.
Differences:

- Change ssh port via `/etc/ssh/sshd_config` instead.

- Make sure `sshd` (openssh) will be started at boot time.

- Install roxterm from Ubuntu PPA with the corresponding Ubuntu version.

    For example, Devuan Daedalus 5.0 stable is based on Debian Bookworm,
    which corresponds to Ubuntu 22.04 `jammy`.

    Fetch the gpg key of Ubuntu PPA:

    ```sh
    sudo mkdir -m 0755 -p /etc/apt/keyrings/
    gpg --keyserver keyserver.ubuntu.com --recv-keys BA0835874C32D80B --dearmour |
    sudo tee /etc/apt/keyrings/roxterm-keyring.gpg >/dev/null
    sudo chmod 0644 /etc/apt/keyrings/roxterm-keyring.gpg
    ```

    Add the following line to `/etc/apt/sources.list`:

    ```
    deb [signed-by=/etc/apt/keyrings/roxterm-keyring.gpg] https://ppa.launchpadcontent.net/h-realh/roxterm/ubuntu jammy main
    ```

    Note that `signed-by` is specified to avoid trusting the gpg key globally for all repositories,
    which is why the deprecated way `apt-key add` is not used.

    Then install roxterm via `apt` as usual:

    ```sh
    sudo apt update
    sudo apt install roxterm
    ```

- In the above step, if you encountered the following error via fetching gpg key:

    ```
    gpg: keyserver receive failed: No route to host
    ```

    Then it is likely that gpg decides to use IPv6, but your machine has incomplete IPv6 support.
    For workarounds, see [here](https://github.com/rvm/rvm/issues/4215).

- You may need to install `gsettings-desktop-schemas` via `apt` manually.
  Otherwise, `roxterm` may fail to start.
