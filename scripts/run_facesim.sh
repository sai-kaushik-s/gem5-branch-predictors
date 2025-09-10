./gem5/build/X86/gem5.opt -d output/facesim-small/bimodal src/benchmark.py -t bimodal -b facesim -s simsmall
./gem5/build/X86/gem5.opt -d output/facesim-small/local src/benchmark.py -t local -b facesim -s simsmall
./gem5/build/X86/gem5.opt -d output/facesim-small/tournament src/benchmark.py -t tournament -b facesim -s simsmall
./gem5/build/X86/gem5.opt -d output/facesim-small/ltage src/benchmark.py -t ltage -b facesim -s simsmall
./gem5/build/X86/gem5.opt -d output/facesim-small/tage src/benchmark.py -t tage -b facesim -s simsmall
./gem5/build/X86/gem5.opt -d output/facesim-small/perceptron src/benchmark.py -t perceptron -b facesim -s simsmall