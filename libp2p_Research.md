# libp2p

## Purpose
- Serves as a network protocol replacement for traditional client/server infrastructure
- A modular framework for implementation of Peer-to-Peer netowrks

## Uses
- Being leveraged in the development of multiple cryptocurrencies:
  - Polkadot
  - Substrate
  - Ethereum 2.0

## Peer-to-Peer Explained
- Each peer or 'node' communicates with others equally. Some may server different roles, but there is no client/server system

## Networking
- How does it transport data from point to point?
  - Leverages existing transpor layer technologies such as IPv4, IPv6, or QUIC

## Secure Communications
- Leverages two options
  - [Noise Framework](https://github.com/libp2p/specs/tree/master/noise)
  - [TLS 1.3](https://github.com/libp2p/specs/blob/master/tls/tls.md)

## TLS 1.3
