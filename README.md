# Unigui-Components

Highcharts API docs: https://api.highcharts.com/highcharts/xAxis
Download zip files: https://www.highcharts.com/blog/download/

For comercial use, buy it.

[English]

--How to install?
1.Open the project with the Delphi IDE and install it;

2.Go to Tools->Options;

3.Go to Environment options->Delphi Options->Library;
4.In Library path add the project "source" folder;
5.Comment the line with "AddPortugueseTraduction;" in unit uEchoHightChart;
6.See the "InitializeObjects" method for replace or comment the code which translates the multiples of a thousand;

--How to use?
0.Download and extract the zip files from the Highcharts folder in the main folder of your application;
1.Drop a "TEchoHightChart" on the screen and adjust its size and alignment.
2.Access the properties as follows:
    "HighChartOptions.PropertyName.Value: = newValue;"
    Ex: EchoHightChart1.HighChartOptions.title.text.Value: = 'Introduction';
3.To process the graph use the "Load" method;



[Portuguese]

--Como instalar?
1.Abra o projeto com a IDE do Delphi e instale-o;
2.Vá para Tools->Options;
3.Vá para Environment options->Delphi Options->Library;
4.Em Library path adicione a pasta "source "do projeto;

--Como usar?
0.Baixar e etrar os arquivos da pasta Highcharts na pasta principal da sua aplicação;
1.Solte um "TEchoHightChart" na tela e ajuste seu tamanho e alinhamento.
2.Acesse as propriedades da seguinte forma:
    "HighChartOptions.PropertyName.Value := newValue;"
    Ex: EchoHightChart1.HighChartOptions.title.text.Value := 'Introduction';
3.Pasra processar o gráfico utilize o método "Load";
