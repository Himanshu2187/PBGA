#Epluslauncher
1. The Description of the configuration used in Epluslauncher API is avaiable on https://sabinaproject.eu/resources/API/api/EplusLauncher.html
2. Examples for using the API can be found on https://sabina-project.eu/resources/API/index.html
3. The configuration files used in this study are made available in this account.

# MATLAB Code Explanation: PBGA_Balanced_Weights

## Overview
The `PBGA_Balanced_Weights` MATLAB code is designed for Preference-based goal attainment optimization. It employs a genetic algorithm to find optimal solutions based on specified design variables, constraints, and preferences.



## Bounds of Design Variables
The design variables represent various aspects of a building's characteristics:

1. Window-wall ratio (`lb(1)` and `ub(1)`)
2. Interior surface properties (`lb(2)` and `ub(2)`)
3. Overhang width (`lb(3)` and `ub(3)`)
4. Building height (`lb(4)` and `ub(4)`)
5. Roof insulation thickness (`lb(5)` and `ub(5)`)
6. Floor insulation thickness (`lb(6)` and `ub(6)`)
7. Wall insulation thickness (`lb(7)` and `ub(7)`)
8. Roof Insulation type (XPS, EPS, PIR)

## Constraints
The `Constr` function defines the nonlinear inequality and equality constraints. As currently implemented, it has no constraints (`c` and `ceq` are empty).

## Preferences
The code incorporates preferences for thermal comfort (PPD) and energy consumption (KWh). The preferences are modeled using piecewise cubic Hermite interpolating polynomials (`pchip`) based on specified curves.

1. **Thermal Comfort (PPD):**
    - Minimum PPD: `PPD_Min`
    - Maximum PPD: `PPD_Max`
    - Interpolated PPD values: `Thermal_curve`

2. **Energy Consumption (KWh):**
    - Minimum Consumption: `Econ_Min_Sfctn`
    - Intermediate Consumption: `Econ_Int_Sfctn`
    - Maximum Consumption: `Econ_Max_Sfctn`
    - Interpolated consumption values: `Econsmp_curve`

Similarly,

## Acoustic Comfort - Reverbation Time (TR)
The code includes specifications for Acoustic Comfort using the reverberation time (TR). It defines a preference curve based on the minimum (`TR_min`) and maximum (`TR_max`) values, along with an intermediate value (`TR_Int`). The curve is interpolated using piecewise cubic Hermite interpolating polynomials (`pchip`), allowing for a smooth representation of the preference over a range of values.

## Total Cost in Euros
The code incorporates preferences for the total cost in Euros (`CE_min`, `CE_max`, and `CE_Int`). Similar to the other preferences, a curve is generated using `pchip` to represent the cost preference across a spectrum of values.

## Visual Comfort - Glare and Illuminance
1. **Glare (Daylight Glare Index - DGI):**
   - Maximum (`VG_max`) and minimum (`VG_min`) values, along with an intermediate value (`VG_int`), are defined. The preference curve is generated using `pchip`.

2. **Illuminance (Horizontal illuminance - lx):**
   - Minimum (`VI_min`) and maximum (`VI_max`) illuminance values, along with intermediate values (`VI_int1`, `VI_int2`, `VI_int3`), are specified. The `pchip` function is used to create the illuminance preference curve.

## Aesthetic Comfort - Aesthetic Index
The aesthetic comfort is represented using an aesthetic index (`Ac_min`, `Ac_max`, `Ac_int`). The curve is created using `pchip` to capture the aesthetic preference over a defined range.

## Carbon Emission - Kg CO2/m2
The code includes preferences for carbon emission (`Ece_min`, `Ece_max`, `Ece_Int`). The curve is generated with `pchip` to represent the carbon emission preference across different values.

## Weights of Objective Functions
Objective functions are assigned weights (`w_Econ`, `w_Thermal`, `w_acoustic`, `w_cost`, `w_visualG`, `w_visualI`, `w_aesthetic`, `w_Carbnemission`) to reflect their importance in the overall goal attainment. The weights are normalized to ensure a total weight of 1.
Weights distribution in this code represents the balanced between Project stakeholders. 
The final normalized weights (`w_Econ`, `w_Thermal`, etc.) are calculated to distribute the overall weight proportionally among different objectives.
# MATLAB Code Explanation: Genetic Algorithm Options and EnergyPlus Simulation Configuration

