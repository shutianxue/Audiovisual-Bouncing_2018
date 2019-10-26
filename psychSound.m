function pahandle = psychSound(beep,fs)

pahandle = PsychPortAudio('Open', [], 1, [], fs, 2, [], 0);
PsychPortAudio('FillBuffer', pahandle, [beep;beep]);
PsychPortAudio('Start',pahandle);
%PsychPortAudio('Stop', pahandle, 1); % If you want your experiment to continue while the sound is playing, 
                                      % you can omit this last line.
