apt-get update
apt-get install -y --no-install-recommends \
build-essential \
git \
m4 \
scons \
zlib1g \
zlib1g-dev \
libprotobuf-dev \
protobuf-compiler \
libprotoc-dev \
libgoogle-perftools-dev \
python3-dev \
python3-pip \
libboost-all-dev \
wget

pip3 install six
pip3 install numpy matplotlib pandas seaborn scipy openpyxl xlrd

git clone https://gem5.googlesource.com/public/gem5
cd gem5

scons build/X86/gem5.opt -j$(nproc)
scons -C util/m5 build/x86/out/m5

echo "Build complete. Binary located at: gem5/build/ALL/gem5.opt"