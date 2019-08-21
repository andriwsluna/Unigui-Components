object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 405
  ClientWidth = 727
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object EchoHightChart1: TEchoHightChart
    Left = 0
    Top = 0
    Width = 727
    Height = 405
    Hint = ''
    Align = alClient
    TabOrder = 0
    HighChartPath = '/Highcharts/'
    HTMLScriptMode = AutomaticMode
    JavasScriptMode = AutomaticMode
  end
end
