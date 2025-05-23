FROM rust:1.87.0

RUN  apt-get update \
  && apt-get install -y build-essential git curl wget clang \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/zorp-corp/nockchain.git

WORKDIR nockchain

RUN sed -i "s|^export MINING_PUBKEY .=.*$|export MINING_PUBKEY ?= 2yxpbfDQmM884oq2xsYEmQN1ubr7CFEqQAomvAsnfAahHbyJwgn4BzyJxFmJrC2kemWfiK9YBXShzJMULkMzq1Hyb6GLp9Mp1P8nqopq4ZCzEBTKNPfKstAwHpZrgYKULV7G|" Makefile
RUN mv .env_example .env
RUN sed -i "s|^MINING_PUBKEY=.*$|MINING_PUBKEY=2yxpbfDQmM884oq2xsYEmQN1ubr7CFEqQAomvAsnfAahHbyJwgn4BzyJxFmJrC2kemWfiK9YBXShzJMULkMzq1Hyb6GLp9Mp1P8nqopq4ZCzEBTKNPfKstAwHpZrgYKULV7G|" .env

RUN make install-hoonc
RUN make build
RUN make install-nockchain-wallet
RUN make install-nockchain

CMD [ "make", "run-nockchain" ]
