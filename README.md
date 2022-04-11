# W202-Final

# Current Status
- I was unable to get a custom solution that leverages the Libp2p library fully functional in the time allowed
- Howerver, I did find an implementation, that is very similar, developed by Protocol Labs
  - Meant to be used as a lightweight vpn, but can serve the function we need
  - Link: https://github.com/hyprspace/hyprspace
- I've built a lab for testing - Terraform script attached
  - See LabSetup.md for instructions

# Ideas Moving Forward
- Focus on the distributed nature of the network
- Explore the cryptographic functions leveraged to secure communications
  -  https://docs.libp2p.io/concepts/protocols/ - Explains encryption protocols utilized 
  -  https://blog.ipfs.io/2020-08-07-deprecating-secio/ - Explains why they use the current Noise Framework and TLS 1.3
  -  https://github.com/libp2p/specs/tree/master/tls - Links to TLS implementation information
  -  https://github.com/libp2p/specs/tree/master/noise - Link to Noise Secure Channel Framework implementation information
  -  Perhaps the implication that it's support for TLS 1.3 could allow it to be quantum resistant by leveraging libraries such as  WolfSSL using NTRU
-  Investigate the effects of the traffic encryption 
  -  Latency or broken protocols - In the lab on the Linux boxes
-  Discuss potential for secure intranetworking in areas that require a heightened security
  -  What attacks does this prevent
    -  Rogue devices sniffing network traffic
    -  NTLM Relay attacks
    -  Anything that requires capturing an handshake
    -  MitM in general
  -  Does pose its own risks - https://docs.libp2p.io/concepts/security-considerations/    
-  Perhaps even looking at the benefits of Peer-to-Peer netowkring on IoT and how this could increase security - https://github.com/libp2p/specs/blob/master/ROADMAP.md#%F0%9F%92%A1-libp2p-in-iot
-  Look at influence on cryptocurrency - https://www.parity.io/blog/why-libp2p


It's not a direct correlation, but it is similar to this prompt from the project's list: 

- *Hybrid DHEC and PQ Key Exchange:*

  *Research an experimental library that does hybrid DHEC and PQ asymmetric key exchange and/or create a 
  simple jupyter notebook of your own to demonstrate and explain the advantages and disadvantages of doing 
  it both ways.*
