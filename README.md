# Progetto-Manutenzione-Hardware-In-The-Loop

<div style="display: flex; flex-wrap: wrap; gap: 10px;">

![version](https://img.shields.io/badge/version-1.0-blue.svg)

![MATLAB](https://img.shields.io/badge/MATLAB-R2024b-orange?style=flat&logo=mathworks)
![Simulink](https://img.shields.io/badge/Simulink-R2024b-orange?style=flat&logo=mathworks)
![STM32](https://img.shields.io/badge/STM32-Nucleo--H723ZG-03234B?style=flat&logo=stmicroelectronics)

<p align="center">
    <a href="https://www.univpm.it/">
<img src="Documents/logo_univpm.png" width=15% height=15%> </a>
</p>

---

| Version | Date       | Description                                              |
| ------- | ---------- | -------------------------------------------------------- |
| v1.0    | 2026-07-22 | Rilascio finale con moduli FD1, FD2, FD3 e validazione PIL |

---

## 📑 Indice

1. [Descrizione del Progetto](#project-overview)
2. [Struttura delle cartelle](#folder-structure)
3. [Requisiti](#requirements)
   1. [Hardware](#hardware)
   2. [Software](#software)
4. [Configurazioni Pre-Run](#pre-run-configuration)
   1. [Environment Setup](#setup)
5. [Esempi di esecuzione](#usage)
   1. [Simulazione MIL](#run-mil)
   2. [Simulazione PIL](#run-pil)
6. [Legal](#legal)
   1. [Credits](#credits)
   2. [License](#license)

---

## 🧩 Descrizione del Progetto <a name="project-overview"></a>

Il progetto riguarda la progettazione, l'implementazione e la validazione di un **modulo di Fault Detection** per un drone esacottero (modello HEXANiemiec), sviluppato nell'ambito del corso di *Manutenzione Preventiva per la Robotica e l'Automazione Intelligente* (A.A. 2025/2026) presso l'Università Politecnica delle Marche.

Il sistema diagnostico è stato progettato per operare in sinergia con un controllore **DOBC** (*Disturbance Observer Based Control*) ed è articolato in **tre moduli paralleli**, ciascuno specializzato nella rilevazione di una specifica classe di guasto:

| Modulo | Tecnica | Guasto rilevato |
|--------|---------|-----------------|
| **FD-1** | Osservatore di Luenberger | Guasto additivo a rampa sul giroscopio |
| **FD-2** | Equazioni di parità strutturate + filtro washout | Guasto moltiplicativo a gradino sugli attuatori (Loss of Effectiveness) |
| **FD-3** | Filtro complementare (Dead Reckoning) | Guasto additivo a rampa sul GPS |

I residui dei tre moduli convergono in un blocco **Evaluator** centralizzato, incaricato del confronto con soglie statistiche, della logica di debounce e dell'isolamento dei guasti.

L'intero sistema è stato validato in due fasi:
- **Model-in-the-Loop (MIL)**: simulazione completa in ambiente MATLAB/Simulink.
- **Processor-in-the-Loop (PIL)**: l'algoritmo di controllo e diagnostica è stato cross-compilato, flashato ed eseguito su un microcontrollore **STM32 Nucleo-H723ZG**, con il modello del drone simulato sul PC host e comunicazione via porta seriale.

---

## 📁 Struttura delle cartelle <a name="folder-structure"></a>

Il progetto è organizzato secondo le seguenti cartelle:

```text
Progetto-Manutenzione-Hardware-In-The-Loop/
├── MPRAI_Progetto_MIL/                          # Progetto MATLAB/Simulink per simulazione MIL
│   ├── Main.m                                   # Script principale: carica parametri e lancia la simulazione
│   ├── Simulation.slx                           # Modello Simulink completo (plant + controllore + FD)
│   ├── Drone_System.slxp                        # Modello protetto del plant (dinamica del drone)
│   ├── FD1_FD2_FD3.m                            # Script di calcolo delle matrici State-Space per i tre moduli FD
│   ├── Calcolo_soglie_residui.m                 # Script per la calibrazione delle soglie 3σ in condizioni fault-free
│   ├── r_det6.mat                               # Dati residui FD2 (6 canali) per calibrazione soglie
│   ├── r_gps_norm.mat                           # Dati norma residuo FD3 per calibrazione soglie
│   ├── r_gyro_norm.mat                          # Dati norma residuo FD1 per calibrazione soglie
│   └── bin/                                     # Parametri e utility
│       ├── SimulationParameters.m               # Parametri di simulazione (tempo, traiettoria, disturbi, guasti)
│       ├── ControllerParameters.m               # Parametri del controllore DOBC e NDO
│       ├── PlantParameters.m                    # Parametri fisici del drone (massa, inerzia, matrici F1/F2)
│       ├── PlotGraphs.m                         # Script per la generazione dei grafici post-simulazione
│       └── PlotComparisonGraphs.m               # Script per confronto MIL vs PIL
│
├── MPRAI_Progetto_PIL/                          # Progetto per simulazione Processor-in-the-Loop
│   ├── Main.m                                   # Script principale PIL
│   ├── Simulation.slx                           # Modello Simulink configurato per PIL
│   ├── Algorithm_to_deploy.slx                  # Sottosistema dell'algoritmo da deployare su STM32
│   ├── Algorithm_to_deploy_psf.mexw64           # Eseguibile MEX per la comunicazione PIL
│   ├── Drone_System.slxp                        # Modello protetto del plant
│   ├── Controller_HIL/                          # Progetto STM32CubeIDE per il microcontrollore
│   │   ├── Controller_HIL.ioc                   # Configurazione periferiche STM32
│   │   ├── Core/                                # Sorgenti C generati (main.c, stm32h7xx_hal_msp.c, ...)
│   │   ├── Drivers/                             # Driver HAL STM32
│   │   └── STM32CubeIDE/                        # Workspace e file di progetto Eclipse
│   └── bin/                                     # Parametri e utility (analoghi a MIL)
│
├── Grafici/                                     # Risultati grafici delle simulazioni
│   ├── Plot_MIL_base.png                        # Tracking posizione e comandi motori (MIL nominale)
│   ├── Compare_MIL_PIL.png                      # Confronto numerico MIL vs PIL (Data Inspector)
│   ├── Simulation_PIL_base.mp4                  # Video della simulazione PIL
│   ├── Guasti sensori/                          # Grafici risposta dinamica ai guasti su giroscopio e GPS
│   ├── Guasti motore/                           # Grafici risposta dinamica ai guasti sugli attuatori
│   └── Fault_Detection/                         # Grafici dei residui e dell'Evaluator
│       ├── Modulo FD-1/                         # Residui dell'osservatore di Luenberger
│       ├── Modulo FD-2/                         # Residui strutturati per i 6 motori
│       ├── Modulo FD-3/                         # Residui del filtro complementare GPS
│       └── Evaluator/                           # Uscite booleane del blocco Evaluator
│
└── Documents/                                   # Documentazione del progetto
    ├── Descrizione progetto.pdf                 # Traccia e requisiti del progetto
    ├── Relazione_progetto.pdf                   # Relazione finale completa
    ├── Revisione_1.pptx                         # Presentazione prima revisione
    ├── Revisone_3.pptx                          # Presentazione terza revisione
    └── Revisione_4.pptx                         # Presentazione quarta revisione (finale)
```

---

## 🖥️ Requisiti <a name="requirements"></a>

### Hardware <a name="hardware"></a>

- **Microcontrollore**: STM32 Nucleo-H723ZG (ARM Cortex-M7, 550 MHz)
- **Interfaccia**: Cavo USB tipo A — micro-B per comunicazione seriale UART e programmazione

### Software <a name="software"></a>

- **OS**: Windows 10/11
- **MATLAB**: R2024b o successivo
- **Simulink**: R2024b con i seguenti toolbox:
  - Simulink
  - Embedded Coder
  - Simulink Coder
  - MATLAB Coder
  - Stateflow
  - Simulink Test (per *Simulation Data Inspector*)
- **STM32 Support Package**: *Simulink Support Package for STMicroelectronics STM32 Processors*
- **STM32CubeIDE**: v1.15+ (per compilazione e debug del firmware)
- **Toolchain**: ARM GCC (incluso in STM32CubeIDE)

---

## ⚙️ Configurazioni Pre-Run <a name="pre-run-configuration"></a>

### Environment Setup <a name="setup"></a>

1. **Installare il Support Package STM32** in MATLAB:
   - Da MATLAB: *Home → Add-Ons → Get Hardware Support Packages*
   - Cercare e installare *"Simulink Support Package for STMicroelectronics STM32 Processors"*
   - Seguire il wizard di configurazione per registrare la scheda Nucleo-H723ZG

2. **Configurare i parametri di simulazione** nel file `bin/SimulationParameters.m`:
   - `ReferenceTypeNumber`: tipo di traiettoria (4 = spirale ascendente)
   - `WrenchType`: tipo di disturbo esterno (6 = bassa + alta frequenza)
   - `Attack`: abilitare (1) o disabilitare (0) l'iniezione dei guasti
   - `NoiseStdAmplification`: amplificazione del rumore sensoriale

3. **Configurare il tipo di guasto** nel modello Simulink `Simulation.slx`:
   - Aprire il sottosistema di iniezione guasti desiderato
   - Commutare il *Manual Switch* per abilitare il canale guasto
   - Impostare i parametri del blocco *Ramp* o *Step* secondo lo scenario desiderato

---

## ▶️ Esempi di esecuzione <a name="usage"></a>

### Simulazione MIL <a name="run-mil"></a>

1. Aprire MATLAB e navigare nella cartella `MPRAI_Progetto_MIL/`
2. Eseguire lo script principale:
   ```matlab
   Main
   ```
3. Il modello `Simulation.slx` si apre e carica automaticamente tutti i parametri
4. Lanciare la simulazione dalla GUI di Simulink oppure da terminale MATLAB:
   ```matlab
   FD1_FD2_FD3           % Calcola le matrici dei moduli di Fault Detection
   Calcolo_soglie_residui % Calibra le soglie (richiede i file .mat di riferimento)
   sim('Simulation')      % Lancia la simulazione
   PlotGraphs             % Genera i grafici dei risultati
   ```

### Simulazione PIL <a name="run-pil"></a>

1. Collegare la scheda STM32 Nucleo-H723ZG al PC via USB
2. Aprire MATLAB e navigare nella cartella `MPRAI_Progetto_PIL/`
3. Eseguire:
   ```matlab
   Main
   ```
4. Nel modello `Simulation.slx`, il blocco controllore è configurato in modalità PIL:
   - Simulink compila automaticamente il codice C per il target ARM
   - Il firmware viene flashato sulla scheda
   - La simulazione avviene con il controllore in esecuzione sull'hardware reale
5. Per il confronto MIL vs PIL, utilizzare il *Simulation Data Inspector* oppure:
   ```matlab
   PlotComparisonGraphs
   ```

---

## 👥 Legal <a name="legal"></a>

### Credits <a name="credits"></a>

Progetto sviluppato nell'ambito del corso di *Manutenzione Preventiva per la Robotica e l'Automazione Intelligente*, A.A. 2025/2026.

*UNIVPM, DII, Università Politecnica delle Marche, Via Brecce Bianche, 12, Ancona, 60131, Italy*

- **Professore**: [Alessandro Freddi](mailto:a.freddi@univpm.it)
- **Studenti**:
  - Roberto Dimitri
  - Edoardo Palmoni
  - Jacopo Tarulli

### License <a name="license"></a>

[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg