function out = getISE(err,ts)
    out = sum(err.^2,2)*ts;
end