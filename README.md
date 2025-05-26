# 🚦 Traffic Light Controller (Verilog)

A Verilog-based **Traffic Light Controller** using a **Finite State Machine (FSM)** with integrated timer logic. The controller manages a two-way intersection with North-South (NS) and East-West (EW) traffic directions.

---

## 🧠 Overview

This project simulates an automatic traffic light system that cycles through:

1. **NS Green**, EW Red  
2. **NS Yellow**, EW Red  
3. **EW Green**, NS Red  
4. **EW Yellow**, NS Red  

Each state is held for a fixed duration, using a countdown timer, before transitioning to the next state.

---

## ⚙️ Features

- FSM-based state transitions  
- Timer-controlled light durations  
- Two traffic directions: North-South and East-West  
- Easy to simulate or synthesize for FPGA

---

## 🔧 Implementation

- Written in **Verilog HDL**
- Clock-driven design with synchronous reset
- Configurable durations for green and yellow lights
- Light color output encoded as:
  - `2'b00`: Red
  - `2'b01`: Yellow
  - `2'b10`: Green

---

## 🧪 Testbench

Includes a testbench (`traffic_light_controller_tb.v`) to simulate the controller. The testbench:
- Generates a clock
- Applies a reset
- Monitors and prints the current light states over time



