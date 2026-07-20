# P-HIL : PV Emulator on dSPACE MicroLabBox II

## Overview
This project implements a Power Hardware-in-the-Loop (P-HIL) emulation of a photovoltaic system, combining a physical PV panel model, an MPPT algorithm, a real hardware buck converter (inverter leg used in synchronous buck configuration), and a battery emulation, all running in real time on a dSPACE MicroLabBox II platform.

The system evolved through several stages, from offline Simulink simulation to full real-time hardware emulation using a programmable power supply (TDK Lambda) as the PV source, a physical buck converter as the power stage, and a bidirectional source-load (Regatron) as the battery.

<p align="center">
  <img src="figures/hardware/Setup_complet.jpg" width="500">
</p>


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


## Hardware Platform

- **dSPACE MicroLabBox II (DS1203 + DS1303)** - real-time control platform

<img src="figures/hardware/MicrolabBox.jpg" width="400">

- **Interface board** - signal conditioning between the MicroLabBox II 
and the buck converter

<img src="figures/hardware/Interface_board.jpg" width="400">

- **RS PRO Programmable DC Power Supply** - fixed voltage source, used 
in the early stages before the introduction of the TDK Lambda

<img src="figures/hardware/DC_source.jpg" width="400">

- **TDK Lambda Programmable DC Power Supply** - emulates the PV panel 
source, driven in real time via DAC

<img src="figures/hardware/Tdk_lambda.jpg" width="400">

- **Buck converter** - inverter leg used in synchronous buck 
configuration, real hardware power stage

<img src="figures/hardware/Hacheur.jpg" width="400">

- **Resistive load** - used in the early stages of the project, before 
the introduction of the battery emulation

<img src="figures/hardware/Charge.jpg" width="400">

- **Regatron** - bidirectional source-load, emulates the battery

<img src="figures/hardware/Regatron.jpg" width="400">

- **Hall-effect current probe** - current measurement (0.1 V/A)

<img src="figures/hardware/Pince_hall.jpg" width="400">

- **Oscilloscope** - signal validation (PWM, current etc)

<img src="figures/hardware/Oscilloscope.jpg" width="400">

**I/O channels used:**
- Digital I/O 14 Channel 24 (RF1) - PWM output
- Analog Out 19 Channel 1 - DAC (drives TDK Lambda)
- Analog In 23 Channel 1 - ADC (current measurement)3 Channel 1 - ADC (current measurement)

  ## Model Evolution

Le projet a évolué à travers plusieurs étapes, chacune permettant de 
valider une brique du système avant de passer à la suivante.

### 1 - Simulation Simscape hors-ligne

La première étape a permis de valider le modèle du panneau PV 
(équation à une diode, résolution Newton-Raphson) couplé à un étage 
de puissance Simscape (convertisseur buck-boost, source de courant 
contrôlée, charge résistive), avec l'algorithme MPPT tournant 
directement en simulation. 

Modèle complet disponible dans [`/simulink`](./simulink).

### 2 - Validation de la chaîne de puissance en boucle ouverte

Avant d'introduire le modèle PV en boucle fermée, cette étape a permis 
de valider isolément la chaîne de puissance physique : une alimentation 
DC fixe (30V) alimente le hacheur Lemta du laboratoire, piloté en duty 
cycle par un signal PWM généré par dSPACE (10 kHz), sur une charge 
résistive simple.

Avec une tension d'entrée connue et fixe, la relation V_sortie = d × E 
permet de vérifier que le signal PWM commande correctement le hacheur 
et que la tension de sortie obtenue correspond à la théorie - sans la 
complexité du modèle PV, isolée à cette étape.

Modèle complet disponible dans [`/simulink`](./simulink).


