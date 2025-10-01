# direktori linux biasa
# ekstrak data usbhid dari file pcapng dan simpan ke csv
tshark -r hiddenmsg.pcapng -Y "usbhid.data" \
       -T fields -e frame.number -e frame.time -e usbhid.data \
       -E header=y -E separator=, > usbhid.csv