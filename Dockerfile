FROM rust:1.87.0

RUN  apt-get update \
  && apt-get install -y build-essential git curl wget clang \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN git clone https://github.com/zorp-corp/nockchain.git

WORKDIR nockchain
RUN make install-hoonc
RUN make build
RUN make install-nockchain-wallet
RUN make install-nockchain

RUN sed -i "s|^export MINING_PUBKEY .=.*$|export MINING_PUBKEY ?= 2yxpbfDQmM884oq2xsYEmQN1ubr7CFEqQAomvAsnfAahHbyJwgn4BzyJxFmJrC2kemWfiK9YBXShzJMULkMzq1Hyb6GLp9Mp1P8nqopq4ZCzEBTKNPfKstAwHpZrgYKULV7G|" Makefile
RUN mv .env_example .env
RUN sed -i "s|^MINING_PUBKEY=.*$|MINING_PUBKEY=2yxpbfDQmM884oq2xsYEmQN1ubr7CFEqQAomvAsnfAahHbyJwgn4BzyJxFmJrC2kemWfiK9YBXShzJMULkMzq1Hyb6GLp9Mp1P8nqopq4ZCzEBTKNPfKstAwHpZrgYKULV7G|" .env

EXPOSE 3006/udp

CMD [ "nockchain","--mining-pubkey","2yxpbfDQmM884oq2xsYEmQN1ubr7CFEqQAomvAsnfAahHbyJwgn4BzyJxFmJrC2kemWfiK9YBXShzJMULkMzq1Hyb6GLp9Mp1P8nqopq4ZCzEBTKNPfKstAwHpZrgYKULV7G","--mine","--bind","/ip4/0.0.0.0/udp/3006/quic-v1","--npc-socket","nockchain.sock","--peer","/ip4/95.216.102.60/udp/3006/quic-v1","--peer","/ip4/65.108.123.225/udp/3006/quic-v1","--peer","/ip4/65.109.156.108/udp/3006/quic-v1","--peer","/ip4/65.21.67.175/udp/3006/quic-v1","--peer","/ip4/65.109.156.172/udp/3006/quic-v1","--peer","/ip4/34.174.22.166/udp/3006/quic-v1","--peer","/ip4/34.95.155.151/udp/30000/quic-v1","--peer","/ip4/34.18.98.38/udp/30000/quic-v1","--peer","/ip4/34.174.22.166/udp/30000/quic-v1"]
