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
5. [Guida all'esecuzione](#usage)
   1. [Step 1 — Inizializzazione del workspace](#step1)
   2. [Step 2 — Caricamento dei dati di calibrazione](#step2)
   3. [Step 3 — Calibrazione delle soglie diagnostiche](#step3)
   4. [Step 4 — Apertura del modello Simulink](#step4)
   5. [Step 5 — Selezione del guasto e avvio della simulazione](#step5)
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

## ▶️ Guida all'esecuzione <a name="usage"></a>

Di seguito sono descritti, nell'ordine corretto, tutti i passaggi necessari per configurare l'ambiente, calibrare le soglie diagnostiche e lanciare una simulazione con o senza guasto.

> **Nota**: tutti i comandi vanno eseguiti nella *Command Window* di MATLAB, con la cartella `MPRAI_Progetto_MIL/` impostata come *Current Folder*.

---

### Step 1 — Inizializzazione del workspace <a name="step1"></a>

Eseguire in sequenza i due script seguenti:

```matlab
Main
FD1_FD2_FD3
```

- **`Main.m`** pulisce il workspace (`clear all`), aggiunge al path le sotto-cartelle `bin/` e `bin/misc/`, e carica nel workspace tutte le variabili necessarie alla simulazione:
  - *Parametri di simulazione* (tempo finale, passo di campionamento, tipo di traiettoria, tipo di disturbo, flag di attacco) tramite `SimulationParameters.m`.
  - *Parametri del controllore DOBC* (guadagni NDO, poli dell'osservatore di disturbo) tramite `ControllerParameters.m`.
  - *Parametri del plant* (massa `m`, matrice di inerzia `J`, matrici di allocazione `F1` e `F2`) tramite `PlantParameters.m`.

- **`FD1_FD2_FD3.m`** utilizza le variabili appena caricate (in particolare `F1`, `F2`, `J`, `m`, `Ts`, `omega0`, `p0`) per calcolare le matrici *State-Space* dei tre moduli di Fault Detection:
  - **FD-1**: matrice di stato ad anello chiuso dell'osservatore di Luenberger (`A_SS_FD1`), matrice di ingresso composita (`B_SS_FD1`), identità in uscita e condizioni iniziali.
  - **FD-2**: matrice di proiezione $F_2^T$ per i residui strutturati a 6 canali e matrici del filtro washout (LPF diagonale $6\times6$ con $\tau = 40$ s).
  - **FD-3**: matrici del filtro complementare per il GPS con guadagno $K_{comp} = 0{,}05$ e condizioni iniziali.

Al termine di questo step, tutte le variabili richieste dal modello Simulink sono presenti nel workspace.

---

### Step 2 — Caricamento dei dati di calibrazione <a name="step2"></a>

Caricare nel workspace i tre file `.mat` contenenti i dati dei residui acquisiti in una precedente simulazione **fault-free** (senza guasto). Questi dati servono come *baseline* statistica per il calcolo delle soglie.

Dalla *Command Window* di MATLAB:

```matlab
load('r_gyro_norm.mat')    % Norma del residuo FD-1 (giroscopio) in condizioni nominali
load('r_gps_norm.mat')     % Norma del residuo FD-3 (GPS) in condizioni nominali
load('r_det6.mat')         % Residui detrended FD-2 (6 canali, uno per motore) in condizioni nominali
```

In alternativa, è possibile fare doppio clic sui file `.mat` direttamente dal pannello *Current Folder* di MATLAB.

> **Nota**: questi file sono già forniti nel repository e contengono i dati di una simulazione fault-free di riferimento (traiettoria a spirale ascendente, 300 s, disturbi di tipo 6). Se si desidera ricalcolarli con parametri diversi, è sufficiente eseguire una simulazione senza guasto (`Attack = 0` in `SimulationParameters.m`) e salvare manualmente le variabili `r_gyro_norm`, `r_gps_norm` e `r_det6` dal workspace.

---

### Step 3 — Calibrazione delle soglie diagnostiche <a name="step3"></a>

Eseguire lo script di calibrazione:

```matlab
Calcolo_soglie_residui
```

Questo script analizza statisticamente i dati di baseline caricati allo Step 2 e calcola le soglie di allarme secondo la **regola del 3-sigma** ($\mu \pm 3\sigma$):

| Modulo | Variabile soglia | Descrizione |
|--------|-----------------|-------------|
| **FD-1** | `Th_3sigma_gyro` | Soglia positiva sulla norma del residuo del giroscopio |
| **FD-2** | `Th_m1` ... `Th_m6` | 6 soglie negative (una per motore) sui residui strutturati detrended |
| **FD-3** | `Th_3sigma_gps` | Soglia positiva sulla norma del residuo GPS |

Al termine dell'esecuzione, la *Command Window* stampa un riepilogo con media, deviazione standard e soglia calcolata per ciascun modulo. Le variabili soglia vengono salvate nel workspace e saranno lette automaticamente dai blocchi *Compare to Constant* presenti nel modello Simulink.

---

### Step 4 — Apertura del modello Simulink <a name="step4"></a>

Aprire il modello di simulazione:

```matlab
open_system('Simulation')
```

Oppure fare doppio clic sul file `Simulation.slx` dal pannello *Current Folder*. Il modello contiene:

- Il **plant** del drone (blocco protetto `Drone_System`), con la dinamica a 6 GDL del corpo rigido e i sensori rumorosi.
- Il **controllore DOBC** con gli osservatori di disturbo NDO per forze e coppie.
- I **tre moduli di Fault Detection** (FD-1, FD-2, FD-3) implementati come blocchi *State-Space*.
- Il blocco **Evaluator** con le logiche di sogliatura, debounce e isolamento.
- I **sottosistemi di iniezione guasti** per giroscopio, GPS e attuatori, ciascuno dotato di *Manual Switch* per l'abilitazione selettiva.

---

### Step 5 — Selezione del guasto e avvio della simulazione <a name="step5"></a>

Prima di lanciare la simulazione, scegliere lo scenario di guasto desiderato:

#### Guasto al giroscopio (FD-1)
1. Navigare nel sottosistema di iniezione guasti sul giroscopio.
2. Commutare il *Manual Switch* sull'asse desiderato (Roll, Pitch o Yaw) dalla posizione *nominale* alla posizione *guasto*.
3. Verificare i parametri del blocco *Ramp*: slope = `0.01`, start time = `Attack_Time`, saturazione = `±5 rad/s`.

#### Guasto agli attuatori (FD-2)
1. Navigare nel sottosistema di iniezione guasti sui motori.
2. Commutare il *Manual Switch* del motore desiderato ($f_1$ ... $f_6$).
3. Verificare i parametri del blocco *Step*: step time = `Attack_Time`, valore finale = fattore di perdita di efficacia (es. `0.8` per una perdita del 20%).

#### Guasto al GPS (FD-3)
1. Navigare nel sottosistema di iniezione guasti sul GPS.
2. Commutare il *Manual Switch* sull'asse desiderato ($x$, $y$ o $z$).
3. Verificare i parametri del blocco *Ramp*: slope = `0.02`, start time = `Attack_Time`, saturazione = `±5 m`.

#### Simulazione fault-free
Per una simulazione senza guasti (utile per verificare l'assenza di falsi allarmi), assicurarsi che tutti i *Manual Switch* siano nella posizione *nominale* e che `Attack = 0` in `SimulationParameters.m`.

#### Avvio
Lanciare la simulazione premendo il pulsante ▶️ **Run** nella toolbar di Simulink, oppure da terminale:

```matlab
sim('Simulation')
```

Al termine della simulazione, per generare i grafici dei risultati:

```matlab
PlotGraphs
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