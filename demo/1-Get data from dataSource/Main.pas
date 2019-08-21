unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniURLFrame,
  uEchoHightChart, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageBin;

type
  TMainForm = class(TUniForm)
    EchoHightChart1: TEchoHightChart;
    FDMemTable1: TFDMemTable;
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  EchoHightChart1.HighChartOptions.title.text.Value := 'Introduction';
  EchoHightChart1.HighChartOptions.series.Datasource.DataSet := FDMemTable1;
  EchoHightChart1.HighChartOptions.series.List.FieldNameForSerie := 'Operation';
  EchoHightChart1.HighChartOptions.series.List.FieldNameForX  := 'month';
  EchoHightChart1.HighChartOptions.series.List.FieldNameForY  := 'value';
  EchoHightChart1.Load;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
