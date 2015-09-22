function varargout = wave_clus_aux5(varargin)
% WAVE_CLUS_AUX1 M-file for wave_clus_aux.fig
%      WAVE_CLUS_AUX, by itself, creates a new WAVE_CLUS_AUX or raises the existing
%      singleton*.
%
%      H = WAVE_CLUS_AUX returns the handle to a new WAVE_CLUS_AUX or the handle to
%      the existing singleton*.
%
%      WAVE_CLUS_AUX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVE_CLUS_AUX.M with the given input arguments.
%
%      WAVE_CLUS_AUX('Property','Value',...) creates a new WAVE_CLUS_AUX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wave_clus_aux_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wave_clus_aux_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wave_clus_aux

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wave_clus_aux5_OpeningFcn, ...
                   'gui_OutputFcn',  @wave_clus_aux5_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before wave_clus_aux is made visible.
function wave_clus_aux5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wave_clus_aux (see VARARGIN)

% Choose default command line output for wave_clus_aux
handles.output = hObject;
set(handles.isi29_accept_button,'value',1);
set(handles.isi30_accept_button,'value',1);
set(handles.isi31_accept_button,'value',1);
set(handles.isi32_accept_button,'value',1);
set(handles.isi33_accept_button,'value',1);
set(handles.fix29_button,'value',0);
set(handles.fix30_button,'value',0);
set(handles.fix31_button,'value',0);
set(handles.fix32_button,'value',0);
set(handles.fix33_button,'value',0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wave_clus_aux wait for user response (see UIRESUME)
% uiwait(handles.wave_clus_aux);


% --- Outputs from this function are returned to the command line.
function varargout = wave_clus_aux5_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
USER_DATA = get(h_fig,'UserData');
par = USER_DATA{1};

for i = 29:33
	si = num2str(i);
	set(eval(['handles.isi' si '_accept_button']),'value',1);
	set(eval(['handles.isi' si '_reject_button']),'value',0);
	set(eval(['handles.fix' si '_button']),'value',0);
	
	eval(['set(handles.isi' si '_nbins,''string'',par.nbins' si ');']);
	eval(['set(handles.isi' si '_bin_step,''string'',par.bin_step' si ');']);
	
	% That's for passing the fix button settings to plot_spikes.
	if get(eval(['handles.fix' si '_button,''value'''])) ==1     
		eval(['par.fix' si ' = 1;']);
	else
		eval(['par.fix' si ' = 0;']);
	end
end

USER_DATA{1} = par;
set(handles.wave_clus_aux5,'userdata',USER_DATA)
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)

plot_spikes_aux(handles,5)



% Change nbins
% -------------------------------------------------------------
function isi_nbins_Callback(hObject, eventdata, handles)
b_name = get(gcbo,'Tag');
cn = regexp(b_name, '\d+', 'match');
USER_DATA = get(handles.wave_clus_aux1,'userdata');
par = USER_DATA{1};
eval(['par.nbins' cn{1}  '= str2num(get(hObject, ''String''));']);
USER_DATA{1} = par;
set(handles.wave_clus_aux1,'userdata',USER_DATA);
draw_histograms(handles,  str2double(cn{1}),USER_DATA);

% Change bin steps
% --------------------------------------------------------------------
function isi_bin_step_Callback(hObject, eventdata, handles)
b_name = get(gcbo,'Tag');
cn = regexp(b_name, '\d+', 'match');
USER_DATA = get(handles.wave_clus_aux1,'userdata');
par = USER_DATA{1};
eval(['par.bin_step' cn{1}  '= str2num(get(hObject, ''String''));']);
USER_DATA{1} = par;
set(handles.wave_clus_aux1,'userdata',USER_DATA);
draw_histograms(handles, str2double(cn{1}),USER_DATA);

% Reject buttons

