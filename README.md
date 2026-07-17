# PV-MPPT P-HIL Emulator on dSPACE MicroLabBox II

## Overview
This project implements a Power Hardware-in-the-Loop (P-HIL) emulation of a photovoltaic system, combining a physical PV panel model, an MPPT algorithm, a real hardware buck converter (inverter leg used in synchronous buck configuration), and a battery emulation, all running in real time on a dSPACE MicroLabBox II platform.

The system evolved through several stages, from offline Simulink simulation to full real-time hardware emulation using a programmable power supply (TDK Lambda) as the PV source, a physical buck converter as the power stage, and a bidirectional source-load (Regatron) as the battery.
