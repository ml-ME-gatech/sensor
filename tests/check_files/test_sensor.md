# HeaterInlet1
- name: HeaterInlet1
- id: T1
- signal: ['V']
- measure_units: ['C']
- equation: <typeK_thermocouple>
- uncertainty: ['max', '2.2 [C]', '0.75 [%]']

# HeaterInlet2
- name: HeaterInlet2
- id: T2
- signal: ['V']
- measure_units: ['C']
- equation: <typeK_thermocouple>
- uncertainty: ['max', '2.2 [C]', '0.75 [%]']

# HeaterInlet3
- name: HeaterInlet3
- id: T3
- signal: ['V']
- measure_units: ['C']
- equation: <typeK_thermocouple>
- uncertainty: ['max', '2.2 [C]', '0.75 [%]']

# HeaterInlet4
- name: HeaterInlet4
- id: T4
- signal: ['V']
- measure_units: ['C']
- equation: <typeK_thermocouple>
- uncertainty: ['max', '2.2 [C]', '0.75 [%]']

# StaticPressureVenturi
- name: StaticPressureVenturi
- id: P1
- signal: ['A']
- measure_units: ['Pa']
- equation: y = 150.55*x + 45.666
- uncertainty: 40 [Pa]

# PressureDifferential
- name: PressureDifferential
- id: DP1
- signal: ['A']
- measure_units: ['Pa']
- equation: np.sqrt(y) = 50.0*x + 14.0
- uncertainty: 40 [Pa]