% --------------------------------------------------------------------
function isi29_reject_button_Callback(hObject, eventdata, handles)
set(gcbo,'value',1);
set(handles.isi29_accept_button,'value',0);
USER_DATA = get(handles.wave_clus_aux5,'userdata');
classes = USER_DATA{6};
classes(find(classes==29))=0;
USER_DATA{6} = classes;
USER_DATA{9} = classes;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
axes(handles.spikes29); 
cla reset
axes(handles.isi29); 
cla reset
set(gcbo,'value',0);
set(handles.isi29_accept_button,'value',1);

% --------------------------------------------------------------------
function isi30_reject_button_Callback(hObject, eventdata, handles)
set(gcbo,'value',1);
set(handles.isi30_accept_button,'value',0);
USER_DATA = get(handles.wave_clus_aux5,'userdata');
classes = USER_DATA{6};
classes(find(classes==30))=0;
USER_DATA{6} = classes;
USER_DATA{9} = classes;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
axes(handles.spikes30); 
cla reset
axes(handles.isi30); 
cla reset
set(gcbo,'value',0);
set(handles.isi30_accept_button,'value',1);

% --------------------------------------------------------------------
function isi31_reject_button_Callback(hObject, eventdata, handles)
set(gcbo,'value',1);
set(handles.isi31_accept_button,'value',0);
USER_DATA = get(handles.wave_clus_aux5,'userdata');
classes = USER_DATA{6};
classes(find(classes==31))=0;
USER_DATA{6} = classes;
USER_DATA{9} = classes;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
axes(handles.spikes31); 
cla reset
axes(handles.isi31); 
cla reset
set(gcbo,'value',0);
set(handles.isi31_accept_button,'value',1);

% --------------------------------------------------------------------
function isi32_reject_button_Callback(hObject, eventdata, handles)
set(gcbo,'value',1);
set(handles.isi32_accept_button,'value',0);
USER_DATA = get(handles.wave_clus_aux5,'userdata');
classes = USER_DATA{6};
classes(find(classes==32))=0;
USER_DATA{6} = classes;
USER_DATA{9} = classes;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
axes(handles.spikes32); 
cla reset
axes(handles.isi32); 
cla reset
set(gcbo,'value',0);
set(handles.isi32_accept_button,'value',1);

% --------------------------------------------------------------------
function isi33_reject_button_Callback(hObject, eventdata, handles)
set(gcbo,'value',1);
set(handles.isi33_accept_button,'value',0);
USER_DATA = get(handles.wave_clus_aux5,'userdata');
classes = USER_DATA{6};
classes(find(classes==33))=0;
USER_DATA{6} = classes;
USER_DATA{9} = classes;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
axes(handles.spikes33); 
cla reset
axes(handles.isi33); 
cla reset
set(gcbo,'value',0);
set(handles.isi33_accept_button,'value',1);



% FIX buttons
% --------------------------------------------------------
function fix29_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux5,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==29);
if get(handles.fix29_button,'value') ==1
    USER_DATA{48} = fix_class;
    par.fix29 = 1;
else
    USER_DATA{48} = [];
    par.fix29 = 0
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
% --------------------------------------------------------
function fix30_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==30);
if get(handles.fix30_button,'value') ==1
    USER_DATA{49} = fix_class;
    par.fix30 = 1;
else
    USER_DATA{49} = [];
    par.fix30 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
% --------------------------------------------------------
function fix31_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==31);
if get(handles.fix31_button,'value') ==1
    USER_DATA{50} = fix_class;
    par.fix31 = 1;
else
    USER_DATA{50} = [];
    par.fix31 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
% --------------------------------------------------------
function fix32_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==32);
if get(handles.fix32_button,'value') ==1
    USER_DATA{51} = fix_class;
    par.fix32 = 1;
else
    USER_DATA{51} = [];
    par.fix32 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
% --------------------------------------------------------
function fix33_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==33);
if get(handles.fix33_button,'value') ==1
    USER_DATA{52} = fix_class;
    par.fix33 = 1;
else
    USER_DATA{52} = [];
    par.fix33 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux4');
set(handles.wave_clus_aux5,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
