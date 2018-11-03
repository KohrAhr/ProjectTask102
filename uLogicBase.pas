unit uLogicBase;

interface

uses
	System.Generics.Collections;

type
	TLogicResult = TList<String>;

	TLogicBase = class
	protected
		FLogicResult: TLogicResult;
		FRequiredResult: String;
		FOperations: String;
		function MergeStrings(AInnerData, AOuterData: String): String;
	public
		procedure DisplayResult;

		constructor Create;
		destructor Destroy; override;
	end;

implementation

uses
	System.SysUtils;

{ TLogicBase }


function TLogicBase.MergeStrings(AInnerData, AOuterData: String): String;
var
	LCycle: Integer;
begin
	Assert(AInnerData.Length - 1 < AOuterData.Length);

	Result := '';

	for LCycle := 1 to AOuterData.Length do
		begin
			Result := Result + AOuterData[LCycle];
			if LCycle <= AInnerData.Length then
				Result := Result + AInnerData[LCycle];
		end;

	// Remove empty space (union numbers)
	Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

procedure TLogicBase.DisplayResult;
var
	LItem: String;
begin
	for LItem in FLogicResult do
		Writeln(LItem);
	Writeln(Format('Total found: %d', [FLogicResult.Count]));
end;

constructor TLogicBase.Create;
begin
	FLogicResult := TLogicResult.Create;
end;

destructor TLogicBase.Destroy;
begin
	FLogicResult.Free;

	inherited;
end;

end.
