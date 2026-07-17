# P-HIL : PV Emulator on dSPACE MicroLabBox II

## Overview
This project implements a Power Hardware-in-the-Loop (P-HIL) emulation of a photovoltaic system, combining a physical PV panel model, an MPPT algorithm, a real hardware buck converter (inverter leg used in synchronous buck configuration), and a battery emulation, all running in real time on a dSPACE MicroLabBox II platform.

The system evolved through several stages, from offline Simulink simulation to full real-time hardware emulation using a programmable power supply (TDK Lambda) as the PV source, a physical buck converter as the power stage, and a bidirectional source-load (Regatron) as the battery.


## P-HIL Concept

Power Hardware-in-the-Loop (P-HIL) differs from signal-level HIL in that the signals exchanged between the simulated model and the real hardware carry actual electrical power, not just information.

In this project, the PV panel itself is not physically present. It is emulated in real time by a programmable power supply (TDK Lambda) driven by a mathematical model of the panel.

This emulated source then powers a real hardware buck converter, allowing the MPPT algorithm and the power stage to be tested exactly as they would be with a real panel, without depending on real sunlight, weather conditions, or risking damage to an actual PV module during testing.

## PV Physical Model

The PV panel is modeled using the single-diode equation based on the parameters of a 250W reference panel (Isc, Voc, Vmp, 
Imp, ideality factor, series/parallel resistance, thermal 
coefficients). :

I = Iph − Io [exp((V + Rs·I) / (Vt·a)) − 1] − (V + Rs·I) / Rp

**Panel parameters (250W nominal):**

| Parameter | Value |
|---|---|
| Isc | 8.69 A |
| Voc | 36.6 V (0.61 V/cell × 60 cells) |
| Vmp | 30.55 V |
| Imp | 8.19 A |
| Pmax | 246 W |
| Ideality factor (a) | 1.3 |
| Rs | 0.04/60 Ω |
| Rp | 1271.1/60 Ω |
| Kv (thermal) | -0.0038 V/°C |
| Ki (thermal) | 0.004 A/°C |

**Solving method:** the equation is solved in real time using the Newton-Raphson method, bounded to 10 iterations to guarantee compatibility with the real-time execution constraints of the dSPACE platform.

**Key design choice — V = f(I) instead of I = f(V):** in the reference course model, the equation is typically solved as I = f(V). 

In this hardware implementation, this was inverted to V = f(I), because the physical measurement available on the hardware side is the current (measured via a Hall-effect current probe), while the voltage is the quantity computed and imposed on the programmable power supply.
