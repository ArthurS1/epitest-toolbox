from registry.fedoraproject.org/fedora:32

# Toolbox necessary headers
env NAME=fedora-epitest-toolbox VERSION=32
label com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      com.redhat.component="$NAME" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Base image for creating Epitest toolbox containers" \
      maintainer="Arthur Soulié EPITECH promotion 2024 <arthur.soulie@tuta.io>"

copy README.md /

# Packages needed by toolbox
run dnf -y install passwd
run dnf -y install figlet

# Epitest
copy epitech-extra-packages /

run dnf -y upgrade
run dnf -y install dnf-plugins-core
run dnf -y --refresh install $(<epitech-extra-packages)
run dnf clean all

run python3 -m pip install --upgrade pip \
    && python3 -m pip install -Iv gcovr==4.2 conan==1.31.2 pycrypto==2.6.1 requests==2.24.0 pyte==0.8.0 numpy==1.19.2 \
    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.10.0.9-0.fc32.x86_64/bin/java \
    && alternatives --set javac /usr/lib/jvm/java-11-openjdk-11.0.10.0.9-0.fc32.x86_64/bin/javac \
    && cd /tmp \
    && rpm -ivh https://github.com/samber/criterion-rpm-package/releases/download/2.3.3/libcriterion-devel-2.3.3-2.el7.x86_64.rpm \
    && cd /tmp \
    && curl -sSL "https://github.com/sbt/sbt/releases/download/v1.3.13/sbt-1.3.13.tgz" | tar xz \
    && mv /tmp/sbt /usr/local/share \
    && ln -s '/usr/local/share/sbt/bin/sbt' '/usr/local/bin' \
    && wget https://downloads.gradle-dn.com/distributions/gradle-6.6.1-bin.zip \
    && mkdir /opt/gradle && unzip -d /opt/gradle gradle-6.6.1-bin.zip && rm -f gradle-6.6.1-bin.zip \
    && curl -sSL https://get.haskellstack.org/ | sh

copy fs /

env LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PATH="${PATH}:/opt/gradle/gradle-6.6.1/bin"

run cd /tmp \
    && bash build_csfml.sh \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp

run figlet -w 100 EPITEST-TOOLBOX && echo "use 'toolbox -i create epitest-toolbox' to create a toolbox from it"

cmd /bin/sh
