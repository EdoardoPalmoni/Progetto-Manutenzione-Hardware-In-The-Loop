function out = getIAE(err,ts)
    out = sum(abs(err),2)*ts;
end