lastwarn('');
addpath('Functions');
[warnMsg, warnId] = lastwarn;
while ~isempty(warnMsg)
    questdlg(['Functions directory not found; please select the sourceCode '...
        'scripts directory to add it to the search path'],'Select search dir',...
    'Ok','Ok');
    lastwarn('');
    cd(uigetdir);
    addpath('Functions');
    [warnMsg, warnId] = lastwarn;
end

if exist('kera','var')
    [~] = questdlg(['Warning: a variable called "kera" already exists; export your current KERA session to '...
        'a saved session, delete the kera variable, and then run this script again.  You can later reopen '...
        'the old session by clicking "import-->saved session" in your new kera (this is the only supported ' ...
        'method to open multiple kera sessions at once)'],'Kera overwrite warning','Ok','Ok');
    return
end


kera = Kera(1);
kera.gui.createPrimaryMenu('Import');
kera.gui.createSecondaryMenu('Import', 'ebFRET', @kera.ebfretImport);
kera.gui.createSecondaryMenu('Import', 'QuB', @kera.qubImport);
kera.gui.createSecondaryMenu('Import', 'Hammy', @kera.haMMYImport);
kera.gui.createSecondaryMenu('Import', 'hFRET', @kera.hFRETImport);
kera.gui.createSecondaryMenu('Import', 'Saved Session', @kera.importSPKG);
%add a line here to create a new import option, then create a function
%(like the @ functions above) inside the file Kera.m to execute your import
%script.  An example has been included as "exampleImport" there; rename it
%and fill it in with your own code

kera.gui.createPrimaryMenu('Export');
kera.gui.createSecondaryMenu('Export', 'Save Session', @kera.exportSPKG);
kera.gui.createSecondaryMenu('Export', 'Analyzed Data');
kera.gui.createSecondaryMenu('Analyzed Data', 'csv', @kera.exportAnalyzed);
kera.gui.createSecondaryMenu('Export', 'State Dwell Summary');
kera.gui.createSecondaryMenu('State Dwell Summary', 'csv', @kera.exportStateDwellSummary);

kera.gui.createPrimaryMenu('Analyze');
kera.gui.createSecondaryMenu('Analyze', 'View Data', @kera.viewTraces);
kera.gui.createSecondaryMenu('Analyze', 'Run/Refresh Analysis', @kera.processDataStates);
kera.gui.createSecondaryMenu('Analyze','Custom Search', @kera.customSearch);
kera.gui.createSecondaryMenu('Analyze','Regex Search (advanced)', @kera.regexSearchUI);

kera.gui.createPrimaryMenu('Settings');
kera.gui.createSecondaryMenu('Settings','Set channels and states', @kera.setChannelState);
kera.gui.createSecondaryMenu('Settings','Set time step', @kera.setTimeStep);
kera.gui.createSecondaryMenu('Settings','Set baseline state', @kera.setBaselineState);
kera.gui.createSecondaryMenu('Settings','Toggle intraevent kinetics', @kera.toggleDwellSelection);

%commands which should not be available at the beginning but which will be
%enabled later:
kera.gui.disable('Export');
kera.gui.disable('Analyze');
kera.gui.disable('Set baseline state');
kera.gui.disable('Toggle intraevent kinetics');
