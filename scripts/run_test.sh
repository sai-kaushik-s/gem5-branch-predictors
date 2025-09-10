./gem5/build/X86/gem5.opt -d output/bodytrack-small/bimodal src/benchmark.py -t bimodal -b bodytrack -s simsmall
./gem5/build/X86/gem5.opt -d output/bodytrack-small/local src/benchmark.py -t local -b bodytrack -s simsmall
./gem5/build/X86/gem5.opt -d output/bodytrack-small/tournament src/benchmark.py -t tournament -b bodytrack -s simsmall
./gem5/build/X86/gem5.opt -d output/bodytrack-small/tage src/benchmark.py -t tage -b bodytrack -s simsmall
./gem5/build/X86/gem5.opt -d output/bodytrack-small/ltage src/benchmark.py -t ltage -b bodytrack -s simsmall
./gem5/build/X86/gem5.opt -d output/bodytrack-small/perceptron src/benchmark.py -t perceptron -b bodytrack -s simsmall