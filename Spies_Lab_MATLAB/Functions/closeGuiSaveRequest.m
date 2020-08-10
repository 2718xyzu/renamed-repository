function closeGuiSaveRequest(~, ~, ~)
   selection = questdlg('Close KERA?  This will delete unsaved progress', ...
              'Warning', ...
              'Yes','No','Save a backup of the workspace','Yes');
    switch selection
        case 'Yes'
            delete(gcf) %the normal behavior for deleting a figure
        case 'No'
            return
        otherwise
            %something has gone terribly wrong
            evalin('base','save(''savingThrowError.mat'')');%make a saving throw for your data
                                                            %depending on what is causing the crash, this
                                                            %might not succeed, and where it's saved is
                                                            %probably the last place the working directory
                                                            %was set to

    end
end