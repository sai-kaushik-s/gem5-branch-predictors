# ./gem5/build/X86/gem5.opt -d output/blackscholes-large/bimodal src/benchmark.py -t bimodal -b blackscholes -s simlarge
# ./gem5/build/X86/gem5.opt -d output/blackscholes-large/local src/benchmark.py -t local -b blackscholes -s simlarge
# ./gem5/build/X86/gem5.opt -d output/blackscholes-large/tournament src/benchmark.py -t tournament -b blackscholes -s simlarge
# ./gem5/build/X86/gem5.opt -d output/blackscholes-large/tage src/benchmark.py -t tage -b blackscholes -s simlarge
./gem5/build/X86/gem5.opt -d output/blackscholes-large/ltage src/benchmark.py -t ltage -b blackscholes -s simlarge
./gem5/build/X86/gem5.opt -d output/blackscholes-large/perceptron src/benchmark.py -t perceptron -b blackscholes -s simlarge

# ./gem5/build/X86/gem5.opt -d output/canneal-large/bimodal src/benchmark.py -t bimodal -b canneal -s simlarge
# ./gem5/build/X86/gem5.opt -d output/canneal-large/local src/benchmark.py -t local -b canneal -s simlarge
# ./gem5/build/X86/gem5.opt -d output/canneal-large/tournament src/benchmark.py -t tournament -b canneal -s simlarge
# ./gem5/build/X86/gem5.opt -d output/canneal-large/tage src/benchmark.py -t tage -b canneal -s simlarge
# ./gem5/build/X86/gem5.opt -d output/canneal-large/ltage src/benchmark.py -t ltage -b canneal -s simlarge
# ./gem5/build/X86/gem5.opt -d output/canneal-large/perceptron src/benchmark.py -t perceptron -b canneal -s simlarge