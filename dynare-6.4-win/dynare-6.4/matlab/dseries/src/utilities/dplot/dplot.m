function dplot(varargin)

% Plot expressions extracting data from different dseries objects.
%
% EXAMPLE
%
% >> toto = dseries(randn(100,3), dates('2000Q1'), {'x','y','z'});
% >> noddy = dseries(randn(100,3), dates('2000Q1'), {'x','y','z'});
% >> b = 3;
% >> dplot --expression 2/b*cumsum(x/y(-1)-1) --dseries toto --dseries noddy --range 2001Q1:2024Q1 --title 'This is my plot'
%
% Will produce plots of 2*cumsum(x/y(-1)-1), where x and y are variables in objects toto and noddy,
% in the same figure.
%
% INPUTS
% --expression    followed by a mathematical expression involving variables available in the dseries objects, dseries methods, numbers or parameters.
% --dseries       followed by the name of a dseries object available in the workspace.
% --range         followed by a dates range.
% --style         followed by the name (without extension) of a matlab script, can be used to apply styling commands to the produced plot.
% --title         followed by a row char array, sets the plot title.
% --with-legend   prints a legend below the produced plot.
%
% REMARKS
% [1] More than one --expression argument is allowed
% [2] --expression arguments must come first
% [3] For each dseries object we plot all the expressions. We use two nested loops, the outer loop is over
%     the dseries objects and the inner loop over the expressions. This determines the ordering of the plotted
%     lines.
% [4] All dseries objects must be defined in the calling workspace, if a dseries object is missing the routine
%     throws a warning (we only build the plots for the available dseries objects), if all dseries objects are
%     missing the routine throws an error.
% [5] An expression involves variables (defined in dseries objects belonging to the caller workspace), parameters
%     (defined in the caller workspace) or numbers. dseries methods returning dseries objects can also be used
%     in an expression.
% [6] If the --range argument is missing the range is defined by the dates property of the first dseries object. In
%     in this case, lags/leads or diff on the variables should not be used.

% Copyright © 2023 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <https://www.gnu.org/licenses/>.

    % Get expressions to be plotted
    expressions = getexpressions(varargin);

    % Get dseriesnames
    names = getdseriesnames(varargin);

    % Put all dseries objects in a cell array
    data = cell(size(names));
    Names = names;
    for i=1:length(Names)
        try
            data{i} = evalin('caller', Names{i});
        catch
            warning('dplot:: dseries object %s is unknown.', Names{i})
            names(i) = [];
        end
    end
    assert(length(names)>0, 'dplot:: None of the dseries objects declared is available.')
    data = data(~cellfun(@isempty, data));
    % Check that all elements in data are actually dseries objects
    for i=1:length(data)
        if ~isdseries(data{i})
            error('%s is not a dseries object.', names{i})
        end
    end

    range = getrange(varargin);
    if isempty(range)
        range = data{1}.dates;
    end

    ts = cell(1, length(data)*length(expressions)); l = 0;
    Expressions = cell(size(expressions));

    if iswithlegend(varargin)
        legendnames = {};
    end

    for i=1:length(data)
        for j=1:length(expressions)
            % Check that brackets are balanced
            openbrackets = regexpi(expressions{j}, '(','match');
            closebrackets = regexpi(expressions{j}, ')','match');
            assert(length(openbrackets)==length(closebrackets), 'dplot:: Brackets are not balanced.')
            % Get all tokens
            tokens = unique(regexpi(expressions{j}, '\w*','match'));
            % Filter out dseries methods
            tokens = setdiff(tokens, allowedmethods());
            % Filter out numbers
            tokens = tokens(cellfun(@(x)isnan(str2double(x)), tokens));
            listofvariables = tokens(cellfun(@(x)ismember(x,data{i}.name), tokens));
            listofparameters = setdiff(tokens, listofvariables);
            % Test if parameters are defined scalars in the caller workspace
            for k=1:length(listofparameters)
                if ~evalin('caller', sprintf('exist(''%s'', ''var'')', listofparameters{k}))
                    error('dplot:: %s is not a known object.', listofparameters{k})
                end
                if ~evalin('caller', sprintf('isscalar(%s) && isnumeric(%s)', listofparameters{k}, listofparameters{k}))
                    error('dplot:: Parameter %s has to be a numeric scalar.', listofparameters{k})
                end
                eval(sprintf('%s = evalin(''caller'', sprintf(''%%s'', listofparameters{k}));', listofparameters{k}))
            end
            Expressions{j} = rewrite(expressions{j}, listofvariables, i);
            l = l+1;
            ts{l} = eval(Expressions{j});
            if iswithlegend(varargin)
                legendnames{l} = sprintf('%s [%s]', expressions{j}, names{i});
            end
        end
    end
    %
    % Build plots
    %
    plot(1:length(range), ts{1}(range).data)
    if length(ts)>1
        hold on
        for i=2:length(ts)
            plot(1:length(range), ts{i}(range).data)
        end
        hold off
    end
    axis tight
    %
    % Reset x-axis labels (with dates)
    %
    ax = gca;
    ax.XTick = unique(round(ax.XTick)); % Only keep integer labels
    id = ax.XTick;
    dd = strings(range(id));
    ax.XTickLabel = dd;
    if iswithlegend(varargin)
        legend(legendnames{:}, 'Location','SouthOutside','Orientation','horizontal','Box','off')
    end

    % Styling
    script = getstyle(varargin);
    if ~isempty(script)
        eval(script)
    end

    % Set title
    str = gettile(varargin);
    if ~isempty(str)
        str
        title(str)
    end
