# Performance Analysis of Branch Predictors using gem5 and PARSEC

**Author:** Sai Kaushik S (2025CSZ8470)

**Course:** Architecture of High Performance System

**Instructor:** Dr. Kolin Paul

## Overview

This project provides a framework for analyzing and comparing the performance of various branch predictors within the gem5 full-system simulator. The evaluation is conducted using a selection of benchmarks from the PARSEC suite to measure key performance indicators like branch misprediction rates and Instructions Per Cycle (IPC). By running standardized workloads (PARSEC benchmarks) on a simulated system, we can gather detailed statistics and compare the effectiveness of each predictor.

## Branch Predictors Analyzed

This study evaluates the following branch predictors available in gem5:

- **Bimodal:** A simple predictor that uses a 2-bit saturating counter for each entry in a pattern history table.
- **Local:** A two-level adaptive predictor that uses the history of a particular branch to predict its future outcome.
- **Tournament:** A hybrid predictor that combines a local and a global predictor and uses a meta-predictor to choose which one to use for each branch.
- **TAGE (TAgged GEometric history length):** An advanced, state-of-the-art gshare-based predictor that uses multiple tables with varying history lengths.
- **LTAGE (Loop, TAGE):** An extension of TAGE that includes a dedicated loop predictor.
- **Perceptron:** A predictor that uses a perceptron-based machine learning model to make predictions.

## Benchmarks Used

The analysis is performed on the following benchmarks from the **PARSEC-3.0** suite, compiled for the **x86** architecture. Each benchmark is run with `small`, `medium`, and `large` input sizes.

- `blackscholes`
- `bodytrack`
- `canneal`
- `dedup`
- `ferret`

## Getting Started

Follow these steps to set up the environment and run the simulations.

### 1. Prerequisites

Clone and build `gem5` using the scripts provided.

```bash
./scripts/build_gem5.sh
```

### 2. Required kernel images

Download the required kernel and disk images with the PARSEC benchmarks.

```bash
./scripts/get_images.sh
```

## Execution

### 1. Run the benchmarks

Execute the script to run the benchmarks on different inputs.

```bash
./scripts/run_benchmark.sh
```

### 2. Run individually

Execute a specific benchmark.

The core simulation logic is contained within src/benchmark.py.

```bash
./gem5/build/X86/gem5.opt
    -d output/blackscholes-large/perceptron
    src/benchmark.py
        -t perceptron
        -b blackscholes
        -s simlarge
```

The above command runs the `blackscholes` benchmark with the `large` input dataset on the `perceptron` branch predictor.

The output of the simulation is stored at `output/blackscholes-large/perceptron/`.

## Results

Raw simulation results, including detailed statistics, are stored in the `stats.txt` file for each run inside the `output/` directory.

A summary of the most important metrics from all runs can be aggregated by the `analysis/main.ipynb` for plotting and analysis.

The main metrics will be generated on execution at `analysis/simResults.csv` and `analysis/simResults.json`. The different plots can be found within `analysis/figs`.
