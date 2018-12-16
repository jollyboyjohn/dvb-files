DVBlast is a lightweight DVB streaming app - ideal for testing new setup

CAM support is a lot more reliable than TVHeadend, so it is good to have this
for eliminating issues.

Prequisites:
- Multicast support on the host (CONFIG_IP_MULTICAST, CONFIG_IP_MROUTE)
- Multicast support on a router (IGMP snooping = off)
- Channel Mux: Frequency, symbol, polarity and DiSEqC #
- Channel ID: Service ID
- An RTP capable player (VLC)

The following command streams RAI 1 from DiSEqC feed #3:
    dvblast -f 10992160 -s 27500000 -v 13 -S 3 -c rai1-dvblast.conf

rai1-dvblast.conf:
    239.255.0.1:1234 1 8511

More details are in the shell scripts and config.

To play this stream, type the following into VLC:
    rtp://@239.255.0.1:1234