end

function expr = getexpressions(cellarray)

% Return expressions to be plotted.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - expr          [char]      1×p cell array of row char arrays.

    [epos, ~, rpos, zpos] = positions(cellarray);
    expr = cell(1, length(rpos));
    Epos = [epos, zpos];
    for i=1:length(epos)
        tmp = cellarray(Epos(i)+1:Epos(i+1)-1);
        expr{i} = strcat(tmp{:});
    end
end

function names = getdseriesnames(cellarray)

% Return expressions to be plotted.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - names         [char]      1×p cell array of row char arrays.

    [~, dpos] = positions(cellarray);

    names = cellarray(dpos+1);
end

function bool = iswithlegend(cellarray)

% Return true if and only if a legend below the plot is required.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - bool          [dates]     scalar.

    bool = contains('--with-legend', cellarray);

end

function range = getrange(cellarray)

% Return period range for the plots.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - range         [dates]

    [~, ~, rpos] = positions(cellarray);

    if length(rpos)==0
        range = dates();
        return
    end

    str = cellarray{rpos+1};
    sepid = strfind(str, ':');
    assert(~isempty(sepid), 'dplot:: --range argument is wrong.')
    assert(length(sepid)==1, 'dplot:: Only one semicolon is allowed in --range argument.')
    assert(isdate(str(1:sepid-1)), 'dplot:: --range argument is wrong (first declared period cannot be interpreted as a dates object).')
    assert(isdate(str(sepid+1:end)), 'dplot:: --range argument is wrong (second declared period cannot be interpreted as a dates object).')
    range = dates(str(1:sepid-1)):dates(str(sepid+1:end));

end

function script = getstyle(cellarray)

% Return period range for the plots.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - script        [char]      name of the styling script

    [~, ~, ~, ~, spos] = positions(cellarray);

    if isempty(spos)
        script = '';
        return
    end

    script = cellarray{spos+1};

end

function title = gettile(cellarray)

% Return period range for the plots.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - script        [char]      name of the styling script

    [~, ~, ~, ~, ~, tpos] = positions(cellarray);

    if isempty(tpos)
        title = '';
        return
    end

    title = cellarray{tpos+1};

end


function [epos, dpos, rpos, zpos, spos, tpos] = positions(cellarray)

% Return  positions of the arguments.
%
% INPUTS
% - cellarray     [char]      1×n cell array of row char arrays.
%
% OUTPUTS
% - epos          [integer]   1×pₑ vector, indices for the --expression arguments.
% - dpos          [integer]   1×pₛ vector, indices for the --dseries arguments.
% - rpos          [integer]   scalar, index of the --range argument.
% - zpos          [integer]   first index of non --expression argument.

% Indices for --expression arguments.
    epos = find(strcmp('--expression', cellarray));
    if isempty(epos)
        error('dplot::positions: --expression argument is mandatory.')
    end
    % Indices for the --dseries arguments.
    dpos = find(strcmp('--dseries', cellarray));
    if isempty(dpos)
        error('dplot::positions: --dseries argument is mandatory.')
    end
    % Index for --range argument.
    rpos = find(strcmp('--range', cellarray));
    assert(length(rpos)==1 || isempty(rpos), 'dplot::positions: Only one range is allowed.')
    % Define index for the first argument name different from --expression
    if isempty(rpos)
        zpos = dpos(1);
    else
        zpos = min(dpos(1), rpos);
    end
    % Check that expressions are coming before other arguments
    assert(max(epos)<zpos, 'dplot::positions: --expression must come before the other arguments.')
    % Index for --style argument
    spos = find(strcmp('--style', cellarray));
    assert(length(spos)==1 || isempty(spos), 'dplot::positions: Only one style script is allowed.')
    % Index for --title argument
    tpos = find(strcmp('--title', cellarray));
    assert(length(tpos)==1 || isempty(tpos), 'dplot::positions: Only one title is allowed.')
end

function m = allowedmethods()
    m = {'abs', 'center', 'cumprod', 'cumsum', 'detrend', 'dgrowth', 'diff', 'exp', 'log', 'hdiff', 'hgrowth', 'baxter_king_filter', ...
         'hpcycle', 'hptrend', 'onesidedhpcycle', 'onesidedhptrend', 'lag', 'lead', 'mdiff', 'mgrowth', 'qdiff', 'qgrowth', 'mean', 'std', ...
         'ydiff', 'ygrowth'};
end

function expr = rewrite(expr, list, index)
    for i=1:length(list)
        expr = regexprep(expr, sprintf('\\<%s\\>', list{i}), sprintf('data{%u}.%s', index, list{i}));
    end
end
