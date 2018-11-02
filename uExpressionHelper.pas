unit uExpressionHelper;

interface

uses
	System.Bindings.EvalProtocol;

type
	ExpressionHelper = class
	private
		class var FScope: IScope;
	public
		/// <summary>
    ///  	Evaluate simple math operation
		/// </summary>
		class function Evaluate(AValue: String): String;
		class constructor Create;
	end;

implementation

uses
	System.Rtti,
	System.Bindings.Consts,
	System.Bindings.Evaluator,
	System.Bindings.EvalSys;

class constructor ExpressionHelper.Create;
begin
	FScope := TNestedScope.Create(BasicOperators, BasicConstants);
end;

class function ExpressionHelper.Evaluate(AValue: String): String;
var
	CompiledExpression: ICompiledBinding;
	Expression: String;
	Answer: TValue;
begin
	try
		Expression := AValue;
		CompiledExpression := Compile(Expression, FScope);
		Answer := CompiledExpression.Evaluate(FScope, nil, nil).GetValue;
	finally
		Result := Answer.ToString;
	end;
end;

end.
