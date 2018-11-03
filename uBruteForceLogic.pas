unit uBruteForceLogic;

interface

uses
	uLogicBase,
	System.Generics.Collections;

type
	TBruteForceLogic = class(TLogicBase)
	private
		FPattern: String;
	public
		/// <summary>
		/// </summary>
		procedure Iterate(APattern: String; AOperations: String;
			ARequiredResult: String);
	end;

implementation

uses
	System.SysUtils,
	uExpressionHelper;

{ TBruteForceLogic }

procedure TBruteForceLogic.Iterate(APattern: String; AOperations,
	ARequiredResult: String);
var
	l: Integer;
	z1, z2, z3, z4, z5, z6, z7, z8, z9: Integer;
	s: String;
	LExpression: String;
	LResult: String;
	LCycleTest: LongInt;
begin
	FPattern := APattern;
	FOperations := AOperations;
	FRequiredResult := ARequiredResult;

	LCycleTest := 0;
	l := Length(FOperations);
	for z1 := 1 to l do
		for z2 := 1 to l do
			for z3 := 1 to l do
				for z4 := 1 to l do
					for z5 := 1 to l do
						for z6 := 1 to l do
							for z7 := 1 to l do
								for z8 := 1 to l do
									for z9 := 1 to l do
										begin
											LCycleTest := LCycleTest + 1;

											// Build next option
											s := FOperations[z1] + FOperations[z2] + FOperations[z3] +
												FOperations[z4] + FOperations[z5] + FOperations[z6] +
												FOperations[z7] + FOperations[z8] + FOperations[z9];

											// Merge strings
											LExpression := MergeStrings(s, FPattern);

											// Skip not valid
											if not ExpressionHelper.ExpressionIsSafe(LExpression) then
												Continue;

											// Check value
											LResult := ExpressionHelper.Evaluate(LExpression);

											if LResult = FRequiredResult then
												FLogicResult.Add(LExpression);
										end;
	Writeln('Cycles: ', LCycleTest);
end;

end.
