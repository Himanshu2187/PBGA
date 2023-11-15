folder=pwd;
NET.addAssembly(fullfile(folder,'EplusLauncher.dll'));
global Launcher;
Launcher = EplusLauncher.Launcher();
Launcher.MaxCores = 0;
Launcher.OutputFolderNumber = 0;
Launcher.JobsLogFile = (fullfile(folder,'jobs.csv'));

addlistener(Launcher,'OutputMessageReceived',@EnergyPlusMessage);
addlistener(Launcher,'SimulationCompleted',@SimulationFinished);
addlistener(Launcher,'JobsFinished',@JobsFinished);

config = EplusLauncher.Configuration();
config.InputFile = (fullfile(folder,'model.idf'));
config.WeatherFile = (fullfile(folder,'weather.epw'));
config.RviFile = (fullfile(folder,'model.rvi'));
config.EnergyPlusFolder = 'C:\EnergyPlusV9-4-0';
config.OutputFolder = (fullfile(folder,'OutputJob'));


job = EplusLauncher.Job(config);
Launcher.Jobs.Add(job);

Launcher.Run();
