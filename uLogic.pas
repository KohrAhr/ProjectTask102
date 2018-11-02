unit uLogic;

interface

uses
	System.Generics.Collections;

type
	// TODO: не использовать TList, заменить позже на Interface IList
	TLogicResult = TList<String>;

	TLogic = class
	private
		FLogicResult: TLogicResult;
		FRequiredResult: String;
		FOperations: String;
		FPatternLength: Integer;

		function CheckAll(APrefix: String; ADepth: Integer): Integer;
	public

		procedure DisplayResult;

		/// <summary>
		/// </summary>
		procedure Iterate(APatternLength: Integer; AOperations: String;
			ARequiredResult: String);

		constructor Create;
		destructor Destroy; override;
	end;

implementation

uses
	System.SysUtils, uExpressionHelper;

{ Logic }

procedure TLogic.DisplayResult;
var
	LItem: String;
begin
	Writeln(Format('Total found: %d', [FLogicResult.Count]));
	for LItem in FLogicResult do
		Writeln(LItem);
end;

procedure TLogic.Iterate(APatternLength: Integer; AOperations: String;
	ARequiredResult: String);
begin
	FLogicResult := TLogicResult.Create;
	FPatternLength := APatternLength;
	FOperations := AOperations;
	FRequiredResult := ARequiredResult;

	CheckAll('', 1);
end;

function TLogic.CheckAll(APrefix: String; ADepth: Integer): Integer;
var
	LExpression: String;
	LOption: String;
	LResult: String;
	LCycle: Integer;
	LRequest: Integer;
begin
	if ADepth = FPatternLength then
		begin
			Result := 0;
			// Sorry, we not interesting in div on Zero
			if not APrefix.EndsWith('/') then
				begin
					LExpression := APrefix + '0';
					LResult := ExpressionHelper.Evaluate(LExpression);

					if LResult = FRequiredResult then
						begin
							FLogicResult.Add(LExpression);
							Result := 1;
						end
				end
		end
	else
		begin
			LRequest := 0;
			for LCycle := 1 to FOperations.Length + 1 do
				begin
					if LCycle <= FOperations.Length then
						LOption := FOperations[LCycle]
					else
						LOption := '';
					LRequest := LRequest + CheckAll(APrefix + IntToStr(ADepth) + LOption,
						ADepth + 1);
				end;
			Result := LRequest;
		end;
end;

constructor TLogic.Create;
begin
	FLogicResult := TLogicResult.Create;
end;

destructor TLogic.Destroy;
begin
	FLogicResult.Free;

	inherited;
end;

end.
