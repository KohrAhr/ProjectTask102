unit uLogic;

interface

uses
	uLogicBase;

type
	TLogic = class(TLogicBase)
	private
		FPatternLength: Integer;

		function CheckAll(APrefix: String = ''; ADepth: Integer = 1): Integer;
	public
		/// <summary>
		/// </summary>
		procedure Iterate(APatternLength: Integer; AOperations: String;
			ARequiredResult: String);
	end;

implementation

uses
	System.SysUtils,
	uExpressionHelper;

{ Logic }

procedure TLogic.Iterate(APatternLength: Integer; AOperations: String;
	ARequiredResult: String);
begin
	FPatternLength := APatternLength;
	FOperations := AOperations;
	FRequiredResult := ARequiredResult;

	CheckAll;
end;

function TLogic.CheckAll(APrefix: String = ''; ADepth: Integer = 1): Integer;
var
	LExpression: String;
	LResult: String;
	LCycle: Integer;
	LRequest: Integer;
begin
	if ADepth = FPatternLength then
		begin
			Result := 0;
			LExpression := APrefix + '0';

			// Sorry, we not interesting in div on Zero
			if ExpressionHelper.ExpressionIsSafe(LExpression) then
				begin
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
			for LCycle := 1 to FOperations.Length do
				LRequest := LRequest + CheckAll(
					APrefix + IntToStr(ADepth) + Trim(FOperations[LCycle]), ADepth + 1
				);
			Result := LRequest;
		end;
end;

end.
