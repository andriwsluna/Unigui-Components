{*******************************************************}
{                                                       }
{           EchoInfo Delphi Unigui Library              }
{                                                       }
{ Copyright(c) 2019 Echo Informática, LTDA.             }
{                                                       }
{Author           : Andriws Luna                        }
{Date             : 2019-06-01                          }
{publication date : 2019-08-21                          }
{*******************************************************}

unit uEchoHightChart;

interface

USES
  System.Classes, System.SysUtils,System.Rtti, System.TypInfo,
  System.Variants, system.VarUtils, Data.DB,
  System.Generics.Collections,
  uniURLFrame;

Type
  THighChartAlingValue = (alCenter,alLeft,alRight);
  THighChartVerticalAlingValue = (alTop,alMiddle,alBottom);
  THighChart3DPositionValue = (pOffset,pChart,pFlap,pOrtho);
  THighChartPositionValue = (pInside,pOutside);
  THighchartsAxisTypeValue = (tTinear,tLogarithmic,tDatetime,tCategory);
  THighchartsLayoutValue = (lHorizontal ,lVertical ,lProximate);
  THighchartsTypeValues =
  (
    tpArea,tpArearange,tpAreaspline,tpAreasplinerange,tpBar,tpBellcurve,
    tpBoxplot,tpBubble, tpBullet, tpColumn, tpColumnpyramid, tpColumnrange,
    tpCylinder, tpDependencywheel, tpErrorbar, tpFunnel, tpFunnel3d, tpGauge,
    tpHeatmap, tpHistogram, tpItem, tpLine, tpNetworkgraph, tpOrganization,
    tpPackedbubble, tpPareto, tpPie, tpPolygon, tpPyramid, tpPyramid3d,
    tpSankey, tpScatter, tpScatter3d, tpSeries, tpSolidgauge, tpSpline,
    tpStreamgraph, tpSunburst, tpTilemap, tpTimeline, tpTreemap, tpVariablepie,
    tpVariwide, tpVector, tpVenn, tpWaterfall, tpVindbarb, tpWordcloud, tpXrange
  );
  THighZoomTypeValue = (zoX, zoY, zoXY);
  THighStackingValue = (sNormal,spercent);
  THighChartSetpValue = (sCenter,sLeft,sRight);
  THighChartModeValue = (mNormal,mMonthly);
  TEchoHightScriptMode = (AutomaticMode,ManuaMode);



  THighValue = Class(TPersistent)
  strict private
    FGenerate : Boolean;
    FOwner    : THighValue;
    FOnchange : TNotifyEvent;

    Procedure FreeChilds;


    Procedure setGenerate( v : Boolean);
  protected
    CountTab : integer;
    sPrefixeObject : string;
    sPosfixeObject : String;
    ChildList : TObjectList<THighValue>;
    VariableName : string;

    Function  getTabs : string;
    Procedure CreateObjects; Virtual;
    Procedure InitializeObjects; Virtual;
    Procedure DestroyObjects; Virtual;
    Procedure UpdateVariableNames; Virtual;



    Procedure AddValue(SL : TStrings); Virtual;
    Function getGenerate : Boolean; Virtual;
  public
    Constructor Create(Owner : THighValue); Reintroduce;  Virtual;
    Destructor Destroy; Override;

    Function getValue : String; Virtual;

    Procedure Clear; Virtual;
    property Generate : Boolean Read getGenerate write setGenerate;
    Property Onchange : TNotifyEvent read FOnchange write FOnchange;
  End;

  THighSetValue = Class(THighValue)
  protected
    Procedure CreateObjects; Override;
  End;



  THighBoolean = Class(THighValue)
  strict private
    FValue : Boolean;

    Procedure setValue(V : Boolean);
  public
    Function getValue : String; Override;
    property Value : Boolean Read FValue write setValue;

  End;

  THighNumber = Class(THighValue)
  strict private
    FValue : integer;

    Procedure setValue(V : integer);
  public
    Function getValue : String; Override;
    property Value : integer Read FValue write setValue;
  End;

  THighFloat = Class(THighValue)
  strict private
    FValue : extended;

    Procedure setValue(V : extended);
  public
    Function getValue : String; Override;
    property Value : extended Read FValue write setValue;
  End;



  THighNullableNumber = Class(THighNumber)
  strict private
  public
    Function getValue : String; Override;
  End;

  THighString = Class(THighValue)
  strict private
    FValue : string;

    Procedure setValue(V : string);
  public
    Function getValue : String; Override;
  Public
    property Value : string Read FValue write setValue;
  End;

  THighGeneric = Class(THighString)
  strict private
  Public
    Function getValue : String; Override;

  End;

  THighStrings = Class(THighValue)
  Procedure Change(Sender : Tobject);
  strict private
    FValue : TStringlist;
  protected
    Procedure CreateObjects; Override;
    Procedure DestroyObjects; Override;
  public
    Function getValue : String; Override;
  Public
    property Value : TStringlist Read FValue;
  End;

  THighChartAling = Class(THighValue)
  strict private
    FValue : THighChartAlingValue;

    Procedure setValue(V : THighChartAlingValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighChartAlingValue Read FValue write setValue;
  End;

  THighChartVerticalAling  = Class(THighValue)
  strict private
    FValue : THighChartVerticalAlingValue;

    Procedure setValue(V : THighChartVerticalAlingValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighChartVerticalAlingValue Read FValue write setValue;
  End;

  THighChart3DPosition = Class(THighValue)
  strict private
    FValue : THighChart3DPositionValue;

    Procedure setValue(V : THighChart3DPositionValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighChart3DPositionValue Read FValue write setValue;
  End;

  THighChartPosition = Class(THighValue)
  strict private
    FValue : THighChartPositionValue;

    Procedure setValue(V : THighChartPositionValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighChartPositionValue Read FValue write setValue;
  End;

  THighNumbers = Class(THighValue)
  Procedure Change(Sender: TObject; const Item: extended;
    Action: TCollectionNotification);
  strict private
    FValue : TList<extended>;
  protected
    Procedure CreateObjects; Override;
    Procedure InitializeOBjects; Override;
    Procedure  DestroyObjects; Override;
  public
    Function getValue : String; Override;
  Public
    property Value : TList<extended> Read FValue write FValue;
  End;

  THighchartsAxisType = Class(THighValue)
  strict private
    FValue : THighchartsAxisTypeValue;
  public
    Function getValue : String; Override;
  Public
    property Value : THighchartsAxisTypeValue Read FValue write FValue;
  End;

  THighchartsLayout  = Class(THighValue)
  strict private
    FValue : THighchartsLayoutValue;

    Procedure setValue(V : THighchartsLayoutValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighchartsLayoutValue Read FValue write setValue;
  End;

  THighchartsType  = Class(THighValue)
  strict private
    FValue : THighchartsTypeValues;

    Procedure setValue(V : THighchartsTypeValues);
  public
    Function getValue : String; Override;
  Public
    property Value : THighchartsTypeValues Read FValue write setValue;
  End;

  THighZoomType = Class(THighValue)
  strict private
    FValue : THighZoomTypeValue;

    Procedure setValue(V : THighZoomTypeValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighZoomTypeValue Read FValue write setValue;
  End;

  THighStacking = Class(THighValue)
  strict private
    FValue : THighStackingValue;

    Procedure setValue(V : THighStackingValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighStackingValue Read FValue write setValue;
  End;

  THighChartSetp = Class(THighValue)
  strict private
    FValue : THighChartSetpValue;

    Procedure setValue(V : THighChartSetpValue);
  public
    Function getValue : String; Override;
  Public
    property Value : THighChartSetpValue Read FValue write setValue;
  End;


  THighChartMode =  Class(TPersistent)
  strict private
    FValue : THighChartModeValue;
    FOnChange : TNotifyEvent;
    Procedure setValue(V : THighChartModeValue);
  Public

    property Value : THighChartModeValue Read FValue write setValue;
    Property OnChange : TNotifyEvent read FOnChange write FOnChange;

  End;

  THighCredits = Class(THighValue)
  strict private
    Fenabled        : THighBoolean;
    Fhref           : THighString;
    Fstyle          : THighGeneric;
    Ftext           : THighString;


  protected
    Procedure CreateObjects;    Override;
    Procedure InitializeObjects;    Override;
  Public
    property enabled        : THighBoolean read Fenabled;
    property href           : THighString read  Fhref;
    property style          : THighGeneric read  Fstyle;
    property text           : THighString read  Ftext;
  End;


  THighTittle = Class(THighValue)
  strict private


    Falign          : THighChartAling;
    Ffloating       : THighBoolean;
    Fmargin         : THighNumber;
    Fstyle          : THighGeneric;
    Ftext           : THighString;
    FuseHTML        : THighBoolean;
    FVerticalAlign  : THighChartVerticalAling;
    FwidthAdjust    : THighNumber;
    FX              : THighNumber;
    FY              : THighNumber;
  protected
    Procedure CreateObjects;    Override;
    Procedure InitializeObjects;    Override;
  Public


    Property align          : THighChartAling         Read Falign;
    Property floating       : THighBoolean            Read Ffloating;
    Property margin         : THighNumber             Read Fmargin;
    Property style          : THighGeneric            Read Fstyle;
    Property text           : THighString             Read Ftext;
    Property useHTML        : THighBoolean            Read FuseHTML;
    Property VerticalAlign  : THighChartVerticalAling Read FVerticalAlign;
    Property widthAdjust    : THighNumber             Read FwidthAdjust;
    Property X              : THighNumber             Read FX;
    Property Y              : THighNumber             Read FY;

  End;





  THighLegend = Class(THighValue)
  strict private
    Faccessibility      : THighGeneric;
    Falign              : THighChartAling;
    FalignColumns       : THighBoolean;
    FbackgroundColor    : THighString;
    FborderColor        : THighString;
    FborderRadius       : THighNumber;
    FborderWidth        : THighNumber;
    FbubbleLegend       : THighGeneric;
    Fenabled            : THighBoolean;
    Ffloating           : THighBoolean;
    FitemCheckboxStyle  : THighGeneric;
    FitemDistance       : THighNumber;
    FitemHiddenStyle    : THighGeneric;
    FitemHoverStyle     : THighGeneric;
    FitemMarginBottom   : THighNumber;
    FitemMarginTop      : THighNumber;
    FitemStyle          : THighGeneric;
    FitemWidth          : THighNumber;
    FlabelFormat        : THighString;
    FlabelFormatter     : THighGeneric;
    Flayout             : THighchartsLayout;
    Fmargin             : THighNumber;
    FmaxHeight          : THighNumber;
    Fnavigation         : THighGeneric;
    Fpadding            : THighNumber;
    Freversed           : THighBoolean;
    Frtl                : THighBoolean;
    Fshadow             : THighBoolean;
    FsquareSymbol       : THighBoolean;
    FsymbolHeight       : THighNumber;
    FsymbolPadding      : THighNumber;
    FsymbolRadius       : THighNumber;
    FsymbolWidth        : THighNumber;
    Ftitle              : THighTittle;
    FuseHTML            : THighBoolean;
    FverticalAlign      : THighChartVerticalAling;
    Fwidth              : THighGeneric;
    Fx                  : THighNumber;
    Fy                  : THighNumber;
  protected
    Procedure CreateObjects;    Override;
    Procedure InitializeObjects; Override;
  Public
    property accessibility      : THighGeneric read  Faccessibility;
    property align              : THighChartAling read  Falign;
    property alignColumns       : THighBoolean read  FalignColumns;
    property backgroundColor    : THighString read  FbackgroundColor;
    property borderColor        : THighString read  FborderColor;
    property borderRadius       : THighNumber read  FborderRadius;
    property borderWidth        : THighNumber read  FborderWidth;
    property bubbleLegend       : THighGeneric read  FbubbleLegend;
    property enabled            : THighBoolean read  Fenabled;
    property floating           : THighBoolean read  Ffloating;
    property itemCheckboxStyle  : THighGeneric read  FitemCheckboxStyle;
    property itemDistance       : THighNumber read  FitemDistance;
    property itemHiddenStyle    : THighGeneric read  FitemHiddenStyle;
    property itemHoverStyle     : THighGeneric read  FitemHoverStyle;
    property itemMarginBottom   : THighNumber read  FitemMarginBottom;
    property itemMarginTop      : THighNumber read  FitemMarginTop;
    property itemStyle          : THighGeneric read  FitemStyle;
    property itemWidth          : THighNumber read  FitemWidth;
    property labelFormat        : THighString read  FlabelFormat;
    property labelFormatter     : THighGeneric read  FlabelFormatter;
    property layout             : THighchartsLayout    read  Flayout;
    property margin             : THighNumber read  Fmargin;
    property maxHeight          : THighNumber read  FmaxHeight;
    property navigation         : THighGeneric read Fnavigation;
    property padding            : THighNumber read  Fpadding;
    property reversed           : THighBoolean read  Freversed;
    property rtl                : THighBoolean read  Frtl;
    property shadow             : THighBoolean read  Fshadow;
    property squareSymbol       : THighBoolean read  FsquareSymbol;
    property symbolHeight       : THighNumber read  FsymbolHeight;
    property symbolPadding      : THighNumber              read  FsymbolPadding;
    property symbolRadius       : THighNumber              read FsymbolRadius;
    property symbolWidth        : THighNumber              read  FsymbolWidth;
    property title              : THighTittle              read  Ftitle;
    property useHTML            : THighBoolean             read  FuseHTML;
    property verticalAlign      : THighChartVerticalAling  read  FverticalAlign;
    property width              : THighGeneric             read  Fwidth;
    property x                  : THighNumber              read  Fx;
    property y                  : THighNumber              read  Fy;

  End;




  THighchartToolTip = Class(THighValue)
  strict private
    Fanimation            : THighBoolean;
    FbackgroundColor      : THighGeneric;
    FborderColor          : THighString;
    FborderRadius         : THighNumber;
    FborderWidth          : THighNumber;
    FdateTimeLabelFormats  : THighBoolean;
    Fenabled              : THighBoolean;
    FfollowPointer        : THighBoolean;
    FfollowTouchMove      : THighBoolean;
    FfooterFormat         : THighString;
    Fformatter            : THighGeneric;
    FheaderFormat         : THighString;
    FheaderShape          : THighGeneric;
    FhideDelay            : THighNumber;
    FnullFormat           : THighString;
    FnullFormatter        : THighGeneric;
    Foutside              : THighBoolean;
    Fpadding              : THighNumber;
    FpointFormat          : THighString;
    FpointFormatter       : THighGeneric;
    Fpositioner           : THighGeneric;
    Fshadow               : THighBoolean;
    Fshape                : THighGeneric;
    Fshared               : THighBoolean;
    Fsnap                 : THighNumber;
    Fsplit                : THighBoolean;
    Fstyle                : THighGeneric;
    FuseHTML              : THighBoolean;
    FvalueDecimals        : THighNumber;
    FvaluePrefix          : THighString;
    FvalueSuffix          : THighString;
    FxDateFormat          : THighString;

  protected
    Procedure CreateObjects;    Override;
    Procedure InitializeObjects;    Override;
  Public
    Property animation            : THighBoolean read  Fanimation;
    Property backgroundColor      : THighGeneric read  FbackgroundColor;
    Property borderColor          : THighString read  FborderColor;
    Property borderRadius         : THighNumber read  FborderRadius;
    Property borderWidth          : THighNumber read  FborderWidth;
    property dateTimeLabelFormats : THighBoolean read  FdateTimeLabelFormats;
    Property enabled              : THighBoolean read  Fenabled;
    Property followPointer        : THighBoolean read  FfollowPointer;
    Property followTouchMove      : THighBoolean read  FfollowTouchMove;
    Property footerFormat        : THighString  read FfooterFormat;
    Property formatter            : THighGeneric read  Fformatter;
    Property headerFormat         : THighString read  FheaderFormat;
    Property headerShape          : THighGeneric read  FheaderShape;
    Property hideDelay            : THighNumber read  FhideDelay;
    Property nullFormat           : THighString read  FnullFormat;
    Property nullFormatter        : THighGeneric read  FnullFormatter;
    Property outside              : THighBoolean read  Foutside;
    Property padding              : THighNumber read  Fpadding;
    Property pointFormat          : THighString read FpointFormat;
    Property pointFormatter       : THighGeneric read  FpointFormatter;
    Property positioner           : THighGeneric read  Fpositioner;
    Property shadow               : THighBoolean read  Fshadow;
    Property shape                : THighGeneric read  Fshape;
    Property shared               : THighBoolean read  Fshared;
    Property snap                 : THighNumber read  Fsnap;
    Property split                : THighBoolean read  Fsplit;
    Property style                : THighGeneric read  Fstyle;
    Property useHTML              : THighBoolean read  FuseHTML;
    Property valueDecimals        : THighNumber read  FvalueDecimals;
    Property valuePrefix          : THighString read  FvaluePrefix;
    Property valueSuffix          : THighString read  FvalueSuffix;
    Property xDateFormat          : THighString read  FxDateFormat;

  End;



  TAxisAccessibility = Class(THighValue)

  strict private
    Fdescription      : THighString;
    Fenabled          : THighBoolean;
    FrangeDescription : THighString;
  protected
    Procedure CreateObjects;    Override;
  Public
    property description      : THighString    read Fdescription;
    property enabled          : THighBoolean   read Fenabled;
    property rangeDescription : THighString    read FrangeDescription;
  End;

  TAxisCrossHair = Class(THighValue)
  strict private
    FclassName  : THighString;
    Fcolor      : THighString;
    Fsnap       : THighBoolean;
    FdashStyle  : THighGeneric;
    Fwidth      : THighNumber;
    FzIndex     : THighNumber;
  protected
    Procedure CreateObjects;    Override;
  Public
    property className  : THighString   read  FclassName;
    property color      : THighString   read  Fcolor;
    property dashStyle  : THighGeneric  read  FdashStyle;
    property snap       : THighBoolean  read  Fsnap;
    property width      : THighNumber   read  Fwidth;
    property zIndex     : THighNumber   read FzIndex;


  End;

  THighCustomLabel = Class(THighValue)
  strict private
    Falign              : THighChartAling;
    FautoRotation       : THighGeneric;
    FautoRotationLimit  : THighNumber;
    FboxesToAvoid       : THighGeneric;
    FconnectorAllowed   : THighBoolean;
    FconnectorNeighbourDistance : THighNumber;
    Fdistance           : THighNumber;
    Fenabled            : THighBoolean;
    Fformat             : THighString;
    Fformatter          : THighGeneric;
    FmaxFontSize        : THighNullableNumber;
    FminFontSize        : THighNullableNumber;
    FonArea             : THighGeneric;
    Foverflow           : THighBoolean;
    Fpadding            : THighNumber;
    Fposition3d         : THighChart3DPosition;
    FreserveSpace       : THighBoolean;
    Frotation           : THighNumber;
    Fskew3d             : THighBoolean;
    FstaggerLines       : THighNumber;
    Fstep               : THighNumber;
    Fstyle              : THighGeneric;
    Ftext               : THighString;
    FtextAlign          : THighChartAling;
    FuseHTML            : THighNumber;
    FverticalAlign      : THighChartVerticalAling;
    Fx                  : THighNumber;
    Fy                  : THighNumber;
    FzIndex             : THighNumber;


  protected

    property align              : THighChartAling       read  Falign;
    Property autoRotation       : THighGeneric          read FautoRotation;
    property autoRotationLimit  : THighNumber           read  FautoRotationLimit;
    Property boxesToAvoid       : THighGeneric          read FboxesToAvoid;
    Property connectorAllowed   : THighBoolean          read FconnectorAllowed;
    Property connectorNeighbourDistance : THighNumber   read FconnectorNeighbourDistance;
    property distance           : THighNumber           read  Fdistance;
    property enabled            : THighBoolean          read  Fenabled;
    property format             : THighString           read  Fformat;
    property formatter          : THighGeneric          read  Fformatter;
    Property maxFontSize        : THighNullableNumber   read FmaxFontSize;
    Property minFontSize        : THighNullableNumber   read FminFontSize;
    Property onArea             : THighGeneric          read FonArea;
    property overflow           : THighBoolean          read  Foverflow;
    property padding            : THighNumber           read  Fpadding;
    property position3d         : THighChart3DPosition  read  Fposition3d;
    property reserveSpace       : THighBoolean          read  FreserveSpace;
    property rotation           : THighNumber           read  Frotation;
    property skew3d             : THighBoolean          read  Fskew3d;
    property staggerLines       : THighNumber           read  FstaggerLines;
    property step               : THighNumber           read  Fstep;
    property style              : THighGeneric          read  Fstyle;
    Property text               : THighString           read Ftext;
    Property textAlign          : THighChartAling       read FtextAlign;
    property useHTML            : THighNumber           read  FuseHTML;
    Property verticalAlign      : THighChartVerticalAling read FverticalAlign;
    property x                  : THighNumber           read  Fx;
    property y                  : THighNumber           read  Fy;
    property zIndex             : THighNumber           read  FzIndex;


    Procedure CreateObjects;    Override;

    Procedure UpdateVariableNames; Override;
  End;

  THighSeriesLabel = Class(THighCustomLabel)
  protected
    Procedure InitializeObjects;    Override;
  Public
    property boxesToAvoid;
    Property connectorAllowed;
    property connectorNeighbourDistance;
    property enabled;
    property maxFontSize;
    property minFontSize;
    property onArea;
    property style;
  End;

  THighAxisPlotLabel = Class(THighCustomLabel)

  Public
    property align;
    Property rotation;
    property style;
    property text;
    property textAlign;
    property useHTML;
    property verticalAlign;
    property x;
    property y;
  End;

  THighAxisLabel = Class(THighCustomLabel)
  protected
    Procedure InitializeObjects; Override;

  Public
    property align;
    Property autoRotation;
    property autoRotationLimit;
    property distance;
    property enabled;
    property format;
    property formatter;
    property overflow;
    property padding;
    property position3d;
    property reserveSpace;
    property rotation;
    property skew3d;
    property staggerLines;
    property step;
    property style;
    property useHTML;
    property x;
    property y;
    property zIndex;


  End;


  TAxisPlotBands = Class(THighValue)
  strict private
    FborderColor    : THighString;
    FborderWidth    : THighNumber;
    FclassName      : THighString;
    Fcolor          : THighGeneric;
    Fevents         : THighGeneric;
    Ffrom           : THighNumber;
    Fid             : THighString;
    Flabel          : THighAxisPlotLabel;
    Fto             : THighNumber;
    FzIndex         : THighNumber;

  protected
     Procedure CreateObjects;    Override;
  Public
    property borderColor    : THighString       read  FborderColor;
    property borderWidth    : THighNumber       read  FborderWidth;
    property className      : THighString       read  FclassName;
    property color          : THighGeneric      read  Fcolor;
    property events         : THighGeneric      read  Fevents;
    property from           : THighNumber       read  Ffrom;
    property id             : THighString       read  Fid;
    property label_         : THighAxisPlotLabel  read  Flabel;
    property to_            : THighNumber       read  Fto;
    property zIndex         : THighNumber       read  FzIndex;

  End;

  TAxisPlotLines = Class(THighValue)
  strict private
    FclassName        : THighString;
    Fcolor            : THighString;
    FdashStyle        : THighGeneric;
    Fevents           : THighGeneric;
    Fid               : THighString;
    Flabel            : THighAxisPlotLabel;
    FValue            : THighNumber;
    Fwidth            : THighNumber;
    FzIndex           : THighNumber;
  protected
     Procedure CreateObjects;    Override;
  Public
    property className        : THighString      read  FclassName;
    property color            : THighString      read  Fcolor;
    property dashStyle        : THighGeneric     read  FdashStyle;
    property events           : THighGeneric     read  Fevents;
    property id               : THighString      read  Fid;
    property label_           : THighAxisPlotLabel read  Flabel;
    property Value            : THighNumber      read  FValue;
    property width            : THighNumber      read  Fwidth;
    property zIndex           : THighNumber      read  FzIndex;

  End;

  TAxisOption = Class(THighValue)

  strict private
    Faccessibility        : TAxisAccessibility;
    FalignTicks           : THighBoolean;
    FallowDecimals        : THighBoolean;
    FalternateGridColor   : THighBoolean;
    Fangle                : THighNumber;
    Fbreaks               : THighGeneric;
    Fcategories           : THighStrings;
    Fceiling              : THighNumber;
    FclassName            : THighString;
    Fcrosshair            : TAxisCrossHair;
    FdateTimeLabelFormats : THighGeneric;
    FendOnTick            : THighBoolean;
    Fevents               : THighGeneric;
    Ffloor                : THighNumber;
    FgridLineColor        : THighString;
    FgridLineDashStyle    : THighGeneric;
    FgridLineInterpolation: THighString;
    FgridLineWidth        : THighNumber;
    FgridZIndex           : THighNumber;
    Fid                   : THighNumber;
    Flabels               : THighAxisLabel;
    FlineColor            : THighString;
    FlineWidth            : THighNumber;
    FlinkedTo             : THighNumber;
    Fmargin               : THighNumber;
    Fmax                  : THighFloat;
    FmaxColor             : THighString;
    FmaxPadding           : THighNumber;
    Fmin                  : THighNullableNumber;
    FminColor             : THighString;
    FminorGridLineColor   : THighString;
    FminorGridLineDashStyle : THighGeneric;
    FminorGridLineWidth   : THighNumber;
    FminorTickColor       : THighString;
    FminorTickInterval    : THighGeneric;
    FminorTickLength      : THighNumber;
    FminorTickPosition    : THighChartPosition;
    FminorTicks           : THighBoolean;
    FminorTickWidth       : THighNumber;
    FminPadding           : THighNumber;
    FminRange             : THighNumber;
    FminTickInterval      : THighNumber;
    Foffset               : THighNumber;
    Fopposite             : THighBoolean;
    Fpane                 : THighNumber;
    FplotBands            : TAxisPlotBands;
    FplotLines            : TAxisPlotLines;
    Freversed             : THighBoolean;
    FreversedStacks       : THighBoolean;
    FshowEmpty            : THighBoolean;
    FshowFirstLabel       : THighBoolean;
    FshowLastLabel        : THighBoolean;
    FsoftMax              : THighNumber;
    FsoftMin              : THighNumber;
    FstackLabels          : THighGeneric;
    FstartOfWeek          : THighNumber;
    FstartOnTick          : THighBoolean;
    Fstops                : THighGeneric;
    FtickAmount           : THighNumber;
    FtickColor            : THighString;
    FtickInterval         : THighNumber;
    FtickLength           : THighNumber;
    FtickmarkPlacement    : THighString;
    FtickPixelInterval    : THighNumber;
    FtickPosition         : THighChartPosition;
    FtickPositioner       : THighGeneric;
    FtickPositions        : THighNumbers;
    FtickWidth            : THighNumber;
    Ftitle                : THighTittle;
    Ftype                 : THighchartsAxisType;
    FuniqueNames          : THighBoolean;
    Funits                : THighGeneric;
    Fvisible              : THighBoolean;
  protected

    property accessibility        : TAxisAccessibility    read  Faccessibility;
    property alignTicks           : THighBoolean          read  FalignTicks;
    property allowDecimals        : THighBoolean          read  FallowDecimals;
    property alternateGridColor   : THighBoolean          read  FalternateGridColor;
    property angle                : THighNumber           read  Fangle;
    property breaks               : THighGeneric          read  Fbreaks;
    property categories           : THighStrings          read  Fcategories;
    property ceiling              : THighNumber           read  Fceiling;
    property className            : THighString           read  FclassName;
    property crosshair            : TAxisCrossHair        read  Fcrosshair;
    property dateTimeLabelFormats : THighGeneric          read  FdateTimeLabelFormats;
    property endOnTick            : THighBoolean          read  FendOnTick;
    property events               : THighGeneric          read  Fevents;
    property floor                : THighNumber           read  Ffloor;
    property gridLineColor        : THighString           read  FgridLineColor;
    property gridLineDashStyle    : THighGeneric          read  FgridLineDashStyle;
    property gridLineInterpolation: THighString           read  FgridLineInterpolation;
    property gridLineWidth        : THighNumber           read  FgridLineWidth;
    property gridZIndex           : THighNumber           read  FgridZIndex;
    property id                   : THighNumber           read  Fid;
    property labels               : THighAxisLabel        read  Flabels;
    property lineColor            : THighString           read  FlineColor;
    property lineWidth            : THighNumber           read  FlineWidth;
    property linkedTo             : THighNumber           read  FlinkedTo;
    property margin               : THighNumber           read  Fmargin;
    property max                  : THighFloat   read  Fmax;
    property maxColor             : THighString           read  FmaxColor;
    property maxPadding           : THighNumber           read  FmaxPadding;
    property min                  : THighNullableNumber   read  Fmin;
    property minColor             : THighString           read  FminColor;
    property minorGridLineColor   : THighString           read  FminorGridLineColor;
    property minorGridLineDashStyle : THighGeneric        read  FminorGridLineDashStyle;
    property minorGridLineWidth   : THighNumber           read  FminorGridLineWidth;
    property minorTickColor       : THighString           read  FminorTickColor;
    property minorTickInterval    : THighGeneric           read  FminorTickInterval;
    property minorTickLength      : THighNumber           read  FminorTickLength;
    property minorTickPosition    : THighChartPosition    read  FminorTickPosition;
    property minorTicks           : THighBoolean          read  FminorTicks;
    property minorTickWidth       : THighNumber           read  FminorTickWidth;
    property minPadding           : THighNumber           read  FminPadding;
    property minRange             : THighNumber           read  FminRange;
    property minTickInterval      : THighNumber           read  FminTickInterval;
    property offset               : THighNumber           read  Foffset;
    property opposite             : THighBoolean          read  Fopposite;
    property pane                 : THighNumber           read  Fpane;
    property plotBands            : TAxisPlotBands        read  FplotBands;
    property plotLines            : TAxisPlotLines        read  FplotLines;
    property reversed             : THighBoolean          read  Freversed;
    property reversedStacks       : THighBoolean          read  FreversedStacks;
    property showEmpty            : THighBoolean          read  FshowEmpty;
    property showFirstLabel       : THighBoolean          read  FshowFirstLabel;
    property showLastLabel        : THighBoolean          read  FshowLastLabel;
    property softMax              : THighNumber           read  FsoftMax;
    property softMin              : THighNumber           read  FsoftMin;
    property stackLabels          : THighGeneric          read  FstackLabels;
    property startOfWeek          : THighNumber           read  FstartOfWeek;
    property startOnTick          : THighBoolean          read  FstartOnTick;
    property stops                : THighGeneric          read  Fstops;
    property tickAmount           : THighNumber           read  FtickAmount ;
    property tickColor            : THighString           read  FtickColor;
    property tickInterval         : THighNumber           read  FtickInterval;
    property tickLength           : THighNumber           read  FtickLength;
    property tickmarkPlacement    : THighString           read  FtickmarkPlacement;
    property tickPixelInterval    : THighNumber           read  FtickPixelInterval;
    property tickPosition         : THighChartPosition    read  FtickPosition;
    property tickPositioner       : THighGeneric          read  FtickPositioner;
    property tickPositions        : THighNumbers          read  FtickPositions;
    property tickWidth            : THighNumber           read  FtickWidth;
    property title                : THighTittle          read  Ftitle;
    property typex                 : THighchartsAxisType   read  Ftype;
    property uniqueNames          : THighBoolean          read  FuniqueNames;
    property units                : THighGeneric           read  Funits;
    property visible              : THighBoolean          read  Fvisible;

    Procedure CreateObjects;    Override;
    Procedure UpdateVariableNames; Override;
  End;

  TXAxisOption = Class(TAxisOption)
  Public
    property accessibility;
    property alignTicks;
    property allowDecimals;
    property alternateGridColor;
    property breaks;
    property categories;
    property ceiling;
    property className;
    property crosshair;
    property dateTimeLabelFormats;
    property endOnTick;
    property floor;
    property gridLineColor;
    property gridLineWidth;
    property gridZIndex;
    property id;
    property labels;
    property lineColor;
    property lineWidth;
    property linkedTo;
    property margin;
    property max;
    property maxPadding;
    property min;
    property minorGridLineColor;
    property minorGridLineDashStyle;
    property minorGridLineWidth;
    property minorTickColor;
    property minorTickInterval;
    property minorTickLength;
    property minorTickPosition;
    property minorTicks;
    property minorTickWidth;
    property minPadding;
    property minRange;
    property minTickInterval;
    property offset;
    property opposite;
    property pane;
    property plotBands;
    property plotLines;
    property reversed;
    property reversedStacks;
    property showEmpty;
    property showFirstLabel;
    property showLastLabel;
    property softMax;
    property softMin;
    property startOfWeek;
    property startOnTick;
    property tickAmount;
    property tickColor;
    property tickInterval;
    property tickLength;
    property tickmarkPlacement;
    property tickPixelInterval;
    property tickPosition;
    property tickPositioner;
    property tickPositions;
    property tickWidth;
    property title;
    property typex;
    property uniqueNames;
    property units;
    property visible;
  End;

  TYAxisOption = Class(TAxisOption)
  Public
    property accessibility;
    property alignTicks;
    property allowDecimals;
    property alternateGridColor;
    property angle;
    property breaks;
    property categories;
    property ceiling;
    property className;
    property crosshair;
    property dateTimeLabelFormats;
    property endOnTick;
    property events;
    property floor;
    property gridLineColor;
    property gridLineDashStyle;
    property gridLineInterpolation;
    property gridLineWidth;
    property gridZIndex;
    property id;
    property labels;
    property lineColor;
    property lineWidth;
    property linkedTo;
    property margin;
    property max;
    property maxColor;
    property maxPadding;
    property min;
    property minColor;
    property minorGridLineColor;
    property minorGridLineDashStyle;
    property minorGridLineWidth;
    property minorTickColor;
    property minorTickInterval;
    property minorTickLength;
    property minorTickPosition;
    property minorTicks;
    property minorTickWidth;
    property minPadding;
    property minRange;
    property minTickInterval;
    property offset;
    property opposite;
    property pane;
    property plotBands;
    property plotLines;
    property reversed;
    property reversedStacks;
    property showEmpty;
    property showFirstLabel;
    property showLastLabel;
    property softMax;
    property softMin;
    property stackLabels;
    property startOfWeek;
    property startOnTick;
    property stops;
    property tickAmount;
    property tickColor;
    property tickInterval;
    property tickLength;
    property tickmarkPlacement;
    property tickPixelInterval;
    property tickPosition;
    property tickPositioner;
    property tickPositions;
    property tickWidth;
    property title;
    property typex;
    property uniqueNames;
    property units;
    property visible;
  End;


  TArrayXAxisOption = Class(THighValue)
  strict private
    FAxis : TObjectList<TXAxisOption>;
  protected
    Function getGenerate : Boolean; Virtual;
    Procedure CreateObjects; Override;
    Procedure DestroyObjects; Override;
    Procedure AddValue(SL : TStrings); Override;
  Public
    Property Axis : TObjectList<TXAxisOption> read FAxis;
  End;

  TArrayYAxisOption = Class(THighValue)
  strict private
    FAxis : TObjectList<TYAxisOption>;
  protected
    Function getGenerate : Boolean; Virtual;
    Procedure CreateObjects; Override;
    Procedure DestroyObjects; Override;
    Procedure AddValue(SL : TStrings); Override;
  Public
    Property Axis : TObjectList<TYAxisOption> read FAxis;
  End;

  THighChart = Class(THighValue)
  strict private
    FalignTicks           : THighBoolean;
    Fanimation            : THighBoolean;
    FbackgroundColor      : THighGeneric;
    FborderColor          : THighString;
    FborderRadius         : THighNumber;
    FborderWidth          : THighNumber;
    FclassName            : THighString;
    FcolorCount           : THighNumber;
    FdisplayErrors        : THighBoolean;
    Fevents               : THighGeneric;
    Fheight               : THighGeneric;
    FignoreHiddenSeries   : THighBoolean;
    Finverted             : THighBoolean;
    Fmargin               : THighGeneric;
    FmarginBottom         : THighNumber;
    FmarginLeft           : THighNumber;
    FmarginRight          : THighNumber;
    FmarginTop            : THighNumber;
    Foptions3d            : THighGeneric;
    FpanKey               : THighString;
    Fpanning              : THighBoolean;
    FparallelAxes         : THighGeneric;
    FparallelCoordinates  : THighBoolean;
    FpinchType            : THighString;
    FplotBackgroundColor  : THighGeneric;
    FplotBackgroundImage  : THighString;
    FplotBorderColor      : THighString;
    FplotBorderWidth      : THighNumber;
    FplotShadow           : THighGeneric;
    Fpolar                : THighBoolean;
    Freflow               : THighBoolean;
    FrenderTo             : THighGeneric;
    FresetZoomButton      : THighGeneric;
    FscrollablePlotArea   : THighGeneric;
    FselectionMarkerFill  : THighString;
    Fshadow               : THighGeneric;
    FshowAxes             : THighBoolean;
    Fspacing              : THighNumbers;
    FspacingBottom        : THighNumber;
    FspacingLeft          : THighNumber;
    FspacingRight         : THighNumber;
    FspacingTop           : THighNumber;
    Fstyle                : THighGeneric;
    FstyledMode           : THighBoolean;
    Ftype                 : THighchartsType;
    Fwidth                : THighGeneric;
    FzoomKey              : THighString;
    FzoomType             : THighZoomType;
  protected
    Procedure CreateObjects;    Override;
    Procedure InitializeObjects;    Override;
  Public
    property alignTicks           : THighBoolean read  FalignTicks;
    property animation            : THighBoolean read  Fanimation;
    property backgroundColor      : THighGeneric read  FbackgroundColor;
    property borderColor          : THighString read  FborderColor;
    property borderRadius         : THighNumber read  FborderRadius;
    property borderWidth          : THighNumber read  FborderWidth;
    property className            : THighString read  FclassName;
    property colorCount           : THighNumber read  FcolorCount;
    property displayErrors        : THighBoolean read  FdisplayErrors;
    property events               : THighGeneric read  Fevents;
    property height               : THighGeneric read  Fheight;
    property ignoreHiddenSeries   : THighBoolean read  FignoreHiddenSeries;
    property inverted             : THighBoolean read  Finverted;
    property margin               : THighGeneric read  Fmargin;
    property marginBottom         : THighNumber read  FmarginBottom;
    property marginLeft           : THighNumber read  FmarginLeft;
    property marginRight          : THighNumber read  FmarginRight;
    property marginTop            : THighNumber read  FmarginTop;
    property options3d            : THighGeneric read  Foptions3d;
    property panKey               : THighString read  FpanKey;
    property panning              : THighBoolean read  Fpanning;
    property parallelAxes         : THighGeneric read  FparallelAxes;
    property parallelCoordinates  : THighBoolean read  FparallelCoordinates;
    property pinchType            : THighString read  FpinchType;
    property plotBackgroundColor  : THighGeneric read  FplotBackgroundColor;
    property plotBackgroundImage  : THighString read  FplotBackgroundImage;
    property plotBorderColor      : THighString read  FplotBorderColor;
    property plotBorderWidth      : THighNumber read  FplotBorderWidth;
    property plotShadow           : THighGeneric read  FplotShadow;
    property polar                : THighBoolean read  Fpolar;
    property reflow               : THighBoolean read  Freflow;
    property renderTo             : THighGeneric read  FrenderTo;
    property resetZoomButton      : THighGeneric read  FresetZoomButton;
    property scrollablePlotArea   : THighGeneric read  FscrollablePlotArea;
    property selectionMarkerFill  : THighString read  FselectionMarkerFill;
    property shadow               : THighGeneric read  Fshadow;
    property showAxes             : THighBoolean read  FshowAxes;
    property spacing              : THighNumbers read  Fspacing;
    property spacingBottom        : THighNumber read  FspacingBottom;
    property spacingLeft          : THighNumber read  FspacingLeft;
    property spacingRight         : THighNumber read  FspacingRight;
    property spacingTop           : THighNumber read  FspacingTop;
    property style                : THighGeneric read Fstyle;
    property styledMode           : THighBoolean read  FstyledMode;
    property type_                 : THighchartsType read  Ftype;
    property width                : THighGeneric read  Fwidth;
    property zoomKey              : THighString read  FzoomKey;
    property zoomType             : THighZoomType read  FzoomType;

  End;

  THighLoading = Class(THighValue)
  strict private
    FhideDuration     : THighNumber;
    FlabelStyle       : THighGeneric;
    FshowDuration     : THighNumber;
    Fstyle            : THighGeneric;

  protected
    Procedure CreateObjects;    Override;
  Public
    property hideDuration     : THighNumber  read  FhideDuration;
    property labelStyle       : THighGeneric read  FlabelStyle;
    property showDuration     : THighNumber  read  FshowDuration;
    property style            : THighGeneric read  Fstyle;
  End;

  THighDataLabelsOptions = Class(THighValue)
  strict private
    Falign            : THighChartAling;
    FallowOverlap     : THighBoolean;
    FbackgroundColor  : THighGeneric;
    FborderColor      : THighString;
    FborderRadius     : THighNumber;
    FborderWidth      : THighNumber;
    FclassName        : THighString;
    Fcolor            : THighString;
    Fcrop             : THighBoolean;
    Fdefer            : THighBoolean;
    Fenabled          : THighBoolean;
    Ffilter           : THighGeneric;
    Fformat           : THighString;
    Fformatter        : THighGeneric;
    Finside           : THighBoolean;
    FnullFormat       : THighGeneric;
    FnullFormatter    : THighGeneric;
    Foverflow         : THighGeneric;
    Fpadding          : THighNumber;
    Frotation         : THighNumber;
    Fshadow           : THighGeneric;
    Fshape            : THighString;
    Fstyle            : THighGeneric;
    FtextPath         : THighGeneric;
    FuseHTML          : THighBoolean;
    FverticalAlign    : THighChartVerticalAling;
    Fx                : THighNumber;
    Fy                : THighNumber;
    FzIndex           : THighNumber;
  protected
    Procedure CreateObjects;    Override;
  public
    property align            : THighChartAling read Falign;
    property allowOverlap     : THighBoolean read FallowOverlap;
    property backgroundColor  : THighGeneric read FbackgroundColor;
    property borderColor      : THighString read FborderColor;
    property borderRadius     : THighNumber read FborderRadius;
    property borderWidth      : THighNumber read FborderWidth;
    property className        : THighString read FclassName;
    property color            : THighString read Fcolor;
    property crop             : THighBoolean read Fcrop;
    property defer            : THighBoolean read Fdefer;
    property enabled          : THighBoolean read Fenabled;
    property filter           : THighGeneric read Ffilter;
    property format           : THighString read Fformat;
    property formatter        : THighGeneric read Fformatter;
    property inside           : THighBoolean read Finside;
    property nullFormat       : THighGeneric read FnullFormat;
    property nullFormatter    : THighGeneric read FnullFormatter;
    property overflow         : THighGeneric read Foverflow;
    property padding          : THighNumber read Fpadding;
    property rotation         : THighNumber read Frotation;
    property shadow           : THighGeneric read Fshadow;
    property shape            : THighString read Fshape;
    property style            : THighGeneric read Fstyle;
    property textPath         : THighGeneric read FtextPath;
    property useHTML          : THighBoolean read FuseHTML;
    property verticalAlign    : THighChartVerticalAling read FverticalAlign;
    property x                : THighNumber read Fx;
    property y                : THighNumber read Fy;
    property zIndex           : THighNumber read FzIndex;

  End;

  THighchartsCustomPlotOptions = Class(THighValue)
  strict private
    Faccessibility              : THighGeneric;
    FallowPointSelect           : THighBoolean;
    Fanimation                  : THighGeneric;
    FanimationLimit             : THighNumber;
    FboostBlending              : THighString;
    FboostThreshold             : THighNumber;
    FborderColor                : THighString;
    FborderRadius               : THighNumber;
    FborderWidth                : THighNumber;
    FclassName                  : THighString;
    Fcenter                     : THighGeneric;
    Fclip                       : THighBoolean;
    Fcolor                      : THighGeneric;
    FcolorByPoint               : THighBoolean;
    FcolorIndex                 : THighNumber;
    Fcolors                     : THighGeneric;
    FconnectEnds                : THighBoolean;
    FconnectNulls               : THighBoolean;
    Fcrisp                      : THighBoolean;
    FcropThreshold              : THighNumber;
    Fcursor                     : THighGeneric;
    FdataLabels                 : THighDataLabelsOptions;
    FdashStyle                  : THighGeneric;
    Fdepth                      : THighNumber;
    Fdescription                : THighString;
    FdragDrop                   : THighGeneric;
    FedgeColor                  : THighString;
    FedgeWidth                  : THighNumber;
    FenableMouseTracking        : THighBoolean;
    Fevents                     : THighGeneric;
    FexposeElementToA11y        : THighBoolean;
    FfillColor                  : THighGeneric;
    FfillOpacity                : THighNumber;
    FfindNearestPointBy         : THighString;
    FgetExtremesFromAll         : THighBoolean;
    Fid                         : THighString;
    Fgrouping                   : THighBoolean;
    FgroupPadding               : THighNumber;
    FgroupZPadding              : THighNumber;
    FincludeInDataExport        : THighBoolean;
    Findex                      : THighString;
    FinnerSize                  : THighGeneric;
    Fkeys                       : THighStrings;
    Flabel                      : THighSeriesLabel;
    FlegendIndex                : THighNumber;
    Flinecap                    : THighGeneric;
    FlineColor                  : THighString;
    FlineWidth                  : THighNumber;
    FlinkedTo                   : THighStrings;
    Fmarker                     : THighGeneric;
    FmaxPointWidth              : THighNumber;
    FminPointLength             : THighNumber;
    FminSize                    : THighNumber;
    FnegativeColor              : THighGeneric;
    FnegativeFillColor          : THighGeneric;
    Fopacity                    : THighNumber;
    Fpoint                      : THighGeneric;
    FpointDescriptionFormatter  : THighGeneric;
    FpointInterval              : THighNumber;
    FpointIntervalUnit          : THighStrings;
    FpointPadding               : THighNumber;
    FpointPlacement             : THighGeneric;
    FpointRange                 : THighNullableNumber;
    FpointStart                 : THighNumber;
    FpointWidth                 : THighNumber;
    Fselected                   : THighBoolean;
    Fshadow                     : THighGeneric;
    FshowCheckbox               : THighBoolean;
    FshowInLegend               : THighBoolean;
    Fsize                       : THighGeneric;
    FskipKeyboardNavigation     : THighBoolean;
    FslicedOffset               : THighNumber;
    FstartAngle                 : THighNumber;
    FsoftThreshold              : THighBoolean;
    Fstacking                   : THighStacking;
    Fstates                     : THighGeneric;
    Fstep                       : THighString;
    FstickyTracking             : THighBoolean;
    Fthreshold                  : THighNumber;
    Ftooltip                    : THighchartToolTip;
    FtrackByArea                : THighBoolean;
    FturboThreshold             : THighNumber;
    Ftype                       : THighchartsType;
    Fvisible                    : THighBoolean;
    FxAxis                      : THighNumber;
    FyAxis                      : THighNumber;
    FzIndex                     : THighNumber;
    FzoneAxis                   : THighString;
    Fzones                      : THighGeneric;
  protected
    property accessibility              : THighGeneric read  Faccessibility;
    property allowPointSelect           : THighBoolean read  FallowPointSelect;
    property animation                  : THighGeneric read  Fanimation;
    property animationLimit             : THighNumber read  FanimationLimit;
    property boostBlending              : THighString read  FboostBlending;
    property boostThreshold             : THighNumber read  FboostThreshold;
    property borderColor                : THighString read  FborderColor;
    property borderRadius               : THighNumber read  FborderRadius;
    property borderWidth                : THighNumber read  FborderWidth;
    property className                  : THighString read  FclassName;
    Property center                     : THighGeneric read Fcenter;
    property clip                       : THighBoolean read  Fclip;
    property color                      : THighGeneric read  Fcolor;
    property colorByPoint               : THighBoolean read  FcolorByPoint;
    property colorIndex                 : THighNumber read  FcolorIndex;
    property colors                     : THighGeneric read  Fcolors;
    Property connectEnds                : THighBoolean read FconnectEnds;
    Property connectNulls               : THighBoolean read FconnectNulls;
    property crisp                      : THighBoolean read  Fcrisp;
    property cropThreshold              : THighNumber read  FcropThreshold;
    property cursor                     : THighGeneric read  Fcursor;
    property dataLabels                 : THighDataLabelsOptions read  FdataLabels;
    property dashStyle                  : THighGeneric read FdashStyle;
    property depth                      : THighNumber read  Fdepth;
    property description                : THighString read  Fdescription;
    property dragDrop                   : THighGeneric read FdragDrop;
    property edgeColor                  : THighString read  FedgeColor;
    property edgeWidth                  : THighNumber read  FedgeWidth;
    property enableMouseTracking        : THighBoolean read  FenableMouseTracking;
    property events                     : THighGeneric read  Fevents;
    property exposeElementToA11y        : THighBoolean read  FexposeElementToA11y;
    property findNearestPointBy         : THighString read  FfindNearestPointBy;
    Property fillColor                  : THighGeneric read FfillColor;
    Property fillOpacity                : THighNumber read FfillOpacity;
    property getExtremesFromAll         : THighBoolean read  FgetExtremesFromAll;
    property id                         : THighString read Fid;
    property grouping                   : THighBoolean read  Fgrouping;
    property groupPadding               : THighNumber read  FgroupPadding;
    property groupZPadding              : THighNumber read  FgroupZPadding;
    property includeInDataExport        : THighBoolean read  FincludeInDataExport;
    property index                      : THighString read Findex;
    Property innerSize                  : THighGeneric read FinnerSize;
    property keys                       : THighStrings read  Fkeys;
    property labels                     : THighSeriesLabel read  Flabel;
    property legendIndex                : THighNumber read FlegendIndex;
    property linecap                    : THighGeneric read Flinecap;
    Property lineColor                  : THighString read FlineColor;
    property lineWidth                  : THighNumber read FlineWidth;
    property linkedTo                   : THighStrings read  FlinkedTo;
    property marker                     : THighGeneric  read Fmarker;
    property maxPointWidth              : THighNumber read  FmaxPointWidth;
    property minPointLength             : THighNumber read  FminPointLength;
    Property minSize                    : THighNumber read FminSize;
    property negativeColor              : THighGeneric read  FnegativeColor;
    property negativeFillColor          : THighGeneric read  FnegativeFillColor;
    property opacity                    : THighNumber read  Fopacity;
    property point                      : THighGeneric read  Fpoint;
    property pointDescriptionFormatter  : THighGeneric read  FpointDescriptionFormatter;
    property pointInterval              : THighNumber read  FpointInterval;
    property pointIntervalUnit          : THighStrings read  FpointIntervalUnit;
    property pointPadding               : THighNumber read  FpointPadding;
    property pointPlacement             : THighGeneric read  FpointPlacement;
    property pointRange                 : THighNullableNumber read  FpointRange;
    property pointStart                 : THighNumber read  FpointStart;
    property pointWidth                 : THighNumber read  FpointWidth;
    property selected                   : THighBoolean read  Fselected;
    property shadow                     : THighGeneric read  Fshadow;
    property showCheckbox               : THighBoolean read  FshowCheckbox;
    property showInLegend               : THighBoolean read  FshowInLegend;
    Property size                       : THighGeneric read Fsize;
    Property slicedOffset               : THighNumber read FslicedOffset;
    Property startAngle                 : THighNumber read FstartAngle;
    property skipKeyboardNavigation     : THighBoolean read  FskipKeyboardNavigation;
    property softThreshold              : THighBoolean read  FsoftThreshold;
    property stacking                   : THighStacking read  Fstacking;
    Property states                     : THighGeneric read Fstates;
    Property step                       : THighString read Fstep;
    property stickyTracking             : THighBoolean read  FstickyTracking;
    property threshold                  : THighNumber read  Fthreshold;
    property tooltip                    : THighchartToolTip read  Ftooltip;
    property trackByArea                : THighBoolean read FtrackByArea;
    property turboThreshold             : THighNumber read  FturboThreshold;
    property type_                      : THighchartsType read Ftype;
    property visible                    : THighBoolean read  Fvisible;
    Property xAxis                      : THighNumber read FxAxis;
    Property yAxis                      : THighNumber read FyAxis;
    Property zIndex                     : THighNumber read FzIndex;
    property zoneAxis                   : THighString read  FzoneAxis;
    property zones                      : THighGeneric read  Fzones;

    Procedure CreateObjects;    Override;



    Procedure UpdateVariableNames; Override;
  End;
  THighAreaPlotOptions = Class(THighchartsCustomPlotOptions)
  public
    property accessibility;
    property allowPointSelect;
    property animation;
    property animationLimit;
    property boostBlending;
    property boostThreshold;
    property className;
    property clip;
    property color;
    property colorIndex;
    property connectEnds;
    property connectNulls;
    property cropThreshold;
    property cursor;
    property dashStyle;
    property dataLabels;
    property description;
    property dragDrop;
    property enableMouseTracking;
    property events;
    property exposeElementToA11y;
    property fillColor;
    property fillOpacity;
    property findNearestPointBy;
    property getExtremesFromAll;
    property includeInDataExport;
    property keys;
    property labels;
    property linecap;
    property lineColor;
    property lineWidth;
    property linkedTo;
    property marker;
    property negativeColor;
    property negativeFillColor;
    property opacity;
    property point;
    property pointDescriptionFormatter;
    property pointInterval;
    property pointIntervalUnit;
    property pointPlacement;
    property pointStart;
    property selected;
    property shadow;
    property showCheckbox;
    property showInLegend;
    property skipKeyboardNavigation;
    property softThreshold;
    property stacking;
    property states;
    property step;
    property stickyTracking;
    property threshold;
    property tooltip;
    property turboThreshold;
    property visible;
    property zoneAxis;
    property zones;
  End;

  THighBarPlotOptions = Class(THighchartsCustomPlotOptions)
  Public
    property accessibility;
    property allowPointSelect;
    property animation;
    property animationLimit;
    property boostBlending;
    property boostThreshold;
    property borderColor;
    property borderRadius;
    property borderWidth;
    property className;
    property clip;
    property color;
    property colorByPoint;
    property colorIndex;
    property colors;
    property crisp;
    property cropThreshold;
    property cursor;
    property dataLabels;
    property depth;
    property description;
    property edgeColor;
    property edgeWidth;
    property enableMouseTracking;
    property events;
    property exposeElementToA11y;
    property findNearestPointBy;
    property getExtremesFromAll;
    property grouping;
    property groupPadding;
    property groupZPadding;
    property includeInDataExport;
    property keys;
    property labels;
    property linkedTo;
    property maxPointWidth;
    property minPointLength;
    property negativeColor;
    property opacity;
    property point;
    property pointDescriptionFormatter;
    property pointInterval;
    property pointIntervalUnit;
    property pointPadding;
    property pointPlacement;
    property pointRange;
    property pointStart;
    property pointWidth;
    property selected;
    property shadow;
    property showCheckbox;
    property showInLegend;
    property skipKeyboardNavigation;
    property softThreshold;
    property stacking;
    property stickyTracking;
    property threshold;
    property tooltip;
    property turboThreshold;
    property visible;
    property zoneAxis;
    property zones;
  End;

  THighPiePlotOptions = Class(THighchartsCustomPlotOptions)
  Public
    Property accessibility;
    Property allowPointSelect;
    Property animation;
    Property boostBlending;
    Property borderColor;
    Property borderWidth;
    Property center;
    Property className;
    Property clip;
    Property color;
    Property colorIndex;
    Property colors;
    Property cursor;
    Property dataLabels;
    Property depth;
    Property description;
    Property dragDrop;
    Property enableMouseTracking;
    Property events;
    Property exposeElementToA11y;
    Property includeInDataExport;
    Property innerSize;
    Property keys;
    Property linecap;
    Property linkedTo;
    Property minSize;
    Property opacity;
    Property point;
    Property pointDescriptionFormatter;
    Property selected;
    Property shadow;
    Property showCheckbox;
    Property showInLegend;
    Property size;
    Property skipKeyboardNavigation;
    Property slicedOffset;
    Property startAngle;
    Property states;
    Property stickyTracking;
    Property tooltip;
    Property visible;
  End;



  THighSeriesPlotOptions = Class(THighchartsCustomPlotOptions)
  Public
    property accessibility;
    property allowPointSelect;
    property animation;
    property animationLimit;
    property boostBlending;
    property boostThreshold;
    property className;
    property clip;
    property color;
    property colorIndex;
    property connectEnds;
    property connectNulls;
    property cropThreshold;
    property cursor;
    property dashStyle;
    property dataLabels;
    property description;
    property dragDrop;
    property enableMouseTracking;
    property events;
    property exposeElementToA11y;
    property findNearestPointBy;
    property getExtremesFromAll;
    property keys;
    property labels;
    property linecap;
    property lineWidth;
    property linkedTo;
    property marker;
    property negativeColor;
    property opacity;
    property pointDescriptionFormatter;
    property pointInterval;
    property pointIntervalUnit;
    property pointPlacement;
    property pointStart;
    property selected;
    property shadow;
    property showCheckbox;
    property showInLegend;
    property skipKeyboardNavigation;
    property softThreshold;
    property stacking;
    property states;
    property step;
    property stickyTracking;
    property threshold;
    property tooltip;
    property turboThreshold;
    property visible;
    property zoneAxis;
    property zones;

  End;

  THighSeriesSOptions = Class(THighchartsCustomPlotOptions)
  protected
    Procedure CreateObjects; Override;
    Procedure InitializeObjects; Override;
  Public
    property accessibility;
    property allowPointSelect;
    property animation;
    property animationLimit;
    property boostBlending;
    property boostThreshold;
    property className;
    property clip;
    property color;
    property colorIndex;
    property connectEnds;
    property connectNulls;
    property cropThreshold;
    property cursor;
    property dashStyle;
    property dataLabels;
    property description;
    property dragDrop;
    property enableMouseTracking;
    property events;
    property exposeElementToA11y;
    property findNearestPointBy;
    property getExtremesFromAll;
    property id;
    property includeInDataExport;
    property index;
    property keys;
    property labels;
    property legendIndex;
    property linecap;
    property lineWidth;
    property linkedTo;
    property marker;
    property negativeColor;
    property opacity;
    property point;
    property pointDescriptionFormatter;
    property pointInterval;
    property pointIntervalUnit;
    property pointPlacement;
    property pointStart;
    property selected;
    property shadow;
    property showCheckbox;
    property showInLegend;
    property skipKeyboardNavigation;
    property softThreshold;
    property states;
    property step;
    property stickyTracking;
    property threshold;
    property tooltip;
    property trackByArea;
    property turboThreshold;
    property type_;
    property visible;
    property xAxis;
    property yAxis;
    property zIndex;
    property zoneAxis;
    property zones;

  End;





  THighPlotOptions = Class(THighValue)
  strict private
    Farea             : THighAreaPlotOptions;
    Farearange        : THighGeneric;
    Fareaspline       : THighGeneric;
    Fareasplinerange  : THighGeneric;
    Fbar              : THighBarPlotOptions;
    Fbellcurve        : THighGeneric;
    Fboxplot          : THighGeneric;
    Fbubble           : THighGeneric;
    Fbullet           : THighGeneric;
    Fcolumn           : THighGeneric;
    Fcolumnpyramid    : THighGeneric;
    Fcolumnrange      : THighGeneric;
    Fcylinder         : THighGeneric;
    Fdependencywheel  : THighGeneric;
    Ferrorbar         : THighGeneric;
    Ffunnel           : THighGeneric;
    Ffunnel3d         : THighGeneric;
    Fgauge            : THighGeneric;
    Fheatmap          : THighGeneric;
    Fhistogram        : THighGeneric;
    Fitem             : THighGeneric;
    Fline             : THighGeneric;
    Fnetworkgraph     : THighGeneric;
    Forganization     : THighGeneric;
    Fpackedbubble     : THighGeneric;
    Fpareto           : THighGeneric;
    Fpie              : THighPiePlotOptions;
    Fpolygon          : THighGeneric;
    Fpyramid          : THighGeneric;
    Fpyramid3d        : THighGeneric;
    Fsankey           : THighGeneric;
    Fscatter          : THighGeneric;
    Fscatter3d        : THighGeneric;
    Fseries           : THighSeriesPlotOptions;
    Fsolidgauge       : THighGeneric;
    Fspline           : THighGeneric;
    Fstreamgraph      : THighGeneric;
    Fsunburst         : THighGeneric;
    Ftilemap          : THighGeneric;
    Ftimeline         : THighGeneric;
    Ftreemap          : THighGeneric;
    Fvariablepie      : THighGeneric;
    Fvariwide         : THighGeneric;
    Fvector           : THighGeneric;
    Fvenn             : THighGeneric;
    Fwaterfall        : THighGeneric;
    Fwindbarb         : THighGeneric;
    Fwordcloud        : THighGeneric;
    Fxrange           : THighGeneric;


  protected
    Procedure CreateObjects;    Override;
  Public
    property area             : THighAreaPlotOptions read  Farea;
    property arearange        : THighGeneric read  Farearange;
    property areaspline       : THighGeneric read  Fareaspline;
    property areasplinerange  : THighGeneric read  Fareasplinerange;
    property bar              : THighBarPlotOptions read  Fbar;
    property bellcurve        : THighGeneric read  Fbellcurve;
    property boxplot          : THighGeneric read  Fboxplot;
    property bubble           : THighGeneric read  Fbubble;
    property bullet           : THighGeneric read  Fbullet;
    property column           : THighGeneric read  Fcolumn;
    property columnpyramid    : THighGeneric read  Fcolumnpyramid;
    property columnrange      : THighGeneric read  Fcolumnrange;
    property cylinder         : THighGeneric read  Fcylinder;
    property dependencywheel  : THighGeneric read  Fdependencywheel;
    property errorbar         : THighGeneric read  Ferrorbar;
    property funnel           : THighGeneric read  Ffunnel;
    property funnel3d         : THighGeneric read  Ffunnel3d;
    property gauge            : THighGeneric read  Fgauge;
    property heatmap          : THighGeneric read  Fheatmap;
    property histogram        : THighGeneric read  Fhistogram;
    property item             : THighGeneric read  Fitem;
    property line             : THighGeneric read  Fline;
    property networkgraph     : THighGeneric read  Fnetworkgraph;
    property organization     : THighGeneric read  Forganization;
    property packedbubble     : THighGeneric read  Fpackedbubble;
    property pareto           : THighGeneric read  Fpareto;
    property pie              : THighPiePlotOptions read  Fpie;
    property polygon          : THighGeneric read  Fpolygon;
    property pyramid          : THighGeneric read  Fpyramid;
    property pyramid3d        : THighGeneric read  Fpyramid3d;
    property sankey           : THighGeneric read  Fsankey;
    property scatter          : THighGeneric read  Fscatter;
    property scatter3d        : THighGeneric read  Fscatter3d;
    property series           : THighSeriesPlotOptions read  Fseries;
    property solidgauge       : THighGeneric read  Fsolidgauge;
    property spline           : THighGeneric read  Fspline;
    property streamgraph      : THighGeneric read  Fstreamgraph;
    property sunburst         : THighGeneric read  Fsunburst;
    property tilemap          : THighGeneric read  Ftilemap;
    property timeline         : THighGeneric read  Ftimeline;
    property treemap          : THighGeneric read  Ftreemap;
    property variablepie      : THighGeneric read  Fvariablepie;
    property variwide         : THighGeneric read  Fvariwide;
    property vector           : THighGeneric read  Fvector;
    property venn             : THighGeneric read  Fvenn;
    property waterfall        : THighGeneric read  Fwaterfall;
    property windbarb         : THighGeneric read  Fwindbarb;
    property wordcloud        : THighGeneric read  Fwordcloud;
    property xrange           : THighGeneric read  Fxrange;

  End;

  THighResponsiveRulesConditions = Class(THighValue)
  strict private
    Fcallback       : THighGeneric;
    FmaxHeight      : THighNumber;
    FmaxWidth       : THighNumber;
    FminHeight      : THighNumber;
    FminWidth       : THighNumber;

  protected
    Procedure CreateObjects;    Override;
  Public
    Property callback       : THighGeneric read Fcallback;
    Property maxHeight      : THighNumber read FmaxHeight;
    Property maxWidth       : THighNumber read FmaxWidth;
    Property minHeight      : THighNumber read FminHeight;
    Property minWidth       : THighNumber read FminWidth;
  End;

  THighResponsiveRules = Class(THighSetValue)
  strict private
    FchartOptions   : THighGeneric;
    Fcondition      : THighResponsiveRulesConditions;
  protected
    Procedure CreateObjects;    Override;
  Public
    Property chartOptions   : THighGeneric read FchartOptions;
    Property condition      : THighResponsiveRulesConditions read Fcondition;
  End;

  THighResponsiveOptions = Class(THighValue)
  strict private
    Frules  : THighResponsiveRules;
  protected
    Procedure CreateObjects;    Override;
    Procedure DestroyObjects;    Override;
  Public
    property rules  : THighResponsiveRules read Frules;


  End;

  THighTimeOptions = Class(THighValue)
  strict private
    FDate                 : THighGeneric;
    FgetTimezoneOffset    : THighGeneric;
    Ftimezone             : THighString;
    FtimezoneOffset       : THighNumber;
    FuseUTC               : THighBoolean;
    Frules: THighResponsiveRules;
  protected
    Procedure CreateObjects;    Override;
  Public
    property Date                 : THighGeneric read FDate;
    property getTimezoneOffset    : THighGeneric read FgetTimezoneOffset;
    property timezone             : THighString read Ftimezone;
    property timezoneOffset       : THighNumber read FtimezoneOffset;
    property useUTC               : THighBoolean read FuseUTC;



  End;
  TSerieCoordenate = Class(TPersistent)
  private
    F : TFormatSettings;

    FValue : Extended;
  public
    Constructor Create; Reintroduce;
    property Value : Extended read FValue write FValue;

    Function toStr : String;

  End;

  TSerieValue = Class(TCollectionItem)
  strict private
    FX : TSerieCoordenate;
    FY : TSerieCoordenate;

    Fpercentage   : THighFloat;
    Ftotal        : THighFloat;
    FNull : Boolean;


    procedure UpdateVariableNames;
  public
    constructor Create(Collection: TCollection); Override;

    property Null : Boolean read FNull write FNull;
    property X : TSerieCoordenate read FX write FX;
    property Y : TSerieCoordenate read FY write FY;
    property percentage  : THighFloat read Fpercentage;
    property total  : THighFloat read Ftotal;



  END;

  TSerieData = class(TCollection)

  private
    procedure setValue(Index: Integer ; Value : TSerieValue);
    Function  getValue(Index: Integer) : TSerieValue;
  public
    function  Add: TSerieValue; Overload;
    function  Add(xValue: extended ; yValue : Extended): TSerieValue;  Overload;
    Procedure  AddNull;

    Function  ItemByX(v :  Extended) : TSerieValue;
    property Items[Index: Integer]: TSerieValue read getValue write setValue; default;

  end;

  TSerie = class(TCollectionItem)
  private
    FSerieName      : string;
    FFieldNameForX  : String;
    FFieldNameForY  : String;
    FData : TSerieData;

    FOptions : THighSeriesSOptions;
  protected

  public
    constructor Create(Collection: TCollection); Override;

    property SerieName      : string read FSerieName      write FSerieName;
    property FieldNameForX  : String read FFieldNameForX  write FFieldNameForX;
    property FieldNameForY  : String read FFieldNameForY  write FFieldNameForY;

    property Data : TSerieData read FData;

    Property Options : THighSeriesSOptions read FOptions;
  end;

  THighchartSeries = class;
  TSerieNotifyEvent = procedure(Serie: TSerie) of object;
  TSerieItemNotifyEvent = procedure(List : THighchartSeries ; Serie: TSerie ; Item : TSerieValue) of object;
  THighchartSeries = class(TCollection)
  private
    FChartMode : THighChartModeValue;
    FAfterSerieAdded : TSerieNotifyEvent;
    FFieldNameForSerie  : string;
    FFieldNameForX      : String;
    FFieldNameForY      : String;
    procedure setSerie(Index: Integer ; Value : TSerie);
    Function  getSerie(Index: Integer) : TSerie;

  protected

  public

    function  Add: TSerie;
    Procedure ClearData;

    Procedure GenerateHighchartSeries(SL : TStrings);
    Function ItemByName(sName : string) : TSerie;

    property ChartMode : THighChartModeValue read FChartMode write FChartMode;
    property FieldNameForSerie  : string read FFieldNameForSerie  write FFieldNameForSerie;
    property FieldNameForX      : String read FFieldNameForX      write FFieldNameForX;
    property FieldNameForY      : String read FFieldNameForY      write FFieldNameForY;
    property Items[Index: Integer]: TSerie read getSerie write setSerie; default;
    Property AfterSerieAdded : TSerieNotifyEvent read FAfterSerieAdded write FAfterSerieAdded;

    Procedure AutoCompleteWithZero(CategoriesNumber : integer);



  end;

  THighcartSeriesOptions = Class(THighValue)
  strict private
    FAfterSeriePrepared : TSerieNotifyEvent;
    FAfterItemDataAdded : TSerieItemNotifyEvent;
    FList : THighchartSeries;
    FDatasource : TDatasource;
    FChartMode : THighChartModeValue;
    FAfterLoadSeriesFromDataset : TNotifyEvent;
    FCategories : TStringlist;

    Procedure setChartMode(V : THighChartModeValue);
  protected
    Procedure CreateObjects; Override;
    Procedure DestroyObjects; Override;
    Procedure InitializeObjects; Override;

    Procedure LoadSeriesFromDataset;
    Procedure AddValue(SL : TStrings); Override;


  Public
    property ChartMode : THighChartModeValue read FChartMode write setChartMode;
    property Categories : TStringlist read FCategories write FCategories;
    Property Datasource : TDatasource Read FDatasource;
    Property List : THighchartSeries  Read FList;
    Property AfterLoadSeriesFromDataset : TNotifyEvent read FAfterLoadSeriesFromDataset write FAfterLoadSeriesFromDataset;
    Property AfterSeriePrepared : TSerieNotifyEvent read FAfterSeriePrepared write FAfterSeriePrepared;
    Property AfterItemDataAdded : TSerieItemNotifyEvent read FAfterItemDataAdded write FAfterItemDataAdded;

  End;



  THighChartOptions = Class(THighValue)
  Procedure onChartModeChange(Sender : TObject);
  Procedure onValuesDecimalChange(Sender : TObject);
  strict private
    FChartMode        : THighChartMode;
    Faccessibility    : THighGeneric;
    Fannotations      : THighGeneric;
    Fboost            : THighGeneric;
    Fchart            : THighChart;
    FcolorAxis        : THighGeneric;
    Fcolors           : THighStrings;
    Fcredits          : THighCredits;
    Fdata             : THighGeneric;
    Fdefs             : THighGeneric;
    Fdrilldown        : THighGeneric;
    Fexporting        : THighGeneric;
    Flabels           : THighGeneric;
    Floading          : THighLoading;
    Fnavigation       : THighGeneric;
    FnoData           : THighGeneric;
    Fpane             : THighGeneric;
    FplotOptions      : THighPlotOptions;
    Fresponsive       : THighResponsiveOptions;
    Fseries           : THighcartSeriesOptions;
    Fsubtitle         : THighTittle;
    FTime             : THighTimeOptions;
    Ftitle            : THighTittle;
    Ftooltip          : THighchartToolTip;
    FxAxis            : TArrayXAxisOption;
    FyAxis            : TArrayYAxisOption;
    FzAxis            : TXAxisOption;
    Flegend           : THighLegend;

    Function  getxAxis : TXAxisOption; Overload;
    Function  getyAxis : TYAxisOption; Overload;

    Function  getDataset :Tdataset;
    Procedure  setDataset(V :Tdataset);
  private

  PROTECTED
    Procedure CreateObjects; Override;
    Procedure DestroyObjects; Override;
    Procedure InitializeObjects; Override;

  public
    Function  getxAxis(Index : integer) : TXAxisOption; Overload;
    Function  getyAxis(Index : integer) : TYAxisOption; Overload;

    Function NewxAxis : TXAxisOption;
    Function NewyAxis : TYAxisOption;
  Public
    Property ChartMode        : THighChartMode read FChartMode;
    Property Dataset : Tdataset read getDataset write setDataset;


    Property accessibility    : THighGeneric read Faccessibility;
    Property annotations      : THighGeneric read Fannotations;
    Property boost            : THighGeneric read Fboost;
    Property chart            : THighChart read Fchart;
    Property colorAxis        : THighGeneric read FcolorAxis;
    Property colors           : THighStrings read Fcolors;
    Property credits          : THighCredits read Fcredits;
    Property data             : THighGeneric read Fdata;
    Property defs             : THighGeneric read Fdefs;
    Property drilldown        : THighGeneric read Fdrilldown;
    Property exporting        : THighGeneric read Fexporting;
    Property labels           : THighGeneric read Flabels;
    Property loading          : THighLoading read Floading;
    Property navigation       : THighGeneric read Fnavigation;
    Property noData           : THighGeneric read FnoData;
    Property pane             : THighGeneric read Fpane;
    Property plotOptions      : THighPlotOptions read FplotOptions;
    Property responsive       : THighResponsiveOptions read Fresponsive;
    Property series           : THighcartSeriesOptions read Fseries;
    Property subtitle         : THighTittle read Fsubtitle;
    Property Time             : THighTimeOptions read FTime;
    Property title            : THighTittle read Ftitle;
    Property tooltip          : THighchartToolTip read Ftooltip;
    Property xAxis            : TXAxisOption read getxAxis;
    Property yAxis            : TYAxisOption read getyAxis;
    Property zAxis            : TXAxisOption read FzAxis;
    Property legend           : THighLegend read Flegend;


    Procedure Clear; Override;
  End;

  TDirection = (ASC,DESC);
  TEchoHightChart = class(TUniCustomURLFrame)
  Procedure ONCustomCSSChange(Sender : TObject);
  strict private
    FHTML : TStringList;
    FCustomCSS : TStringList;
    FJS   : TStringList;
    FModules : TStringList;
    sHTMLFilename  : string;
    FHighChartOptions :  THighChartOptions;
    FHighChartPath : string;

    FJavasScriptMode : TEchoHightScriptMode;
    FHTMLScriptMode : TEchoHightScriptMode;

    Function GenerateTempFileName : Boolean;



    Function getHighChartPath : string;
    procedure setHighChartPath(V : string);

    Procedure AddJsfiles;

  protected
    property BodyRTL;
    property Cursor;
    property CustomHint;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;

  public
    Property CustomCSS : TStringList read FCustomCSS;
    Property HTML : TStringList read FHTML;
    Property Javascript : TStringList read FJS;
    Property HighChartOptions : THighChartOptions Read FHighChartOptions;
    Property Modules : TStringlist read FModules write FModules;

    Function GenerateHTML : boolean;
    Function GenerateJavascript : boolean;
    Procedure AddPortugueseTraduction;
    Function Load : boolean;
    Procedure Clear;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    Procedure AddYearMonthCategories(iYear, iMonth , iCount : integer; Direction : TDirection = DESC);
  published
   { Public declarations }
    property LayoutConfig;
    property ScreenMask;
    property ClientEvents;
    property Align;
    property Anchors;
    property TabOrder;
    property TabStop;


    Property HighChartPath : string read FHighChartPath write setHighChartPath;
    Property HTMLScriptMode : TEchoHightScriptMode read FHTMLScriptMode write  FHTMLScriptMode;
    Property JavasScriptMode : TEchoHightScriptMode read FJavasScriptMode write  FJavasScriptMode;

    property OnFrameLoaded;
    property OnAjaxEvent;


  end;

Function  getSettedValue( value : string) : String;
Function  getMonthShortDescription( index : integer) : String;
Procedure AddLastComma(SL : TStrings);
Function GetAppDirectory : String;
procedure Register;


implementation

USES
  uniguiAbstractClasses,
  uniGUITypes,
  uniguiapplication,
  uniGUIServer;


procedure Register;
begin
  RegisterComponents('Echo - UniGui Chart', [TEchoHightChart]);
end;


Function  getSettedValue( value : string) : String;
VAR
  i : integer;
BEGIN

  for I := 1 to length(value) do
  BEGIN
    if value[i] <> LowerCase(value[i]) then
    BEGIN
      Break;
    END;

  END;


  Result := LowerCase(Copy(value,i,length(value)));
END;




{ TEchoHightChart }

procedure TEchoHightChart.AddJsfiles;
VAR
  i : integer;
begin

  for I := 0 to FModules.Count-1 do
  BEGIN
    FHTML.Add('    <script src="' + getHighChartPath + 'code/modules/'+ FModules.Strings[i] + '"></script>');
  END;
end;

procedure TEchoHightChart.AddPortugueseTraduction;
begin
  With FJS DO
  BEGIN
    Add('	lang:');
    Add('	{');
    Add('		decimalPoint: '','',');
    Add('		thousandsSep: ''.'',');
    Add('		downloadCSV: ''Exportar planilha'',');
    Add('		downloadJPEG: ''Baixar imagem (JPEG)'',');
    Add('		downloadPDF: ''Baixar PDF'',');
    Add('		downloadPNG: ''Baixar imagem (PNG)'',');
    Add('		loading: ''Carregando....'',');
    Add('		months: ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"],');
    Add('		printChart: ''Imprimir'',');
    Add('		resetZoom: ''Redefinir Zoom'',');
    Add('		shortMonths: ["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"],');
    Add('		viewFullscreen: ''Ver em tela cheia'',');
    Add('		weekdays: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]');
    Add('	}');
  END;
end;

procedure TEchoHightChart.AddYearMonthCategories(iYear, iMonth, iCount: integer;
  Direction: TDirection);
VAR
  i : integer;
  m,y : integer;
begin
  HighChartOptions.xAxis.categories.Value.Clear;
  y := iYear;
  m := iMonth;
  if Direction = DESC then
  BEGIN
    for i := 0 to iCount-1 do
    BEGIN
      HighChartOptions.xAxis.categories.Value.Add(getMonthShortDescription(m) + ' ' + IntToStr(y));
      DEC(m);
      if M < 1 then
      BEGIN
        m := 12;
        DEC(y);
      END;
    END;
  END
  Else
  BEGIN
    for i := 0 to iCount-1 do
    BEGIN
      HighChartOptions.xAxis.categories.Value.Add(getMonthShortDescription(m) + ' ' + IntToStr(y));
      INC(m);

      if M > 12 then
      BEGIN
        m := 1;
        INC(y);
      END;
    END;
  END;





end;

procedure TEchoHightChart.Clear;
begin
  self.URL := '';
  Self.HighChartOptions.Clear;
  Self.HighChartOptions.series.List.Clear;
end;

constructor TEchoHightChart.Create(AOwner: TComponent);
begin
  inherited;
  FHTML := TStringList.Create;
  FJS   := TStringList.Create;

  FModules := TStringList.Create;

  with FModules DO
  BEGIN
    Add('series-label.js');
    Add('exporting.js');
    Add('offline-exporting.js');
    Add('export-data.js');
  END;

  FModules.OnChange := ONCustomCSSChange;

  FHighChartPath := '/Highcharts/';

  FCustomCSS := TStringList.Create;
  FCustomCSS.OnChange := ONCustomCSSChange;
  FHighChartOptions :=  THighChartOptions.Create(nil);
  JavasScriptMode := AutomaticMode;
  GenerateHTML;
end;

destructor TEchoHightChart.Destroy;
begin
  FHTML.Free;
  FJS.Free;
  FModules.Free;
  FCustomCSS.Free;
  FHighChartOptions.Free;
  inherited;
end;

function TEchoHightChart.GenerateHTML: boolean;
begin
  With FHTML DO
  BEGIN
    Clear;
    Add('<!DOCTYPE HTML>');
    Add('<html>');
    Add('	<head>');
    Add('		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
    Add('		<meta name="viewport" content="width=device-width, initial-scale=1">');
    Add('		<title>Highcharts Example</title>');
    Add('');
    Add('		<style>');
    Add('      html, body {');
    Add('        height:94%;');
    Add('     }');
    Add('     #box {');
    Add('        height:100%;');
    Add('        background: transparent;');
    Add('     }');
    Add('     #container {');
    Add('       position:relative;');
    Add('       height:100%;');
    Add('     }');
    Add(CustomCSS.Text);
    Add('		</style>');
    Add('	</head>');
    Add('	<body>');
    Add('    <script src="' + getHighChartPath + 'code/highcharts.js"></script>');
    Add('    <script src="' + getHighChartPath + 'code/highcharts-more.js"></script>');
    Add('    <script src="' + getHighChartPath + 'code/highcharts-3d.js"></script>');
    Add('    <script src="' + getHighChartPath + 'code/jquery.min.js"></script>');
    AddJsfiles;
    Add('<div id="box">');
    Add('<div id="container"></div>');
    Add('</div>');
    Add('    <script src="#8#script#8#"></script>');
    Add('	</body>');
    Add('</html>');

  END;

  Result := True;
end;

function TEchoHightChart.GenerateJavascript: boolean;
begin
  With FJS DO
  BEGIN
    Clear;
    Add('Highcharts.setOptions(');
    Add('{');
    AddPortugueseTraduction;
    Add('});');
    Add('var ' + Self.Name + ';');
    Add('$(function() {');
    Add('var newh = $("#box").height();');
    Add('');
    Add('$( window ).resize(function() {');
    Add('');
    Add('newh = $("#box").height();');
    Add(Self.Name +'.redraw();');
    Add(Self.Name +'.reflow();');
    Add('});');
    Add('});');
    Add(Self.Name + ' = new Highcharts.Chart(');
    HighChartOptions.AddValue(FJS);
    Add(');');
  END;

  Result := True;
end;

function TEchoHightChart.GenerateTempFileName: Boolean;
VAR
  sName,sJSfilename,sJSURL: string;
begin
  inherited;
  sHTMLFilename := UniServerInstance.NewCacheFileUrl(False,'.HTML','chart',Self.Name,sName,True);
  sJSfilename := StringReplace(sHTMLFilename,'.html','.js',[rfIgnoreCase,rfReplaceAll]);
  sJSURL := StringReplace(sName,'.html','.js',[rfIgnoreCase,rfReplaceAll]);
  FHTML.text := StringReplace(FHTML.text,'#8#script#8#',sJSURL,[rfReplaceAll]);
  FHTML.SaveToFile(sHTMLFilename,TEncoding.UTF8);
  FJS.SaveToFile(sJSfilename,TEncoding.UTF8);
  Self.URL := sName;

  Result := True;
end;



function TEchoHightChart.getHighChartPath: string;
begin
  Result := FHighChartPath;
end;

function TEchoHightChart.Load: boolean;
begin
  if (JavasScriptMode = AutomaticMode) or (FJS.Count = 0) then
  BEGIN
    if  GenerateJavascript then
    BEGIN
      if GenerateTempFileName then
      BEGIN
        Result := True;
      END;
    END;
  END
  else
  if FJS.Count > 0 then
  BEGIN
    if GenerateTempFileName then
    BEGIN
      Result := True;
    END;
  END;
end;

procedure TEchoHightChart.ONCustomCSSChange(Sender: TObject);
begin
  GenerateHTML;
end;

procedure TEchoHightChart.setHighChartPath(V: string);
begin
  FHighChartPath := V;
  GenerateHTML;
end;

{ THighChartOptions }





procedure THighChartOptions.Clear;
begin
  inherited;
  //
end;

procedure THighChartOptions.CreateObjects;
begin
  Inherited;
  FChartMode        := THighChartMode.create;
  Faccessibility    := THighGeneric.create(Self);
  Fannotations      := THighGeneric.create(Self);
  Fboost            := THighGeneric.create(Self);
  Fchart            := THighChart.create(Self);
  FcolorAxis        := THighGeneric.create(Self);
  Fcolors           := THighStrings.create(Self);
  Fcredits          := THighCredits.create(Self);
  Fdata             := THighGeneric.create(Self);
  Fdefs             := THighGeneric.create(Self);
  Fdrilldown        := THighGeneric.create(Self);
  Fexporting        := THighGeneric.create(Self);
  Flabels           := THighGeneric.create(Self);
  Floading          := THighLoading.create(Self);
  Fnavigation       := THighGeneric.create(Self);
  FnoData           := THighGeneric.create(Self);
  Fpane             := THighGeneric.create(Self);
  FplotOptions      := THighPlotOptions.create(Self);
  Fresponsive       := THighResponsiveOptions.create(Self);
  Fseries           := THighcartSeriesOptions.create(Self);
  Fsubtitle         := THighTittle.create(Self);
  FTime             := THighTimeOptions.create(Self);
  Ftitle            := THighTittle.create(Self);
  Ftooltip          := THighchartToolTip.create(Self);
  FxAxis            := TArrayXAxisOption.create(Self);
  FyAxis            := TArrayYAxisOption.create(Self);
  FzAxis            := TXAxisOption.create(Self);
  Flegend           := THighLegend.create(Self);
end;



procedure THighChartOptions.DestroyObjects;
begin
  inherited;
end;

function THighChartOptions.getDataset: Tdataset;
begin
  Result := Fseries.Datasource.DataSet;
end;




function THighChartOptions.getxAxis(Index: integer): TXAxisOption;
begin
  Result := FxAxis.Axis.Items[Index];
end;

function THighChartOptions.getxAxis: TXAxisOption;
begin
  Result := getxAxis(0);
end;

function THighChartOptions.getyAxis(Index: integer): TYAxisOption;
begin
  Result := FyAxis.Axis.Items[Index];
end;

function THighChartOptions.getyAxis: TYAxisOption;
begin
  Result := getyAxis(0);
end;

procedure THighChartOptions.InitializeObjects;
VAR
  i :  integer;
begin
  inherited;
  series.Categories := xAxis.categories.Value;

  FChartMode.OnChange := onChartModeChange;
  FChartMode.Value := mNormal;

  Chart.style.Value := '{"fontFamily": "\"Helvetica\", \"Helvetica Neue\", Arial, sans-serif","fontSize":"12px"}';

  for I := 0 to FYAxis.Axis.Count -1 do
  BEGIN
    FYAxis.Axis[i].labels.formatter.Value :=
     'function(){ var s ="";' +
     'if(this.value >= 1000000000000){' +
    's = (this.value / 1000000000000) + '' Tri'';' +
    '}' +
    'if(this.value >= 1000000000){' +
    's = (this.value / 1000000000) + '' Bi'';' +
    '}' +
    'else if(this.value >= 1000000) {' +
    's = (this.value / 1000000) + '' Mi'';' +
    '}' +
    'else if(this.value >= 1000) {' +
    's = (this.value / 1000) + '' mil'';' +
    '}' +
    'else {' +
    's = this.value;' +
    '};' +

    'var str = s.toString();' +
    'str = str.replace(/\./g, '','');' +

    ' return str;}';
  END;


  Fexporting.Value :=
  '{' +
  'buttons: {' +
  'contextButton: {' +
  'menuItems: [' +
  '''viewFullscreen'',' +
  '''printChart'',' +
  '''separator'',' +
  '''downloadPNG'',' +
  '''downloadJPEG'',' +
  '''downloadPDF'',' +
  '''separator'',' +
  '''downloadCSV''' +
  ']' +
  '}' +
  '}' +
  '}';

  Ftooltip.valueDecimals.Onchange := onValuesDecimalChange;
end;

function THighChartOptions.NewXAxis: TXAxisOption;
begin
  Result := TXAxisOption.Create(Self);
  FxAxis.Axis.Add(Result);
end;

function THighChartOptions.NewyAxis: TYAxisOption;
begin
  Result := TYAxisOption.Create(Self);
  FyAxis.Axis.Add(Result);
end;

procedure THighChartOptions.onChartModeChange(Sender: TObject);
begin
  if Assigned(Fseries) then
  BEGIN
    Fseries.ChartMode := ChartMode.Value;
  END;

  case ChartMode.Value of
    mNormal:
    BEGIN
    END;
    mMonthly:
    BEGIN
      plotOptions.series.labels.connectorAllowed.Value := False;
      with xAxis.categories.Value DO
      BEGIN
        Clear;
        Add('Jan');Add('Fev');Add('Mar');Add('Abr');Add('Mai');Add('Jun');
        Add('Jul');Add('Ago');Add('Set');Add('Out');Add('Nov');Add('Dez');
      END;
    END;
  end;
end;

procedure THighChartOptions.onValuesDecimalChange(Sender: TObject);
begin
  FplotOptions.series.dataLabels.formatter.Value := 'function () {return Highcharts.numberFormat(this.y,'+IntToStr(Ftooltip.valueDecimals.Value)+');}';
end;

procedure THighChartOptions.setDataset(V: Tdataset);
begin
  Fseries.Datasource.DataSet := V;
end;

{ THighTittle }


procedure THighTittle.CreateObjects;
begin
  Falign          := THighChartAling.Create(Self);
  Ffloating       := THighBoolean.Create(Self);
  Fmargin         := THighNumber.Create(Self);
  Fstyle          := THighGeneric.Create(Self);
  Ftext           := THighString.Create(Self);
  FuseHTML        := THighBoolean.Create(Self);
  FVerticalAlign  := THighChartVerticalAling.Create(Self);
  FwidthAdjust    := THighNumber.Create(Self);
  FX              := THighNumber.Create(Self);
  FY              := THighNumber.Create(Self);
end;






procedure THighTittle.InitializeObjects;
begin
  inherited;
  //align.Value := alCenter;
end;

{ THighchartToolTip }





procedure THighchartToolTip.CreateObjects;
begin
  Fanimation            := THighBoolean.Create(Self);
  FbackgroundColor      := THighGeneric.Create(Self);
  FborderColor          := THighString.Create(Self);
  FborderRadius         := THighNumber.Create(Self);
  FborderWidth          := THighNumber.Create(Self);
  FdateTimeLabelFormats  := THighBoolean.Create(Self);
  Fenabled              := THighBoolean.Create(Self);
  FfollowPointer        := THighBoolean.Create(Self);
  FfollowTouchMove      := THighBoolean.Create(Self);
  FfooterFormat         := THighString.Create(Self);
  Fformatter            := THighGeneric.Create(Self);
  FheaderFormat         := THighString.Create(Self);
  FheaderShape          := THighGeneric.Create(Self);
  FhideDelay            := THighNumber.Create(Self);
  FnullFormat           := THighString.Create(Self);
  FnullFormatter        := THighGeneric.Create(Self);
  Foutside              := THighBoolean.Create(Self);
  Fpadding              := THighNumber.Create(Self);
  FpointFormat          := THighString.Create(Self);
  FpointFormatter       := THighGeneric.Create(Self);
  Fpositioner           := THighGeneric.Create(Self);
  Fshadow               := THighBoolean.Create(Self);
  Fshape                := THighGeneric.Create(Self);
  Fshared               := THighBoolean.Create(Self);
  Fsnap                 := THighNumber.Create(Self);
  Fsplit                := THighBoolean.Create(Self);
  Fstyle                := THighGeneric.Create(Self);
  FuseHTML              := THighBoolean.Create(Self);
  FvalueDecimals        := THighNumber.Create(Self);
  FvaluePrefix          := THighString.Create(Self);
  FvalueSuffix          := THighString.Create(Self);
  FxDateFormat          := THighString.Create(Self);
end;



procedure THighchartToolTip.InitializeObjects;
begin
  inherited;
  //enabled.Value := true;
end;

{ THighValue }

procedure AddLastComma(SL: TStrings);
begin
  if SL[SL.Count-1] = '' then
  BEGIN
    SL.Text := TRIM(SL.Text);
  END;

  if
  (SL[SL.Count-1][length(SL[SL.Count-1])] <> ',') and
  (SL[SL.Count-1][length(SL[SL.Count-1])] <> '{') and
  (SL[SL.Count-1][length(SL[SL.Count-1])] <> '(') and
  (SL[SL.Count-1][length(SL[SL.Count-1])] <> '[')
  then
  BEGIN
    SL[SL.Count-1] := SL[SL.Count-1] + ',';
  END;
end;

procedure THighValue.AddValue(SL: TStrings);
VAR
  i : integer;
  s : String;
begin
  if Generate then
  BEGIN
    s := getValue;

    if (SL.Count > 0) and
    (
      (s <> '')
      or
      (ChildList.Count > 0)
    )
    then
    BEGIN

      AddLastComma(SL);

    END;


    if s <> '' then
    BEGIN
      SL.Add(getTabs + s);
    END;


    if ChildList.Count > 0 then
    BEGIN
      if Self.VariableName <> '' then
      BEGIN
        Sl.Add(getTabs + Self.VariableName + ':');
      END;


      Sl.Add(getTabs + sPrefixeObject + '{');
      for i := 0 to ChildList.Count -1 do
      BEGIN
        IF ChildList.Items[i].Generate THEN
        BEGIN
          ChildList.Items[i].AddValue(SL);
        END;

      END;

      Sl.Add(getTabs +  '}' + sPosfixeObject);
    END;
  END;
end;

procedure THighValue.Clear;
begin
  FGenerate := False;
end;

constructor THighValue.Create(Owner : THighValue);
begin
  FOwner := Owner;
  if Assigned(FOwner) then
  BEGIN
    Self.CountTab := FOwner.CountTab + 1;
  END
  else
  BEGIN
    Self.CountTab := 0;
  END;

  inherited create;
  Generate := False;
  ChildList := TObjectList<THighValue>.Create(False);
  CreateObjects;
  InitializeObjects;
  UpdateVariableNames;
end;

procedure THighValue.CreateObjects;
begin
  sPrefixeObject := '';
  sPosfixeObject := '';
end;

procedure THighValue.FreeChilds;
VAR
  Contexto  : TRttiContext;
  Classe    : TRttiType;
  Field    : TRttiField;
  obj   : THighValue;
  mode : THighChartMode;
  o : Tobject;
  s : string;
begin
  FOwner := nil;
  Classe := Contexto.GetType(Self.ClassType);
  IF Self.InheritsFrom(THighchartsCustomPlotOptions) THEN
  BEGIN
     Classe := Contexto.GetType(THighchartsCustomPlotOptions);
  END
  else
  IF Self.InheritsFrom(THighCustomLabel) THEN
  BEGIN
     Classe := Contexto.GetType(THighCustomLabel);
  END
  else
  IF Self.InheritsFrom(TAxisOption) THEN
  BEGIN
     Classe := Contexto.GetType(TAxisOption);
  END
  else
  BEGIN
    Classe := Contexto.GetType(Self.ClassType);
  END;



  for Field in Classe.GetDeclaredFields do
  BEGIN
    BEGIN


      s := Field.FieldType.Name;

      if s = 'THighAreaPlotOptions' then
      BEGIN
        s := s;
      END;

      if (Assigned(Field.FieldType.BaseType))  then
      BEGIN
        o := Field.GetValue(Self).AsObject;
        if Assigned(o) and (o.InheritsFrom(THighValue) or o.InheritsFrom(THighChartMode)) then
        BEGIN
          o.Free;
        END;

      END;




//      if (Assigned(Field.FieldType.BaseType)) and (Field.FieldType.BaseType.Name = 'THighValue')  then
//      BEGIN
//        obj := THighValue(Field.GetValue(Self).AsObject);
//        if Assigned(obj) then
//        BEGIN
//          obj.Free;
//        END;
//      END
//      else
//      if (Assigned(Field.FieldType.BaseType)) and (Field.FieldType.Name = 'THighChartMode')  then
//      BEGIN
//        mode := THighChartMode(Field.GetValue(Self).AsObject);
//        if Assigned(mode) then
//        BEGIN
//          mode.Free;
//        END;
//      END;
    END;
  END;
end;


function THighValue.getGenerate: Boolean;
begin
  Result := FGenerate;
end;

function THighValue.getTabs: string;
begin
  Result := StringOfChar(' ',CountTab * 2);
end;

function THighValue.getValue: String;
begin
  Result := '';
end;



procedure THighValue.InitializeObjects;
begin

end;

procedure THighValue.setGenerate(v: Boolean);
begin
  FGenerate := v;
  if v and Assigned(FOwner) then
  BEGIN
    FOwner.Generate := true;
  END;
end;

destructor THighValue.Destroy;
begin
  DestroyObjects;
  inherited;
end;

procedure THighValue.DestroyObjects;
begin
  FreeChilds;
  ChildList.Free;
end;

procedure THighValue.UpdateVariableNames;
VAR
  Contexto  : TRttiContext;
  Classe    : TRttiType;
  Field    : TRttiField;
  obj   : TObject;
begin
  Classe := Contexto.GetType(Self.ClassType);
  for Field in Classe.GetDeclaredFields do
  BEGIN
    IF (Field.Visibility in [TMemberVisibility.mvPrivate,TMemberVisibility.mvProtected]) THEN
    BEGIN
      if (Assigned(Field.FieldType.BaseType)) then
      BEGIN
        obj := Field.GetValue(Self).AsObject;
        if Assigned(obj) then

        BEGIN

          if (obj.InheritsFrom(THighValue))  then
          BEGIN
            Self.ChildList.Add(THighValue(obj));
            THighValue(obj).VariableName := copy(Field.Name,2,length(Field.Name)-1);
          END;
        END;
      END;


    END;
  END;
end;

{ THighBoolean }



function THighBoolean.getValue: String;
begin
  Result := VariableName + ': ' + LowerCase(TRttiEnumerationType.GetName(FValue));
end;

procedure THighBoolean.setValue(V: Boolean);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighNumber }

function THighNumber.getValue: String;
begin
  Result := VariableName + ': ' + IntToStr(Value);
end;

procedure THighNumber.setValue(V: integer);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighString }

function THighString.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(Value);
end;

procedure THighString.setValue(V: string);
begin
  FValue := V;
  Generate := true;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighChartAling }

function THighChartAling.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighChartAling.setValue(V: THighChartAlingValue);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighChartVerticalAling }

function THighChartVerticalAling.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighChartVerticalAling.setValue(V: THighChartVerticalAlingValue);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ TAxisOption }

procedure TAxisOption.CreateObjects;
begin
  inherited;
  Faccessibility        := TAxisAccessibility.Create(Self);
  FalignTicks           := THighBoolean.Create(Self);
  FallowDecimals        := THighBoolean.Create(Self);
  FalternateGridColor   := THighBoolean.Create(Self);
  Fangle                := THighNumber.Create(Self);
  Fbreaks               := THighGeneric.Create(Self);
  Fcategories           := THighStrings.Create(Self);
  Fceiling              := THighNumber.Create(Self);
  FclassName            := THighString.Create(Self);
  Fcrosshair            := TAxisCrossHair.Create(Self);
  FdateTimeLabelFormats := THighGeneric.Create(Self);
  FendOnTick            := THighBoolean.Create(Self);
  Fevents               := THighGeneric.Create(Self);
  Ffloor                := THighNumber.Create(Self);
  FgridLineColor        := THighString.Create(Self);
  FgridLineDashStyle    := THighGeneric.Create(Self);
  FgridLineInterpolation:= THighString.Create(Self);
  FgridLineWidth        := THighNumber.Create(Self);
  FgridZIndex           := THighNumber.Create(Self);
  Fid                   := THighNumber.Create(Self);
  Flabels               := THighAxisLabel.Create(Self);
  FlineColor            := THighString.Create(Self);
  FlineWidth            := THighNumber.Create(Self);
  FlinkedTo             := THighNumber.Create(Self);
  Fmargin               := THighNumber.Create(Self);
  Fmax                  := THighFloat.Create(Self);
  FmaxColor             :=THighString.Create(Self);
  FmaxPadding           := THighNumber.Create(Self);
  Fmin                  := THighNullableNumber.Create(Self);
  FminColor             := THighString.Create(Self);
  FminorGridLineColor   := THighString.Create(Self);
  FminorGridLineDashStyle := THighGeneric.Create(Self);
  FminorGridLineWidth   := THighNumber.Create(Self);
  FminorTickColor       := THighString.Create(Self);
  FminorTickInterval    := THighGeneric.Create(Self);
  FminorTickLength      := THighNumber.Create(Self);
  FminorTickPosition    := THighChartPosition.Create(Self);
  FminorTicks           := THighBoolean.Create(Self);
  FminorTickWidth       := THighNumber.Create(Self);
  FminPadding           := THighNumber.Create(Self);
  FminRange             := THighNumber.Create(Self);
  FminTickInterval      := THighNumber.Create(Self);
  Foffset               := THighNumber.Create(Self);
  Fopposite             := THighBoolean.Create(Self);
  Fpane                 := THighNumber.Create(Self);
  FplotBands            := TAxisPlotBands.Create(Self);
  FplotLines            := TAxisPlotLines.Create(Self);
  Freversed             := THighBoolean.Create(Self);
  FreversedStacks       := THighBoolean.Create(Self);
  FshowEmpty            := THighBoolean.Create(Self);
  FshowFirstLabel       := THighBoolean.Create(Self);
  FshowLastLabel        := THighBoolean.Create(Self);
  FsoftMax              := THighNumber.Create(Self);
  FsoftMin              := THighNumber.Create(Self);
  FstackLabels          := THighGeneric.Create(Self);
  FstartOfWeek          := THighNumber.Create(Self);
  FstartOnTick          := THighBoolean.Create(Self);
  Fstops                := THighGeneric.Create(Self);
  FtickAmount           := THighNumber.Create(Self);
  FtickColor            := THighString.Create(Self);
  FtickInterval         := THighNumber.Create(Self);
  FtickLength           := THighNumber.Create(Self);
  FtickmarkPlacement    := THighString.Create(Self);
  FtickPixelInterval    := THighNumber.Create(Self);
  FtickPosition         := THighChartPosition.Create(Self);
  FtickPositioner        := THighGeneric.Create(Self);
  FtickPositions        := THighNumbers.Create(Self);
  FtickWidth            := THighNumber.Create(Self);
  Ftitle                := THighTittle.Create(Self);
  Ftype                 := THighchartsAxisType.Create(Self);
  FuniqueNames          := THighBoolean.Create(Self);
  Funits                := THighGeneric.Create(Self);
  Fvisible              := THighBoolean.Create(Self);
end;

procedure TAxisOption.UpdateVariableNames;
VAR
  Contexto  : TRttiContext;
  Classe    : TRttiType;
  Field    : TRttiField;
  obj   : TObject;
begin
  Classe := Contexto.GetType(TAxisOption);
  for Field in Classe.GetDeclaredFields do
  BEGIN
    IF (Field.Visibility in [TMemberVisibility.mvPrivate]) THEN
    BEGIN
      if (Assigned(Field.FieldType.BaseType)) then
      BEGIN
        obj := Field.GetValue(Self).AsObject;
        if Assigned(obj) then

        BEGIN

          if (obj.InheritsFrom(THighValue))  then
          BEGIN
            Self.ChildList.Add(THighValue(obj));
            THighValue(obj).VariableName := copy(Field.Name,2,length(Field.Name)-1);
          END;
        END;
      END;


    END;
  END;
end;

{ TAxisAccessibility }

procedure TAxisAccessibility.CreateObjects;
begin
  inherited;
  Fdescription      := THighString.Create(Self);
  Fenabled          := THighBoolean.Create(Self);
  FrangeDescription := THighString.Create(Self);
end;

{ THighStrings }

procedure THighStrings.Change(Sender: Tobject);
begin
  Self.Generate := Value.count > 0;
end;

procedure THighStrings.CreateObjects;
begin
  inherited;
  FValue := TStringlist.Create;
  FValue.OnChange := Change;
end;

procedure THighStrings.DestroyObjects;
begin
  inherited;
  FValue.Free;
end;

function THighStrings.getValue: String;
VAR
  i : integer;
begin
  if FValue.Count > 0 then
  BEGIN
    Result := VariableName + ': ' + '[';
    for I := 0 to FValue.Count-1 do
    BEGIN
      IF i < FValue.Count-1 THEN
      BEGIN
        Result := Result + QuotedStr(FValue.Strings[i]) + ',';
      END
      else
      begin
        Result := Result + QuotedStr(FValue.Strings[i]);
      end;
    END;

    Result := Result  + ']';

  END;

end;

{ TAxisCrossHair }

procedure TAxisCrossHair.CreateObjects;
begin
  inherited;
  FclassName  := THighString.Create(Self);
  Fcolor      := THighString.Create(Self);
  FdashStyle  := THighGeneric.Create(Self);
  Fsnap       := THighBoolean.Create(Self);
  Fwidth      := THighNumber.Create(Self);
  FzIndex     := THighNumber.Create(Self);
end;


{ THighChart3DPosition }

function THighChart3DPosition.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighChart3DPosition.setValue(V: THighChart3DPositionValue);
begin
  FValue := v;
  Generate := true;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighCustomLabel }

procedure THighCustomLabel.CreateObjects;
begin
  inherited;
  Falign              := THighChartAling.Create(Self);
  FautoRotation       := THighGeneric.Create(Self);
  FautoRotationLimit  := THighNumber.Create(Self);
  FboxesToAvoid       := THighGeneric.Create(Self);
  FconnectorAllowed   := THighBoolean.Create(Self);
  FconnectorNeighbourDistance := THighNumber.Create(Self);
  Fdistance           := THighNumber.Create(Self);
  Fenabled            := THighBoolean.Create(Self);
  Fformat             := THighString.Create(Self);
  Fformatter          := THighGeneric.Create(Self);
  FmaxFontSize        := THighNullableNumber.Create(Self);
  FminFontSize        := THighNullableNumber.Create(Self);
  FonArea             := THighGeneric.Create(Self);
  Foverflow           := THighBoolean.Create(Self);
  Fpadding            := THighNumber.Create(Self);
  Fposition3d         := THighChart3DPosition.Create(Self);
  FreserveSpace       := THighBoolean.Create(Self);
  Frotation           := THighNumber.Create(Self);
  Fskew3d             := THighBoolean.Create(Self);
  FstaggerLines       := THighNumber.Create(Self);
  Fstep               := THighNumber.Create(Self);
  Fstyle              := THighGeneric.Create(Self);
  Ftext               := THighString.Create(Self);
  FtextAlign          := THighChartAling.Create(Self);
  FuseHTML            := THighNumber.Create(Self);
  FverticalAlign      := THighChartVerticalAling.Create(Self);
  Fx                  := THighNumber.Create(Self);
  Fy                  := THighNumber.Create(Self);
  FzIndex             := THighNumber.Create(Self);
end;


procedure THighCustomLabel.UpdateVariableNames;
VAR
  Contexto  : TRttiContext;
  Classe    : TRttiType;
  Field    : TRttiField;
  obj   : TObject;
begin
  Classe := Contexto.GetType(THighCustomLabel);
  for Field in Classe.GetDeclaredFields do
  BEGIN
    IF (Field.Visibility in [TMemberVisibility.mvPrivate]) THEN
    BEGIN
      if (Assigned(Field.FieldType.BaseType)) then
      BEGIN
        obj := Field.GetValue(Self).AsObject;
        if Assigned(obj) then

        BEGIN

          if (obj.InheritsFrom(THighValue))  then
          BEGIN
            Self.ChildList.Add(THighValue(obj));
            THighValue(obj).VariableName := copy(Field.Name,2,length(Field.Name)-1);
          END;
        END;
      END;


    END;
  END;
end;

{ THighNullableNumber }

function THighNullableNumber.getValue: String;
begin
  IF Value = -1 THEN
  BEGIN
    Result := VariableName + ': null';
  END
  else
  BEGIN
    Result := VariableName + ': ' + IntToStr(Value);
  END;
end;

{ THighChartPosition }

function THighChartPosition.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighChartPosition.setValue(V: THighChartPositionValue);
begin
  FValue := v;
  Generate := true;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ TAxisPlotBands }

procedure TAxisPlotBands.CreateObjects;
begin
  inherited;
  FborderColor    := THighString.Create(Self);
  FborderWidth    := THighNumber.Create(Self);
  FclassName      := THighString.Create(Self);
  Fcolor          := THighGeneric.Create(Self);
  Fevents         := THighGeneric.Create(Self);
  Ffrom           := THighNumber.Create(Self);
  Fid             := THighString.Create(Self);
  Flabel          := THighAxisPlotLabel.Create(Self);
  Fto             := THighNumber.Create(Self);
  FzIndex         := THighNumber.Create(Self);
end;

{ TAxisPlotLines }

procedure TAxisPlotLines.CreateObjects;
begin
  inherited;
  FclassName        := THighString.Create(Self);
  Fcolor            := THighString.Create(Self);
  FdashStyle        := THighGeneric.Create(Self);
  Fevents           := THighGeneric.Create(Self);
  Fid               := THighString.Create(Self);
  Flabel            := THighAxisPlotLabel.Create(Self);
  FValue            := THighNumber.Create(Self);
  Fwidth            := THighNumber.Create(Self);
  FzIndex           := THighNumber.Create(Self);
end;


{ THighNumbers }



procedure THighNumbers.Change(Sender: TObject; const Item: extended;
  Action: TCollectionNotification);
begin
  Self.Generate := True;
end;

procedure THighNumbers.CreateObjects;
begin
  inherited;
  FValue := TList<extended>.Create;
end;

procedure THighNumbers.DestroyObjects;
begin
  inherited;
  FValue.Free;
end;

function THighNumbers.getValue: String;
VAR
  i : integer;
  F: TFormatSettings;
begin
  F.DecimalSeparator := '.';
  if FValue.Count > 0 then
  BEGIN
    Result := VariableName + ': ' + '[';
    for I := 0 to FValue.Count-1 do
    BEGIN
      IF i < FValue.Count-1 THEN
      BEGIN
        Result := Result + FormatFloat('',FValue.Items[i],F) + ',';
      END
      else
      begin
        Result := Result + FormatFloat('',FValue.Items[i],F);
      end;
    END;

    Result := Result  + ']';

  END;
end;

procedure THighNumbers.InitializeOBjects;
begin
  inherited;
  FValue.OnNotify := Change;
end;

{ THighchartsAxisType }

function THighchartsAxisType.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

{ THighGeneric }

function THighGeneric.getValue: String;
begin
  Result := VariableName + ': ' + Value;
end;

{ THighchartsLayout }

function THighchartsLayout.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighchartsLayout.setValue(V: THighchartsLayoutValue);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighLegend }

procedure THighLegend.CreateObjects;
begin
  inherited;
  Faccessibility      := THighGeneric.Create(Self);
  Falign              := THighChartAling.Create(Self);
  FalignColumns       := THighBoolean.Create(Self);
  FbackgroundColor    := THighString.Create(Self);
  FborderColor        := THighString.Create(Self);
  FborderRadius       := THighNumber.Create(Self);
  FborderWidth        := THighNumber.Create(Self);
  FbubbleLegend       := THighGeneric.Create(Self);
  Fenabled            := THighBoolean.Create(Self);
  Ffloating           := THighBoolean.Create(Self);
  FitemCheckboxStyle  := THighGeneric.Create(Self);
  FitemDistance       := THighNumber.Create(Self);
  FitemHiddenStyle    := THighGeneric.Create(Self);
  FitemHoverStyle     := THighGeneric.Create(Self);
  FitemMarginBottom   := THighNumber.Create(Self);
  FitemMarginTop      := THighNumber.Create(Self);
  FitemStyle          := THighGeneric.Create(Self);
  FitemWidth          := THighNumber.Create(Self);
  FlabelFormat        := THighString.Create(Self);
  FlabelFormatter     := THighGeneric.Create(Self);
  Flayout             := THighchartsLayout.Create(Self);
  Fmargin             := THighNumber.Create(Self);
  FmaxHeight          := THighNumber.Create(Self);
  Fnavigation         := THighGeneric.Create(Self);
  Fpadding            := THighNumber.Create(Self);
  Freversed           := THighBoolean.Create(Self);
  Frtl                := THighBoolean.Create(Self);
  Fshadow             := THighBoolean.Create(Self);
  FsquareSymbol       := THighBoolean.Create(Self);
  FsymbolHeight       := THighNumber.Create(Self);
  FsymbolPadding      := THighNumber.Create(Self);
  FsymbolRadius       := THighNumber.Create(Self);
  FsymbolWidth        := THighNumber.Create(Self);
  Ftitle              := THighTittle.Create(Self);
  FuseHTML            := THighBoolean.Create(Self);
  FverticalAlign      := THighChartVerticalAling.Create(Self);
  Fwidth              := THighGeneric.Create(Self);
  Fx                  := THighNumber.Create(Self);
  Fy                  := THighNumber.Create(Self);
end;


procedure THighLegend.InitializeObjects;
begin
  inherited;
  //itemStyle.Value       := '{"color": "#333333", "cursor": "pointer", "fontSize": "10px", "fontWeight": "bold", "textOverflow": "ellipsis"}';
end;

{ THighchartsType }

function THighchartsType.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighchartsType.setValue(V: THighchartsTypeValues);
begin
  FValue := v;
  Generate := true;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighZoomType }

function THighZoomType.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighZoomType.setValue(V: THighZoomTypeValue);
begin
  FValue := v;
  Generate := true;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighChart }

procedure THighChart.CreateObjects;
begin
  inherited;
  FalignTicks           := THighBoolean.create(Self);
  Fanimation            := THighBoolean.create(Self);
  FbackgroundColor      := THighGeneric.create(Self);
  FborderColor          := THighString.create(Self);
  FborderRadius         := THighNumber.create(Self);
  FborderWidth          := THighNumber.create(Self);
  FclassName            := THighString.create(Self);
  FcolorCount           := THighNumber.create(Self);
  FdisplayErrors        := THighBoolean.create(Self);
  Fevents               := THighGeneric.create(Self);
  Fheight               := THighGeneric.create(Self);
  FignoreHiddenSeries   := THighBoolean.create(Self);
  Finverted             := THighBoolean.create(Self);
  Fmargin               := THighGeneric.create(Self);
  FmarginBottom         := THighNumber.create(Self);
  FmarginLeft           := THighNumber.create(Self);
  FmarginRight          := THighNumber.create(Self);
  FmarginTop            := THighNumber.create(Self);
  Foptions3d            := THighGeneric.create(Self);
  FpanKey               := THighString.create(Self);
  Fpanning              := THighBoolean.create(Self);
  FparallelAxes         := THighGeneric.create(Self);
  FparallelCoordinates  := THighBoolean.create(Self);
  FpinchType            := THighString.create(Self);
  FplotBackgroundColor  := THighGeneric.create(Self);
  FplotBackgroundImage  := THighString.create(Self);
  FplotBorderColor      := THighString.create(Self);
  FplotBorderWidth      := THighNumber.create(Self);
  FplotShadow           := THighGeneric.create(Self);
  Fpolar                := THighBoolean.create(Self);
  Freflow               := THighBoolean.create(Self);
  FrenderTo             := THighGeneric.create(Self);
  FresetZoomButton      := THighGeneric.create(Self);
  FscrollablePlotArea   := THighGeneric.create(Self);
  FselectionMarkerFill  := THighString.create(Self);
  Fshadow               := THighGeneric.create(Self);
  FshowAxes             := THighBoolean.create(Self);
  Fspacing              := THighNumbers.create(Self);
  FspacingBottom        := THighNumber.create(Self);
  FspacingLeft          := THighNumber.create(Self);
  FspacingRight         := THighNumber.create(Self);
  FspacingTop           := THighNumber.create(Self);
  Fstyle                := THighGeneric.create(Self);
  FstyledMode           := THighBoolean.create(Self);
  Ftype                 := THighchartsType.create(Self);
  Fwidth                := THighGeneric.create(Self);
  FzoomKey              := THighString.create(Self);
  FzoomType             := THighZoomType.create(Self);
end;

procedure THighChart.InitializeObjects;
begin
  inherited;
  FrenderTo.Value := quotedStr('container');
end;

{ THighCredits }

procedure THighCredits.CreateObjects;
begin
  inherited;
  Fenabled        := THighBoolean.create(Self);
  Fhref           := THighString.create(Self);
  Fstyle          := THighGeneric.create(Self);
  Ftext           := THighString.create(Self);
end;


procedure THighCredits.InitializeObjects;
begin
  inherited;
  enabled.Value := False;
end;

{ THighLoading }

procedure THighLoading.CreateObjects;
begin
  inherited;
  FhideDuration     := THighNumber.create(Self);
  FlabelStyle       := THighGeneric.create(Self);
  FshowDuration     := THighNumber.create(Self);
  Fstyle            := THighGeneric.create(Self);
end;

{ THighplotOptions }

procedure THighplotOptions.CreateObjects;
begin
  inherited;
  Farea             := THighAreaPlotOptions.create(Self);
  Farearange        := THighGeneric.create(Self);
  Fareaspline       := THighGeneric.create(Self);
  Fareasplinerange  := THighGeneric.create(Self);
  Fbar              := THighBarPlotOptions.create(Self);
  Fbellcurve        := THighGeneric.create(Self);
  Fboxplot          := THighGeneric.create(Self);
  Fbubble           := THighGeneric.create(Self);
  Fbullet           := THighGeneric.create(Self);
  Fcolumn           := THighGeneric.create(Self);
  Fcolumnpyramid    := THighGeneric.create(Self);
  Fcolumnrange      := THighGeneric.create(Self);
  Fcylinder         := THighGeneric.create(Self);
  Fdependencywheel  := THighGeneric.create(Self);
  Ferrorbar         := THighGeneric.create(Self);
  Ffunnel           := THighGeneric.create(Self);
  Ffunnel3d         := THighGeneric.create(Self);
  Fgauge            := THighGeneric.create(Self);
  Fheatmap          := THighGeneric.create(Self);
  Fhistogram        := THighGeneric.create(Self);
  Fitem             := THighGeneric.create(Self);
  Fline             := THighGeneric.create(Self);
  Fnetworkgraph     := THighGeneric.create(Self);
  Forganization     := THighGeneric.create(Self);
  Fpackedbubble     := THighGeneric.create(Self);
  Fpareto           := THighGeneric.create(Self);
  Fpie              := THighPiePlotOptions.create(Self);
  Fpolygon          := THighGeneric.create(Self);
  Fpyramid          := THighGeneric.create(Self);
  Fpyramid3d        := THighGeneric.create(Self);
  Fsankey           := THighGeneric.create(Self);
  Fscatter          := THighGeneric.create(Self);
  Fscatter3d        := THighGeneric.create(Self);
  Fseries           := THighSeriesPlotOptions.create(Self);
  Fsolidgauge       := THighGeneric.create(Self);
  Fspline           := THighGeneric.create(Self);
  Fstreamgraph      := THighGeneric.create(Self);
  Fsunburst         := THighGeneric.create(Self);
  Ftilemap          := THighGeneric.create(Self);
  Ftimeline         := THighGeneric.create(Self);
  Ftreemap          := THighGeneric.create(Self);
  Fvariablepie      := THighGeneric.create(Self);
  Fvariwide         := THighGeneric.create(Self);
  Fvector           := THighGeneric.create(Self);
  Fvenn             := THighGeneric.create(Self);
  Fwaterfall        := THighGeneric.create(Self);
  Fwindbarb         := THighGeneric.create(Self);
  Fwordcloud        := THighGeneric.create(Self);
  Fxrange           := THighGeneric.create(Self);
end;

{ THighStacking }

function THighStacking.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighStacking.setValue(V: THighStackingValue);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighchartsCustomPlotOptions }

procedure THighchartsCustomPlotOptions.CreateObjects;
begin
  inherited;
  Faccessibility              := THighGeneric.create(Self);
  FallowPointSelect           := THighBoolean.create(Self);
  Fanimation                  := THighGeneric.create(Self);
  FanimationLimit             := THighNumber.create(Self);
  FboostBlending              := THighString.create(Self);
  FboostThreshold             := THighNumber.create(Self);
  FborderColor                := THighString.create(Self);
  FborderRadius               := THighNumber.create(Self);
  FborderWidth                := THighNumber.create(Self);
  FclassName                  := THighString.create(Self);
  Fcenter                     := THighGeneric.create(Self);
  Fclip                       := THighBoolean.create(Self);
  Fcolor                      := THighGeneric.create(Self);
  FcolorByPoint               := THighBoolean.create(Self);
  FcolorIndex                 := THighNumber.create(Self);
  Fcolors                     := THighGeneric.create(Self);
  FconnectEnds                := THighBoolean.create(Self);
  FconnectNulls               := THighBoolean.create(Self);
  Fcrisp                      := THighBoolean.create(Self);
  FcropThreshold              := THighNumber.create(Self);
  Fcursor                     := THighGeneric.create(Self);
  FdataLabels                 := THighDataLabelsOptions.create(Self);
  FdashStyle                  := THighGeneric.create(Self);
  Fdepth                      := THighNumber.create(Self);
  Fdescription                := THighString.create(Self);
  FdragDrop                   := THighGeneric.create(Self);
  FedgeColor                  := THighString.create(Self);
  FedgeWidth                  := THighNumber.create(Self);
  FenableMouseTracking        := THighBoolean.create(Self);
  Fevents                     := THighGeneric.create(Self);
  FexposeElementToA11y        := THighBoolean.create(Self);
  FfillColor                  := THighGeneric.create(Self);
  FfillOpacity                := THighNumber.create(Self);
  FfindNearestPointBy         := THighString.create(Self);
  FgetExtremesFromAll         := THighBoolean.create(Self);
  Fid                         := THighString.Create(Self);
  Fgrouping                   := THighBoolean.create(Self);
  FgroupPadding               := THighNumber.create(Self);
  FgroupZPadding              := THighNumber.create(Self);
  FincludeInDataExport        := THighBoolean.create(Self);
  Findex                      := THighString.Create(Self);
  FinnerSize                  := THighGeneric.Create(Self);
  Fkeys                       := THighStrings.create(Self);
  Flabel                      := THighSeriesLabel.create(Self);
  FlegendIndex                := THighNumber.Create(Self);
  Flinecap                    := THighGeneric.Create(self);
  FlineColor                  := THighString.Create(Self);
  FlineWidth                  := THighNumber.Create(self);
  FlinkedTo                   := THighStrings.create(Self);
  Fmarker                     := THighGeneric.create(Self);
  FmaxPointWidth              := THighNumber.create(Self);
  FminPointLength             := THighNumber.create(Self);
  FminSize                    := THighNumber.Create(Self);
  FnegativeColor              := THighGeneric.create(Self);
  FnegativeFillColor          := THighGeneric.create(Self);
  Fopacity                    := THighNumber.create(Self);
  Fpoint                      := THighGeneric.create(Self);
  FpointDescriptionFormatter  := THighGeneric.create(Self);
  FpointInterval              := THighNumber.create(Self);
  FpointIntervalUnit          := THighStrings.create(Self);
  FpointPadding               := THighNumber.create(Self);
  FpointPlacement             := THighGeneric.create(Self);
  FpointRange                 := THighNullableNumber.create(Self);
  FpointStart                 := THighNumber.create(Self);
  FpointWidth                 := THighNumber.create(Self);
  Fselected                   := THighBoolean.create(Self);
  Fshadow                     := THighGeneric.create(Self);
  FshowCheckbox               := THighBoolean.create(Self);
  FshowInLegend               := THighBoolean.create(Self);
  Fsize                       := THighGeneric.Create(Self);
  FslicedOffset               := THighNumber.Create(Self);
  FstartAngle                 := THighNumber.Create(Self);
  FskipKeyboardNavigation     := THighBoolean.create(Self);
  FsoftThreshold              := THighBoolean.create(Self);
  Fstacking                   := THighStacking.create(Self);
  Fstates                     := THighGeneric.create(Self);
  Fstep                       := THighString.create(Self);
  FstickyTracking             := THighBoolean.create(Self);
  Fthreshold                  := THighNumber.create(Self);
  Ftooltip                    := THighchartToolTip.create(Self);
  FtrackByArea                := THighBoolean.Create(Self);
  FturboThreshold             := THighNumber.create(Self);
  Ftype                       := THighchartsType.Create(Self);
  Fvisible                    := THighBoolean.create(Self);
  FxAxis                      := THighNumber.Create(Self);
  FyAxis                      := THighNumber.Create(Self);
  FzIndex                     := THighNumber.Create(Self);
  FzoneAxis                   := THighString.create(Self);
  Fzones                      := THighGeneric.create(Self);
end;

{ THighSeriesPlotOptions }


procedure THighchartsCustomPlotOptions.UpdateVariableNames;
VAR
  Contexto  : TRttiContext;
  Classe    : TRttiType;
  Field    : TRttiField;
  obj   : TObject;
begin
  Classe := Contexto.GetType(THighchartsCustomPlotOptions);
  for Field in Classe.GetDeclaredFields do
  BEGIN
    IF (Field.Visibility in [TMemberVisibility.mvPrivate]) THEN
    BEGIN
      if (Assigned(Field.FieldType.BaseType)) then
      BEGIN
        obj := Field.GetValue(Self).AsObject;
        if Assigned(obj) then

        BEGIN

          if (obj.InheritsFrom(THighValue))  then
          BEGIN
            Self.ChildList.Add(THighValue(obj));
            THighValue(obj).VariableName := copy(Field.Name,2,length(Field.Name)-1);
          END;
        END;
      END;


    END;
  END;
end;


{ THighChartSetp }

function THighChartSetp.getValue: String;
begin
  Result := VariableName + ': ' + QuotedStr(getSettedValue(TRttiEnumerationType.GetName(FValue)));
end;

procedure THighChartSetp.setValue(V: THighChartSetpValue);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ THighResponsiveOptions }

procedure THighResponsiveOptions.CreateObjects;
begin
  inherited;
  Frules  := THighResponsiveRules.Create(Self);
end;

procedure THighResponsiveOptions.DestroyObjects;
begin
  inherited;

end;

{ THighResponsiveRulesConditions }

procedure THighResponsiveRulesConditions.CreateObjects;
begin
  inherited;
  Fcallback       := THighGeneric.Create(Self);
  FmaxHeight      := THighNumber.Create(Self);
  FmaxWidth       := THighNumber.Create(Self);
  FminHeight      := THighNumber.Create(Self);
  FminWidth       := THighNumber.Create(Self);
end;

{ THighResponsiveRules }

procedure THighResponsiveRules.CreateObjects;
begin
  inherited;
  FchartOptions   := THighGeneric.Create(Self);
  Fcondition      := THighResponsiveRulesConditions.Create(Self);
end;

{ THighSetValue }

procedure THighSetValue.CreateObjects;
begin
  inherited;
  sPrefixeObject := '[';
  sPosfixeObject := ']';
end;

{ THighTimeOptions }

procedure THighTimeOptions.CreateObjects;
begin
  inherited;
  FDate                 := THighGeneric.Create(Self);
  FgetTimezoneOffset    := THighGeneric.Create(Self);
  Ftimezone             := THighString.Create(Self);
  FtimezoneOffset       := THighNumber.Create(Self);
  FuseUTC               := THighBoolean.Create(Self);
end;

{ THighchartSeries }

function THighchartSeries.Add: TSerie;
begin
  Result := TSerie(inherited Add);
end;



procedure THighchartSeries.AutoCompleteWithZero(CategoriesNumber: integer);
VAR
  i,j : integer;
  Item : TSerie;
  Data : TSerieValue;
begin
  for I := 0 to self.Count-1 do
  BEGIN
    Item := Items[i];
    for j := 0 to CategoriesNumber-1 do
    BEGIN
      Data := Item.FData.ItemByX(j);
      if Not Assigned(Data) then
      BEGIN
        Data := Item.FData.Add(j,0);
      END;

      Data.SetIndex(j);

    END;
  END;
end;

procedure THighchartSeries.ClearData;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  BEGIN
    items[i].Data.Clear;
  END;
end;

procedure THighchartSeries.GenerateHighchartSeries(SL: TStrings);
VAR
  i,j : integer;
  Serie : TSerie;
  D : TSerieData;
begin
  for i := 0 to Count-1 do
  BEGIN
    Serie := Items[i];
    SL.Add(StringOfChar(' ',4) + '{');

    if Serie.FSerieName <> '' then
    BEGIN
      SL.Add(StringOfChar(' ',6) + 'name: ' + QuotedStr(Serie.FSerieName) +',');
    END;




    if  Serie.Options.ChildList.Count > 0 then
    BEGIN
      for j := 0 to Serie.Options.ChildList.Count -1 do
      BEGIN
        Serie.Options.ChildList[j].AddValue(SL);
      END;
      AddLastComma(SL);
    END;

    SL.Add(StringOfChar(' ',6) +'data: ');
    SL.Add(StringOfChar(' ',6) +'[');

    D := Items[i].Data;


    for j := 0 to D.Count-1 do
    BEGIN


      if Serie.Data[j].Null then
      BEGIN

        if j < Serie.Data.Count-1  then
        BEGIN
          SL.Add(StringOfChar(' ',10) +'null,');
        END
        else
        BEGIN
          SL.Add(StringOfChar(' ',10) +'null');
        END;
      END
      else
      BEGIN
        SL.Add(StringOfChar(' ',8) +'{');
        SL.Add(StringOfChar(' ',10) +'x: ' + Serie.Data[j].X.toStr + ',');
        SL.Add(StringOfChar(' ',10) +'y: ' + Serie.Data[j].Y.toStr);
        Serie.Data[j].percentage.AddValue(SL);
        Serie.Data[j].total.AddValue(SL);
        if j < Serie.Data.Count-1  then
        BEGIN
          SL.Add(StringOfChar(' ',8) +'},');
        END
        else
        BEGIN
          SL.Add(StringOfChar(' ',8) +'}');
        END;
      END;







    END;



    SL.Add(StringOfChar(' ',6) +']');


    if i < Count-1  then
    BEGIN
      SL.Add(StringOfChar(' ',4) +'},');
    END
    else
    BEGIN
      SL.Add(StringOfChar(' ',4) +'}');
    END;

  END;
end;




function THighchartSeries.getSerie(Index: Integer): TSerie;
begin
  Result := TSerie(inherited Items[Index]);
end;

function THighchartSeries.ItemByName(sName: string): TSerie;
VAR
  i : integer;
begin
  result := nil;
  for I := 0 to Count-1 do
  BEGIN
    if items[i].SerieName = sName then
    BEGIN
      Result := items[i];
      Exit;
    END;

  END;
end;

procedure THighchartSeries.setSerie(Index: Integer; Value: TSerie);
begin
  Items[Index].Assign(Value);
end;

{ THighcartSeriesOptions }

procedure THighcartSeriesOptions.AddValue(SL: TStrings);
begin
  //if Generate then
  BEGIN


    if
    (List.FieldNameForSerie <> '') and
    (List.FieldNameForX <> '') and
    (List.FieldNameForY <> '')
    then
    BEGIN
      List.Clear;
      LoadSeriesFromDataset;
    END;

    if list.Count > 0 then
    BEGIN
      AddLastComma(SL);
      Sl.Add(StringOfChar(' ',2) + Self.VariableName + ':');
      Sl.Add(StringOfChar(' ',2) + '[');
      list.GenerateHighchartSeries(SL);
      Sl.Add(StringOfChar(' ',2) + ']');
    END;


  END;

end;

procedure THighcartSeriesOptions.CreateObjects;
begin
  inherited;
  Generate := true;
  FDatasource := TDatasource.Create(nil);
  FList := THighchartSeries.Create(TSerie);
end;


procedure THighcartSeriesOptions.DestroyObjects;
begin
  inherited;
  FDatasource.free;
  FList.Free;
end;

procedure THighcartSeriesOptions.InitializeObjects;
begin
  inherited;
end;

procedure THighcartSeriesOptions.LoadSeriesFromDataset;
var
  DS : TDataset;
  sSerieName : String;
  Item : TSerie;
  Data : TSerieValue;
  c,ix : integer;
begin
  c := 0;
  Item := nil;
  Data := nil;
  if Assigned(Datasource.DataSet) then
  begin
    DS := Datasource.DataSet;

    if Not ds.Active then
    BEGIN
      Exit;
    END;

    if (not datasource.DataSet.IsEmpty) then
    BEGIN
      if Assigned(DS.FieldByName(List.FFieldNameForSerie)) then
      BEGIN
        DS.First;
        sSerieName := '';
        while not DS.Eof do
        BEGIN
          if sSerieName <> TRIM(DS.FieldByName(List.FFieldNameForSerie).AsString) then
          BEGIN
            if Assigned(Item) and Assigned(AfterSeriePrepared) then
            BEGIN
              AfterSeriePrepared(Item);
            END;


            sSerieName := TRIM(DS.FieldByName(List.FFieldNameForSerie).AsString);
            Item := List.add;
            With Item DO
            BEGIN
              SerieName := sSerieName;
              FieldNameForX := List.FieldNameForX;
              FieldNameForY := List.FieldNameForY;
            END;
          END;


          Data := Item.Data.Add;
          With Data DO
          BEGIN

            if ChartMode = mMonthly then
            BEGIN
              X.Value := DS.FieldByName(List.FieldNameForX).AsExtended -1;
            END
            else
            BEGIN
              X.Value := DS.FieldByName(List.FieldNameForX).AsExtended;
            END;

            Y.Value := DS.FieldByName(List.FieldNameForY).AsExtended;


            if Assigned(AfterItemDataAdded) then
            BEGIN
              AfterItemDataAdded(List,Item,Data)
            END;
          END;

          DS.Next;

        END;

        if Assigned(AfterLoadSeriesFromDataset) then
        BEGIN
          AfterLoadSeriesFromDataset(Self);
        END;

        if Categories.Count > 0 then
        BEGIN
          List.AutoCompleteWithZero(Categories.Count);
        END;


      END
      else
      BEGIN
        raise Exception.Create('Campo ' + QuotedStr(List.FFieldNameForSerie) + ' não encontrado no dataset.');
      END;
    END;







  end;

end;


procedure THighcartSeriesOptions.setChartMode(V: THighChartModeValue);
begin
  FChartMode := V;
  FList.ChartMode := V;
end;

{ TSerieData }

function TSerieData.Add: TSerieValue;
begin
  Result := TSerieValue(inherited Add);
end;

function TSerieData.Add(xValue: extended ; yValue : Extended): TSerieValue;
begin
  Result := Add;
  With Result DO
  BEGIN
    X.Value := xValue;
    Y.Value := yValue;
  END;
end;

procedure TSerieData.AddNull;
begin
  Add.Null := True;
end;

function TSerieData.getValue(Index: Integer): TSerieValue;
begin
  Result := TSerieValue(inherited Items[Index]);
end;

function TSerieData.ItemByX(v : Extended): TSerieValue;
VAR
  i : integer;
begin
  Result := nil;
  for i := 0 to count-1 do
  BEGIN
    if Items[i].x.Value = v then
    BEGIN
      Result := Items[i];
      Break;
    END;
  END;
end;

procedure TSerieData.setValue(Index: Integer; Value: TSerieValue);
begin
  Items[Index].Assign(Value);
end;

{ TSerie }

constructor TSerie.Create(Collection: TCollection);
begin
  inherited;
  FData := TSerieData.Create(TSerieValue);
  FOptions := THighSeriesSOptions.Create(nil);
end;

{ THighChartMode }


procedure THighChartMode.setValue(V: THighChartModeValue);
begin
  FValue := V;
  if Assigned(FOnChange) then
  BEGIN
    FOnChange(Self);
  END;
end;

{ TSerieValue }

constructor TSerieValue.Create(Collection: TCollection);
begin
  inherited;
  FNull := False;
  FX := TSerieCoordenate.Create;
  FY := TSerieCoordenate.Create;

  Fpercentage   := THighFloat.Create(nil);
  Ftotal        := THighFloat.Create(nil);

  UpdateVariableNames;
end;



procedure TSerieValue.UpdateVariableNames;
VAR
  Contexto  : TRttiContext;
  Classe    : TRttiType;
  Field    : TRttiField;
  obj   : TObject;
begin
  Classe := Contexto.GetType(Self.ClassType);
  for Field in Classe.GetDeclaredFields do
  BEGIN
    IF (Field.Visibility in [TMemberVisibility.mvPrivate,TMemberVisibility.mvProtected]) THEN
    BEGIN
      if (Assigned(Field.FieldType.BaseType)) then
      BEGIN
        obj := Field.GetValue(Self).AsObject;
        if Assigned(obj) then

        BEGIN

          if (obj.InheritsFrom(THighValue))  then
          BEGIN
            THighValue(obj).VariableName := copy(Field.Name,2,length(Field.Name)-1);
          END;
        END;
      END;


    END;
  END;
end;

{ THighAxisLabel }

procedure THighAxisLabel.InitializeObjects;
begin
  inherited;
  
end;

{ TSerieCoordenate }

constructor TSerieCoordenate.Create;
begin
  inherited;
  FValue := 0;
  F.DecimalSeparator := '.';
  F.ThousandSeparator := ',';
end;

function TSerieCoordenate.toStr: String;
begin
  Result := FormatFloat('',FValue,F);
end;

{ TArrayAxisOption }

procedure TArrayXAxisOption.AddValue(SL: TStrings);
VAR
  i : integer;
  s : String;
begin
  if Generate then
  BEGIN
    s := getValue;

    if (SL.Count > 0) and
    (
      (s <> '')
      or
      (FAxis.Count > 0)
    )
    then
    BEGIN

      AddLastComma(SL);

    END;


    if s <> '' then
    BEGIN
      SL.Add(getTabs + s);
    END;


    if FAxis.Count > 0 then
    BEGIN
      if Self.VariableName <> '' then
      BEGIN
        Sl.Add(getTabs + Self.VariableName + ':');
      END;


      Sl.Add(getTabs + sPrefixeObject + '[');
      for i := 0 to FAxis.Count -1 do
      BEGIN
        IF FAxis.Items[i].Generate THEN
        BEGIN
          FAxis.Items[i].AddValue(SL);
        END;

      END;

      Sl.Add(getTabs +  ']' + sPosfixeObject);
    END;
  END;
end;

procedure TArrayXAxisOption.CreateObjects;
begin
  inherited;
  FAxis := TObjectList<TXAxisOption>.Create;
  FAxis.Add(TXAxisOption.Create(Self));
end;



procedure TArrayXAxisOption.DestroyObjects;
begin
  inherited;
  FAxis.Free;
end;

function TArrayXAxisOption.getGenerate: Boolean;
VAR
  i :  integer;
begin
  for I := 0 to FAxis.Count -1  do
  BEGIN
    if FAxis.Items[i].Generate then
    BEGIN
      Result := true;
      Exit;
    END;
  END;
  Result := False;
end;

{ THighDataLabelsOptions }

procedure THighDataLabelsOptions.CreateObjects;
begin
  inherited;
  Falign            := THighChartAling.Create(Self);
  FallowOverlap     := THighBoolean.Create(Self);
  FbackgroundColor  := THighGeneric.Create(Self);
  FborderColor      := THighString.Create(Self);
  FborderRadius     := THighNumber.Create(Self);
  FborderWidth      := THighNumber.Create(Self);
  FclassName        := THighString.Create(Self);
  Fcolor            := THighString.Create(Self);
  Fcrop             := THighBoolean.Create(Self);
  Fdefer            := THighBoolean.Create(Self);
  Fenabled          := THighBoolean.Create(Self);
  Ffilter           := THighGeneric.Create(Self);
  Fformat           := THighString.Create(Self);
  Fformatter        := THighGeneric.Create(Self);
  Finside           := THighBoolean.Create(Self);
  FnullFormat       := THighGeneric.Create(Self);
  FnullFormatter    := THighGeneric.Create(Self);
  Foverflow         := THighGeneric.Create(Self);
  Fpadding          := THighNumber.Create(Self);
  Frotation         := THighNumber.Create(Self);
  Fshadow           := THighGeneric.Create(Self);
  Fshape            := THighString.Create(Self);
  Fstyle            := THighGeneric.Create(Self);
  FtextPath         := THighGeneric.Create(Self);
  FuseHTML          := THighBoolean.Create(Self);
  FverticalAlign    := THighChartVerticalAling.Create(Self);
  Fx                := THighNumber.Create(Self);
  Fy                := THighNumber.Create(Self);
  FzIndex           := THighNumber.Create(Self);
end;

{ THighSeriesLabel }

procedure THighSeriesLabel.InitializeObjects;
begin
  inherited;
  //enabled.Value := false;
end;

{ THighSeriesSOptions }

procedure THighSeriesSOptions.CreateObjects;
begin
  Self.CountTab := 2;
  inherited;

end;

procedure THighSeriesSOptions.InitializeObjects;
begin
  inherited;
  labels.Generate := False;
end;

Function GetAppDirectory : String;
BEGIN
  {$IFDEF MSWINDOWS}
  Result := StringReplace(ExtractFilePath(GetModuleName(HInstance)),'\\?\','',[rfReplaceAll,rfIgnoreCase]);
  {$ELSE}
  Result := TPath.GetDocumentsPath + PathDelim;
  {$ENDIF}
END;

Function  getMonthShortDescription( index : integer) : String;
BEGIN
  case index of
    1: Result := 'Jan';
    2: Result := 'Fev';
    3: Result := 'Mar';
    4: Result := 'Abr';
    5: Result := 'Maio';
    6: Result := 'Jun';
    7: Result := 'Jul';
    8: Result := 'Ago';
    9: Result := 'Set';
    10: Result := 'Out';
    11: Result := 'Nov';
    12: Result := 'Dez';
    Else Result := '';
  end;
END;

{ THighFloat }

function THighFloat.getValue: String;
VAR
  F : TFormatSettings;
begin
  F.DecimalSeparator := '.';
  Result := VariableName + ': ' + FormatFloat('',Value,F);
end;

procedure THighFloat.setValue(V: extended);
begin
  FValue := V;
  Generate := True;
  if assigned(Onchange) then
  BEGIN
    Onchange(Self);
  END;
end;

{ TArrayYAxisOption }

procedure TArrayYAxisOption.AddValue(SL: TStrings);
VAR
  i : integer;
  s : String;
begin
  if Generate then
  BEGIN
    s := getValue;

    if (SL.Count > 0) and
    (
      (s <> '')
      or
      (FAxis.Count > 0)
    )
    then
    BEGIN

      AddLastComma(SL);

    END;


    if s <> '' then
    BEGIN
      SL.Add(getTabs + s);
    END;


    if FAxis.Count > 0 then
    BEGIN
      if Self.VariableName <> '' then
      BEGIN
        Sl.Add(getTabs + Self.VariableName + ':');
      END;


      Sl.Add(getTabs + sPrefixeObject + '[');
      for i := 0 to FAxis.Count -1 do
      BEGIN
        IF FAxis.Items[i].Generate THEN
        BEGIN
          FAxis.Items[i].AddValue(SL);
        END;

      END;

      Sl.Add(getTabs +  ']' + sPosfixeObject);
    END;
  END;
end;

procedure TArrayYAxisOption.CreateObjects;
begin
  inherited;
  FAxis := TObjectList<TYAxisOption>.Create;
  FAxis.Add(TYAxisOption.Create(Self));
end;


procedure TArrayYAxisOption.DestroyObjects;
begin
  FAxis.Free;
  inherited;

end;

function TArrayYAxisOption.getGenerate: Boolean;
VAR
  i :  integer;
begin
  for I := 0 to FAxis.Count -1  do
  BEGIN
    if FAxis.Items[i].Generate then
    BEGIN
      Result := true;
      Exit;
    END;
  END;
  Result := False;
end;


end.



