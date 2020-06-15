###### 
# Future Releases should include
# Password Change of Jupyter Hub
#
#####

FROM centos:centos7

ARG MAPR_VERSION_CORE="6.1.0"
ARG MAPR_VERSION_MEP="6.3.0"
ARG MAPR_REPO_ROOT="https://package.mapr.com/releases"

LABEL mapr.os=centos7 mapr.version=$MAPR_VERSION_CORE mapr.mep_version=$MAPR_VERSION_MEP

ENV container docker

RUN yum install -y curl initscripts net-tools sudo wget which syslinux openssl file java-1.8.0-openjdk-devel unzip python3-pip.noarch python3-devel gcc sshpass git-all bzip2 python3-crypto python3-psutil glibc-locale-source


RUN mkdir -p /opt/mapr/installer/docker/ && \
    wget "${MAPR_REPO_ROOT}/installer/redhat/mapr-setup.sh" -P /opt/mapr/installer/docker/ && \
    chmod +x /opt/mapr/installer/docker/mapr-setup.sh

RUN /opt/mapr/installer/docker/mapr-setup.sh -r "$MAPR_REPO_ROOT" container client "$MAPR_VERSION_CORE" "$MAPR_VERSION_MEP" mapr-client mapr-hbase mapr-spark mapr-kafka mapr-livy




#### Install Kubectl

RUN echo '[kubernetes]'  > /etc/yum.repos.d/kubernetes.repo
RUN echo 'name=Kubernetes'  >> /etc/yum.repos.d/kubernetes.repo
RUN echo 'baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64'  >> /etc/yum.repos.d/kubernetes.repo
RUN echo 'enabled=1'  >> /etc/yum.repos.d/kubernetes.repo
RUN echo 'gpgcheck=1'  >> /etc/yum.repos.d/kubernetes.repo
RUN echo 'repo_gpgcheck=1'  >> /etc/yum.repos.d/kubernetes.repo
RUN echo 'gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg'  >> /etc/yum.repos.d/kubernetes.repo
RUN yum install -y kubectl

#### Install kubectx

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx &&  ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && ln -s /opt/kubectx/kubens /usr/local/bin/kubens

RUN cd /opt/ && curl -k https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash 

RUN pip3 --no-cache-dir install matplotlib numpy pandas wheel psutil  
RUN pip3 install --upgrade git+https://github.com/hpe-container-platform-community/hpecp-client@master

RUN rm /etc/yum.repos.d/mapr_*.repo && \
    yum -q clean all && \
    rm -rf /var/lib/yum/history/* && \
    find /var/lib/yum/yumdb/ -name origin_url -exec rm {} \;

RUN  rm -rf /var/cache/yum

ENV NB_USER hpecp
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
ENV NB_PASSWORD hpecp

RUN useradd \
    -c "Default user" \
        -d /home/${NB_USER} \
    -u ${NB_UID} \
    ${NB_USER}
RUN chown -R ${NB_USER} ${HOME}


USER ${NB_USER}
RUN pip3 install --no-cache-dir --user matplotlib numpy pandas wheel psutil

RUN pip3 install --no-cache-dir --user  requests-ftp
RUN pip3 install --no-cache-dir --user wrapt
RUN pip3 install --no-cache-dir --user lxml

RUN pip3 install --no-cache-dir --user jupyterlab
RUN pip3 install --no-cache-dir --user notebook

RUN cd /home/${NB_USER} 
RUN pip3 install --no-cache-dir --user bash_kernel
RUN python3 -m bash_kernel.install
RUN pip3 install --no-cache-dir --user jupyter_contrib_nbextensions
RUN /home/${NB_USER}/.local/bin/jupyter nbextensions_configurator enable --user
RUN /home/${NB_USER}/.local/bin/jupyter contrib nbextension install --user
RUN /home/${NB_USER}/.local/bin/jupyter nbextension enable toc2/main
RUN /home/${NB_USER}/.local/bin/jupyter nbextension enable execute_time/ExecuteTime
RUN mkdir /home/${NB_USER}/data
#CMD cd /home/${NB_USER} && /home/${NB_USER}/.local/bin/jupyter-notebook --ip 0.0.0.0 --NotebookApp.password='sha1:30623dd781fc:fbc1f26b4d7724276a33755eafbcf610d688762c'
CMD cd /home/${NB_USER}/data; git clone https://github.com/hpe-container-platform-community-demos/hpecp-tutorialbox-demo && /home/${NB_USER}/.local/bin/jupyter lab --ip 0.0.0.0 --NotebookApp.password='sha1:30623dd781fc:fbc1f26b4d7724276a33755eafbcf610d688762c'

EXPOSE 8888 80 