## Genetic Algorithm (GA) Options
The code defines options for the Genetic Algorithm (GA) using the `optimoptions` function. The options include:
- `PopulationSize`: Number of individuals in the population (60).
- `MaxGenerations`: Maximum number of generations (90).
- `MaxStallGenerations`: Maximum number of generations to stall before termination (10).
- `EliteCount`: Number of elite individuals preserved from one generation to the next (6).
- `Display`: Display level of information during optimization ('iter').
- `PlotFcn`: Function handle for plotting the best fitness value during optimization.
- `OutputFcn`: Function handle for saving the best individuals during optimization using the `SaveOut` function.

## EnergyPlus Simulation Configuration
The code configures the EnergyPlus simulation using the `EplusLauncher.Configuration` class. The configuration includes:
- `InputFile`: Path to the IDF file ('Add path to idf file').
- `WeatherFile`: Path to the weather file ('Add path to weather file').
- `RviFile`: Path to the RVI file ('RVI File path').
- `EnergyPlusFolder`: EnergyPlus installation path ('EnergyPlus software path').
- `OutputFolder`: Path to the output folder ('Desired output folder path').

## Tags
A cell array `Tags` is defined, containing various tags used to replace specific placeholders in the IDF file.

## Objective Function
The code defines an objective function `ObjFunction(x)` used in the optimization process. This function:

##Launcher configuration
- Creates an instance of `EplusLauncher.Launcher`.
- Sets configuration parameters for the launcher.
- Defines event listeners for handling output messages, simulation completion, and jobs finishing.

**Note:** The exact details of the `EnergyPlusMessage`, `SimulationFinished`, and `JobsFinished` functions are not provided in the code snippet. These functions likely handle events related to the EnergyPlus simulation process.

The provided code appears to set up the necessary configurations and options for running a GA-based optimization of EnergyPlus simulations.

## The integration of design variables in the Energyplus files are undertook in the followind steps. 
1. Window-wall ratio 
2. Interior surface properties 
3. Overhang width 
4. Building height 
5. Roof insulation thickness 
6. Floor insulation thickness 
7. Wall insulation thickness 
8. Roof Insulation type

