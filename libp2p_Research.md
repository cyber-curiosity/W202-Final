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
- Allows for the use of several algorithms for signing:
  - RSA
  - ECDSA
  - Ed25519
  - Secp256k1
  - etc
- TLS Allows for use of many encryption algorithms:
  - Camellia
  - ARIA
  - AES
  - etc
- TLS 1.3 limits to only 5 cipher suites 
  - TLS_AES_128_GCM_SHA256
  - TLS_AES_256_GCM_SHA384
  - TLS_CHACHA20_POLY1305_SHA256
  - TLS_AES_128_CCM_SHA256
  - TLS_AES_128_CCM_8_SHA256
- Extensibility allows for implementation of post-quantum algorithms
  - AWS is leveraging [post-quantum s2n](https://github.com/aws/s2n-tls/tree/main/pq-crypto) 
  - Perhaps even [WolfSSL](https://www.wolfssl.com/hybrid-post-quantum-groups-tls-1-3/)

- Padding
  - Generally applies PKCS#7 padding   

**From the Documentation**
// We want nodes without AES hardware (e.g. ARM) support to always use ChaCha.

// Only if both nodes have AES hardware support (e.g. x86), AES should be used.

// x86->x86: AES, ARM->x86: ChaCha, x86->ARM: ChaCha and ARM->ARM: Chacha

// This function returns true if we don't have AES hardware support, and false otherwise.

// Thus, ARM servers will always use their own cipher suite preferences (ChaCha first),

// and x86 servers will aways use the client's cipher suite preferences.



