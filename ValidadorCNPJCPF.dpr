program ValidadorCNPJCPF;

uses
  Vcl.Forms,
  UFormValidador in 'src\UFormValidador.pas' {FormValidador},
  UValidadorPfPj in 'src\UValidadorPfPj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormValidador, FormValidador);
  Application.Run;
end.
