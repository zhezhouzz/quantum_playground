From ocaml/opam:debian-ocaml-5.0
RUN sudo apt-get update
RUN sudo apt-get install -y python3 python3-pip
RUN sudo apt-get install -y libgmp-dev
RUN sudo apt-get install -y vim
RUN opam init --auto-setup
RUN opam install ocolor.1.3.0
SHELL ["/bin/bash", "-lc"]
RUN eval $(opam env)
RUN git clone https://github.com/zhezhouzz/quantum_playground.git
WORKDIR quantum_playground
