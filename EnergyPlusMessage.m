function EnergyPlusMessage(~,args)
disp([char(args.SimulationFolder) ': ' char(args.Message)]);
end