## Tags replacement
- `job.AddValues(tags);': replacing the tags with the values of desgin variables.

The job is then added to the `Launcher.Jobs` collection, and the entire simulation process is initiated with `Launcher.Run()`.

## Objective Functions 
### Acoustic Objective Calculations
The code calculates the reverberation time (`TR`) as an acoustic objective. It involves determining the absorption coefficients for different surfaces, calculating surface areas, and then applying Sabine's equation to find the reverberation time.

### Cost Objective
The cost objective is calculated based on various construction and material costs. This includes costs for glass, concrete blocks, brickwork, gypsum plaster, overhang, insulation, acoustic panels, and blinds. Surface areas of walls, windows, and roof are considered in the cost calculation.

The `Cost_Objective` is a combination of an initial cost (`Cost_other`) and an escalated cost (`Cost_escalation`), with the latter accounting for specific building components and materials.

## Thermal Comfort Objective
The code calculates the thermal comfort objective based on Fanger's Percentage Dissatisfied (PPD) model. It reads data from the EnergyPlus simulation output file (`eplusout.csv`) and a schedule file (`schedule_occupancy.xlsx`). It computes the average Fanger index both with and without considering the occupancy schedule.

## Energy Consumption Objective
Reads specific values from DesignBuilder table reports to calculate the energy consumption objective.

## Visual Comfort Objective
Calculates visual comfort by considering glare and illuminance using data from EnergyPlus simulations and a schedule.

## Aesthetics Objective
Calculates an aesthetic index (AI) based on specified weights and input parameters (window-to-wall ratio, overhang width, and change in building height).

## Carbon Emission Objective
Calculates the carbon emission objective, considering the environmental impact of various building materials and components.

This block of code is calculating the preference scores for different objectives using piecewise cubic Hermite interpolating polynomials (pchip). Each objective has a corresponding curve (presumably experimental or predefined), and the pchip function is used to interpolate the preference score for the actual performance of the system in each objective.

Here's an explanation for each line:

## Energy Consumption Objective (Objective_m(1))
Econsumption is the actual energy consumption obtained from simulations.
Econsmp_curve is a curve representing the relationship between energy consumption and preference scores.
pchip interpolates the preference score based on the actual energy consumption.

## Thermal Comfort Objective (Objective_m(2))
Thermalcomfort is the actual thermal comfort value obtained from simulations.
Thermal_curve is a curve representing the relationship between thermal comfort and preference scores.
pchip interpolates the preference score based on the actual thermal comfort.

## Acoustic Comfort Objective (Objective_m(3))
TR is the actual reverberation time obtained from simulations.
Acoustic_curve is a curve representing the relationship between reverberation time and preference scores.
pchip interpolates the preference score based on the actual reverberation time.

## Cost Objective (Objective_m(4))
Cost_Objective is the actual cost obtained from cost calculations.
Cost_curve is a curve representing the relationship between cost and preference scores.
pchip interpolates the preference score based on the actual cost.

## Glare Comfort Objective (Objective_m(5))
VisualcmfrtG is the actual glare comfort value obtained from simulations.
Glare_curve is a curve representing the relationship between glare comfort and preference scores.
pchip interpolates the preference score based on the actual glare comfort.

## Illuminance Comfort Objective (Objective_m(6))
VisualcmfrtI is the actual illuminance comfort value obtained from simulations.
Illuminance_curve is a curve representing the relationship between illuminance comfort and preference scores.
pchip interpolates the preference score based on the actual illuminance comfort.

## Aesthetics Objective (Objective_m(7))
A is the aesthetic index calculated based on specified weights and input parameters.
AS_curve is a curve representing the relationship between the aesthetic index and preference scores.
pchip interpolates the preference score based on the actual aesthetic index.

## Carbon Emission Objective (Objective_m(8))
ece_Change is the actual change in carbon emissions obtained from the calculations.
Ece_curve is a curve representing the relationship between carbon emissions and preference scores.
pchip interpolates the preference score based on the actual change in carbon emissions.

## Weight Vector (`w`)

- `w` is a vector containing weights for different objectives.
- It represents the relative importance assigned to each objective in the optimization process.
- For example, `w_Econ` represents the weight for the Energy Consumption objective, and similarly for other objectives.

## Goals Calculation

- `Objective_m` is a vector containing the preference scores for each objective.
- `goals` is calculated as the complement of `Objective_m` from 100. This means converting preference scores to distance from the "goals,".

## Optimization Calculation

- `Opt` is calculated as the maximum value obtained by element-wise multiplication of the weight vector (`w`) and the goals vector.
- The element-wise multiplication (`w .* goals`) results in a vector where each element represents the weighted goal for a specific objective.
- `max` is then used to find the maximum value among these weighted goals, indicating the optimal solution in terms of the weighted objectives.

  ## Optimization Section

The optimization section is using the Genetic Algorithm (GA) for multi-objective optimization.

### Number of Variables
- `numvars` is set to 8, indicating the number of variables in the optimization problem.

### Integer Variables
- `IntCon` is a vector specifying which variables are integers. In this case, variables 2, 3, 5, 6, 7, and 8 are defined as integers.

### Random Number Generation
- `rng('shuffle')` is used to initialize the random number generator with a seed based on the current time.

### Running Optimization
- The Genetic Algorithm (`ga`) is invoked with the following parameters:
  - Objective function: `ObjFunction`
  - Number of variables: `numvars`
  - Lower and upper bounds for variables: `lb` and `ub`
  - Constraint function: `Constr`
  - Integer constraints: `IntCon`
  - Options: `opts`

### Results Display
- The optimal values of variables (`xbest`) and the fitness function (`fbest`) are displayed.
  
### Exporting Solution
- The optimal solution is stored in the base workspace as a vector `[xbest fbest]`.

### End of Optimization Section
- The `end` statement marks the end of the optimization section.
