unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniURLFrame,
  uEchoHightChart;

type
  TMainForm = class(TUniForm)
    EchoHightChart1: TEchoHightChart;
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

  With EchoHightChart1.HighChartOptions.series.List.Add DO
  BEGIN
    SerieName := 'Series 1';
    With Data.add DO
    BEGIN
      x.Value := 10;
      Y.Value := 15;
    END;

    With Data.add DO
    BEGIN
      x.Value := 20;
      Y.Value := 30;
    END;

    With Data.add DO
    BEGIN
      x.Value := 30;
      Y.Value := 40;
    END;
  END;

  With EchoHightChart1.HighChartOptions.series.List.Add DO
  BEGIN
    SerieName := 'Series 2';
    With Data.add DO
    BEGIN
      x.Value := 10;
      Y.Value := 10;
    END;

    With Data.add DO
    BEGIN
      x.Value := 20;
      Y.Value := 20;
    END;

    With Data.add DO
    BEGIN
      x.Value := 30;
      Y.Value := 30;
    END;
  END;

  EchoHightChart1.Load;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
