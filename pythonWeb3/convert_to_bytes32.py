
data = "education"
print("0x" + data.encode("utf-8").hex().ljust(64, '0')) 

#  education: 0x656475636174696f6e0000000000000000000000000000000000000000000000



myint = (1).to_bytes(32, byteorder='big')
print("0x" + myint.hex())

# 10: ox000000000000000000000000000000000000000000000000000000000000000a
# 1 : 0x0000000000000000000000000000000000000000000000000000000000000001




