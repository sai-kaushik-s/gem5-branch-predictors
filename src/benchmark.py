from argparse import ArgumentParser

from m5.objects import (
    BiModeBP,
    LocalBP,
    TournamentBP,
    TAGE,
    LTAGE,
    MultiperspectivePerceptron64KB,
)
import m5.stats as stats
from gem5.components.boards.x86_board import X86Board
from gem5.components.cachehierarchies.classic.private_l1_shared_l2_cache_hierarchy import (
    PrivateL1SharedL2CacheHierarchy,
)
from gem5.components.memory.simple import SingleChannelSimpleMemory
from gem5.components.processors.cpu_types import CPUTypes
from gem5.components.processors.simple_switchable_processor import (
    SimpleSwitchableProcessor,
)
from gem5.isas import ISA
from gem5.resources.resource import KernelResource, DiskImageResource
from gem5.simulate.simulator import Simulator
from gem5.simulate.exit_event import ExitEvent


BRANCH_PREDICTORS = {
    "bimodal": BiModeBP,
    "local": LocalBP,
    "tournament": TournamentBP,
    "tage": TAGE,
    "ltage": LTAGE,
    "perceptron": MultiperspectivePerceptron64KB,
}

BENCHMARKS = [
    "blackscholes",
    "bodytrack",
    "canneal",
    "dedup",
    "facesim",
    "ferret",
    "fluidanimate",
    "freqmine",
    "raytrace",
    "streamcluster",
    "swaptions",
    "vips",
    "x264",
]
BENCHMARK_SIZES = ["simsmall", "simmedium", "simlarge"]


# Functions to handle ROI begin event and set the O3 parameters with the chosen branch predictor
def roiStart():
    print("ROI started")
    processor.switch()
    for cpu in processor.get_cores():
        cpu.core.numROBEntries = 256
        cpu.core.IQEntries = 128
        cpu.core.fetchWidth = 4
        cpu.core.decodeWidth = 4
        cpu.core.renameWidth = 4
        cpu.core.issueWidth = 4
        cpu.core.wbWidth = 4
        cpu.core.commitWidth = 4
        cpu.core.branchPred = predictor()
    stats.reset()
    yield False


# Functions to handle ROI end event
def roiEnd():
    print("ROI ended")
    stats.dump()
    yield True


parser = ArgumentParser(
    description="A script to run the gem5 boot test. This test boots the "
    "linux kernel."
)

parser.add_argument(
    "-t",
    "--branch-pred",
    type=str,
    default="tournament",
    help="The branch predictor to be used.",
    choices=list(BRANCH_PREDICTORS.keys()),
)

parser.add_argument(
    "-b",
    "--benchmark",
    type=str,
    default="blackscholes",
    help="The benchmark to be run.",
    choices=BENCHMARKS,
)

parser.add_argument(
    "-s",
    "--benchmark-size",
    type=str,
    default="simsmall",
    help="Size of inputs for the benchmark.",
    choices=BENCHMARK_SIZES,
)

args = parser.parse_args()

# Validate the arguments
branchPredictorKey = args.branch_pred.lower()
if branchPredictorKey not in BRANCH_PREDICTORS:
    raise ValueError(f"Unknown branch predictor type: {branchPredictorKey}")
benchmark = args.benchmark.lower()
benchmarkSize = args.benchmark_size.lower()

# Set up the system parameters
isa = ISA.X86
NUM_CORES = 1
cacheHierarchy = PrivateL1SharedL2CacheHierarchy(
    l1d_size="16KiB",
    l1i_size="16KiB",
    l2_size="128KiB",
)
memory = SingleChannelSimpleMemory(
    latency="30ns", latency_var="0ns", bandwidth="16GB/s", size="3GiB"
)
CLOCK_FREQUENCY = "3.2GHz"
cpuType = CPUTypes.O3
predictor = BRANCH_PREDICTORS[branchPredictorKey]

# Setup the processor with the specified parameters
processor = SimpleSwitchableProcessor(
    starting_core_type=CPUTypes.KVM,
    switch_core_type=CPUTypes.O3,
    num_cores=NUM_CORES,
    isa=isa,
)

# Setup the board with the specified parameters
board = X86Board(
    clk_freq=CLOCK_FREQUENCY,
    processor=processor,
    memory=memory,
    cache_hierarchy=cacheHierarchy,
)

# Set the boards kernels and disk images
board.set_kernel_disk_workload(
    kernel=KernelResource("x86-linux-kernel-5.4.49"),
    disk_image=DiskImageResource("x86-parsec"),
    kernel_args=[
        "earlyprintk=ttyS0",
        "console=ttyS0",
        "lpj=7999923",
        "root=/dev/hda1",
    ],
    readfile_contents=f"""
        #!/bin/sh
        echo "--- gem5: Booted successfully! ---"
        cd /home/gem5/parsec-benchmark
        echo "--- gem5: Building {benchmark} ---"
        ./bin/parsecmgmt -a build -p {benchmark} -c gcc-hooks
        echo "--- gem5: Running {benchmark} ---"
        ./bin/parsecmgmt -a run -p {benchmark} -i {benchmarkSize} -n {NUM_CORES} -c gcc-hooks
        echo "--- gem5: Benchmark finished ---"
        m5 exit
    """,
)

# Simulate the board with the specified parameters
simulator = Simulator(
    board=board,
    on_exit_event={
        ExitEvent.WORKBEGIN: roiStart(),
        ExitEvent.WORKEND: roiEnd(),
    },
)
simulator.run()
