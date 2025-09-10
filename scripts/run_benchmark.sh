#!/bin/bash

# --- Configuration ---
GEM5_EXE="./gem5/build/X86/gem5.opt"
BENCHMARK_SCRIPT="src/benchmark.py"
OUTPUT_BASE="output"

# --- Simulation Parameters ---
ALL_PREDICTORS=("bimodal" "local" "tournament" "tage" "ltage" "perceptron")
BENCHMARKS=("blackscholes" "canneal" "dedup" "ferret" "bodytrack")
SIZES=("simsmall" "simmedium" "simlarge")


# --- Main Execution Logic ---
echo "Starting full simulation sweep for all combinations."
echo "----------------------------------------------------"
for benchmark in "${BENCHMARKS[@]}"; do
    for size in "${SIZES[@]}"; do
        echo ""
        echo "--- Running Benchmark: ${benchmark} with Size: ${size} ---"
        
        for predictor in "${ALL_PREDICTORS[@]}"; do
            OUTPUT_DIR="${OUTPUT_BASE}/${benchmark}-${size}/${predictor}"
            echo "  -> Predictor: ${predictor}"
            mkdir -p "$OUTPUT_DIR"
            "$GEM5_EXE" -d "$OUTPUT_DIR" "$BENCHMARK_SCRIPT" -t "$predictor" -b "$benchmark" -s "$size"
        done
    done
done

echo "----------------------------------------------------"
echo "All simulations complete."