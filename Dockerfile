FROM ubuntu:jammy
RUN apt-get update && apt-get upgrade -y  && apt-get install -y openssh-server
# RUN systemctl enable --now ssh
#RUN ufw allow ssh
# RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBExYjOsa987mfUqcd15bB766gF30x3TxAhKmRJKn9BL AnsibleKey" >> ~/.ssh/authorized_keys
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
# --- FIX STARTS HERE ---
# Create the .ssh directory for the root user if it doesn't exist
# The -p flag ensures that parent directories are also created if needed
RUN mkdir -p /root/.ssh/

# Set strict permissions for the .ssh directory (read, write, execute for owner only)
# SSH requires these strict permissions for security
RUN chmod 700 /root/.ssh/

# Add the provided SSH public key to the authorized_keys file for the root user
# This allows passwordless SSH login with the corresponding private key
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBExYjOsa987mfUqcd15bB766gF30x3TxAhKmRJKn9BL AnsibleKey" >> /root/.ssh/authorized_keys

# Set strict permissions for the authorized_keys file (read, write for owner only)
# SSH requires these strict permissions
RUN chmod 600 /root/.ssh/authorized_keys
# --- FIX ENDS HERE ---


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

