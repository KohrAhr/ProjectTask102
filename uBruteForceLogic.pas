unit uBruteForceLogic;

interface

uses
	System.Generics.Collections;

type
	TBruteForceLogicResult = TList<String>;

	TBruteForceLogic = class
	private
		FLogicResult: TBruteForceLogicResult;
		FRequiredResult: String;
		FOperations: String;
		FPattern: String;

		function ExpressionInValid(AExpress: String): Boolean;
	public

		procedure DisplayResult;

		/// <summary>
		/// </summary>
		procedure Iterate(APattern: String; AOperations: String;
			ARequiredResult: String);

		constructor Create;
		destructor Destroy; override;
	end;

implementation

uses
  System.SysUtils, uExpressionHelper;

{ TBruteForceLogic }

procedure TBruteForceLogic.DisplayResult;
var
	LItem: String;
begin
	for LItem in FLogicResult do
		Writeln(LItem);
	Writeln(Format('Total found: %d', [FLogicResult.Count]));
end;

constructor TBruteForceLogic.Create;
begin
	FLogicResult := TBruteForceLogicResult.Create;
end;

destructor TBruteForceLogic.Destroy;
begin
	FLogicResult.Free;

	inherited;
end;

function MergeStrings(AInnerData, AOuterData: String): String;
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

	// Remove empty space
	Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

function TBruteForceLogic.ExpressionInValid(AExpress: String): Boolean;
begin
	Result := not AExpress.Contains('/0');
end;

procedure TBruteForceLogic.Iterate(APattern: String; AOperations,
	ARequiredResult: String);
var
	l,
	z1, z2, z3, z4, z5, z6, z7, z8, z9: Integer;
	s: String;
	LExpression: String;
	LResult: String;

//	v: array[1..8] of Integer;
begin
	FPattern := APattern;
	FOperations := AOperations;
	FRequiredResult := ARequiredResult;

	// Prepare data

	// Start
//	for z1 := 1 to Length(FOperations) do
//		begin
//			for z2 := 1 to Length(FOperations) do
//			begin
//
//			end;
//		end;


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
											s := FOperations[z1] + FOperations[z2] + FOperations[z3] +
												FOperations[z4] + FOperations[z5] + FOperations[z6] +
												FOperations[z7] + FOperations[z8] + FOperations[z9];

											// Merge strings
											LExpression := MergeStrings(s, FPattern);

											// Remove not valid
											if not ExpressionInValid(LExpression) then
												Continue;

											// Check value
											LResult := ExpressionHelper.Evaluate(LExpression);

											if LResult = FRequiredResult then
												FLogicResult.Add(LExpression);
										end;
end;

end.
