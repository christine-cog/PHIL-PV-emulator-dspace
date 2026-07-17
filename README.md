# P-HIL : PV Emulator on dSPACE MicroLabBox II

## Overview
This project implements a Power Hardware-in-the-Loop (P-HIL) emulation of a photovoltaic system, combining a physical PV panel model, an MPPT algorithm, a real hardware buck converter (inverter leg used in synchronous buck configuration), and a battery emulation, all running in real time on a dSPACE MicroLabBox II platform.

The system evolved through several stages, from offline Simulink simulation to full real-time hardware emulation using a programmable power supply (TDK Lambda) as the PV source, a physical buck converter as the power stage, and a bidirectional source-load (Regatron) as the battery.


## P-HIL Concept

Power Hardware-in-the-Loop (P-HIL) differs from signal-level HIL in that the signals exchanged between the simulated model and the real hardware carry actual electrical power, not just information.

In this project, the PV panel itself is not physically present. It is emulated in real time by a programmable power supply (TDK Lambda) driven by a mathematical model of the panel.
This emulated source then powers a real hardware buck converter, allowing the MPPT algorithm and the power stage to be tested exactly as they would be with a real panel, without depending on real sunlight, weather conditions, or risking damage to an actual PV module during testing.
